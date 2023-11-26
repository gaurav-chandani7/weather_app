import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/core/constants/color_constants.dart';

class CurrentWeatherPageShimmer extends StatelessWidget {
  const CurrentWeatherPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: shimmerBaseColor,
        highlightColor: shimmerHighlightColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: shimmerInnerContainerColor,
                    boxShadow: kElevationToShadow[3]),
              ),
              const Divider(
                thickness: 0.5,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: shimmerInnerContainerColor,
                    boxShadow: kElevationToShadow[3]),
              ),
              const Divider(
                thickness: 0.5,
              ),
              Container(
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: shimmerInnerContainerColor,
                    boxShadow: kElevationToShadow[3]),
              ),
              const Divider(
                thickness: 0.5,
              ),
              Container(
                height: 170,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: shimmerInnerContainerColor,
                    boxShadow: kElevationToShadow[3]),
              )
            ],
          ),
        ));
  }
}
