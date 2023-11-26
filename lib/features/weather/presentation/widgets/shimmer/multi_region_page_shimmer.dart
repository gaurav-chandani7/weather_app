import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weather_app/core/constants/color_constants.dart';

class MultiRegionListPageShimmer extends StatelessWidget {
  const MultiRegionListPageShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: shimmerBaseColor,
        highlightColor: shimmerHighlightColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: ListView.separated(
            itemCount: 8,
            separatorBuilder: (context, index) => const Divider(
              thickness: 0.5,
            ),
            itemBuilder: (context, index) => Container(
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: shimmerInnerContainerColor,
                  boxShadow: kElevationToShadow[3]),
            ),
          ),
        ));
  }
}
