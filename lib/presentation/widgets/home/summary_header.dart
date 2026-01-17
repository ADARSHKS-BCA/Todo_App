import 'package:flutter/material.dart';

class SummaryHeader extends StatelessWidget {
  final int todayCount;
  final int overdueCount;
  final int upcomingCount;

  const SummaryHeader({
    super.key,
    required this.todayCount,
    required this.overdueCount,
    required this.upcomingCount,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard(context, 'Overdue', overdueCount, theme.colorScheme.error),
              const SizedBox(width: 12),
              _buildStatCard(context, 'Today', todayCount, theme.colorScheme.primary),
             // const SizedBox(width: 12),
             // _buildStatCard(context, 'Upcoming', upcomingCount, theme.colorScheme.tertiary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, int count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count.toString(),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                color: color,
                height: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
