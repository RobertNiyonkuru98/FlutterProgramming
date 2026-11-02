import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A reusable custom card widget for the COVID-19 dashboard.
/// Displays the metric [title], custom [icon], and formats the numeric [count]
/// using the `intl` package's [NumberFormat] class.
class CovidCard extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color color;

  const CovidCard({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Format the number with commas (e.g., 9231249 -> "9,231,249")
    final String formattedCount = NumberFormat.decimalPattern().format(count);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 22.0),
      decoration: BoxDecoration(
        color: const Color(0xFF222222), // Dark card surface
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side: Metric Title and Icon
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 12),
              Icon(
                icon,
                color: color,
                size: 38,
              ),
            ],
          ),

          // Right side: Formatted Count String
          Text(
            formattedCount,
            style: TextStyle(
              color: color.withValues(alpha: 0.95),
              fontSize: 26,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
