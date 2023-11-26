import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/core/constants/color_constants.dart';

class DailyForecastShimmer extends StatelessWidget {
  const DailyForecastShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: shimmerBaseColor,
        highlightColor: shimmerHighlightColor,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Container(
              height: 420,
              decoration: BoxDecoration(
                  color: Colors.brown.shade200,
                  boxShadow: kElevationToShadow[3],
                  borderRadius: BorderRadius.circular(5)),
            )));
  }
}
