import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/task_provider.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  final List<Map<String, dynamic>> categoryConfig = const [
    {'name': 'Grocery', 'icon': Icons.local_grocery_store, 'color': AppTheme.mintGreen},
    {'name': 'Health', 'icon': Icons.favorite, 'color': AppTheme.peach},
    {'name': 'Work', 'icon': Icons.work, 'color': AppTheme.babyBlue},
    {'name': 'Personal', 'icon': Icons.person, 'color': AppTheme.lavender},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTasks = ref.watch(taskListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => context.pop(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.9,
        ),
        itemCount: categoryConfig.length,
        itemBuilder: (context, index) {
          final cat = categoryConfig[index];
          final count = allTasks.where((t) => t.category == cat['name']).length;
          
          return _CategoryCard(
            name: cat['name'],
            icon: cat['icon'],
            color: cat['color'],
            taskCount: count,
          ).animate().scale(delay: (100 * index).ms);
        },
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String name;
  final IconData icon;
  final Color color;
  final int taskCount;

  const _CategoryCard({
    required this.name,
    required this.icon,
    required this.color,
    required this.taskCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white54,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 32, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$taskCount Tasks',
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
