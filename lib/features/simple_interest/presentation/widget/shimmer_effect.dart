import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerCard(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Shimmer.fromColors(
    baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
    highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 12, width: 150, color: Colors.white),
            const SizedBox(height: 10),
            Container(height: 12, width: 120, color: Colors.white),
            const SizedBox(height: 10),
            Container(height: 12, width: 100, color: Colors.white),
            const Divider(),
            Container(height: 14, width: 180, color: Colors.white),
            const SizedBox(height: 10),
            Container(height: 14, width: 200, color: Colors.white),
          ],
        ),
      ),
    ),
  );
}
