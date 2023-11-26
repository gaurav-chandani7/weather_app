import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/core.dart';
import 'package:weather_app/dependencies_injection.dart';
import 'package:weather_app/features/features.dart';
import 'package:weather_app/features/weather/presentation/cubit/multi_region/multi_region_cubit.dart';
import 'package:weather_app/utils/utils.dart';

class MultiRegionScreen extends StatelessWidget {
  const MultiRegionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<MultiRegionCubit>()..fetchWeatherOfMultipleRegions(),
      child: Parent(child: BlocBuilder<MultiRegionCubit, MultiRegionState>(
        builder: (context, state) {
          if (state is MultiRegionSuccess) {
            var data = state.listData!;
            return _getMultiRegionListSuccessUI(data);
          }
          if (state is MultiRegionLoading) {
            return const MultiRegionListPageShimmer();
          }
          if (state is MultiRegionFailure) {
            return CommonPageErrorWidget(
              message: state.message,
            );
          }
          return const SizedBox();
        },
      )),
    );
  }

  ListView _getMultiRegionListSuccessUI(List<CurrentWeatherEntity> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          var item = data[index];
          return InkWell(
            onTap: () {
              context.push(Parent(
                appBar: AppBar(),
                child: CurrentLocationWeatherScreen(
                  locationParams:
                      LocationParams(lat: item.coord.lat, lon: item.coord.lon),
                ),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    item.name ?? '',
                    style: const TextStyle(fontSize: 15),
                  ),
                  Row(
                    children: [
                      Text(
                        "${item.main.temp.round()}°C",
                        style: const TextStyle(fontSize: 15),
                      ),
                      Image(
                        image: NetworkImage(
                            "$iconBaseUrl/${item.weather.first.icon}.png"),
                        height: 50,
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
