import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/summary_card.dart';
import '../../widgets/task_tile.dart';
import '../../providers/auth_provider.dart';
import '../../providers/task_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).userName ?? 'User';

    return Scaffold(
      backgroundColor: AppTheme.creamyWhite,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello $user 👋',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.darkText,
                        ),
                      ).animate().fade().slideX(),
                      const SizedBox(height: 4),
                      const Text(
                        'You have work today',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.lightText,
                        ),
                      ).animate().fade(delay: 200.ms),
                    ],
                  ),
                  const Spacer(),
                  CircleAvatar(
                     backgroundColor: AppTheme.babyBlue,
                     child: Text(user[0].toUpperCase()),
                  ).animate().scale(delay: 400.ms),
                ],
              ),
            ),

            // Summary Cards Carousel
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                   SummaryCard(
                    title: "Categories",
                    count: "View All",
                    icon: Icons.category,
                    color: AppTheme.lavender,
                    onTap: () => context.push('/categories'),
                   ),
                   const SizedBox(width: 16),
                   SummaryCard(
                    title: "Scheduled",
                    count: "3 Tasks",
                    icon: Icons.schedule,
                    color: AppTheme.babyBlue,
                     onTap: () {},
                   ),
                   const SizedBox(width: 16),
                    SummaryCard(
                    title: "Overdue",
                    count: "1 Task",
                    icon: Icons.warning_amber_rounded,
                    color: AppTheme.peach,
                     onTap: () {},
                   ),
                ],
              ).animate().fade(delay: 600.ms).slideX(begin: 0.2),
            ),
            
            const SizedBox(height: 32),

            // Today's Task List
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const Text(
                      "Today's Tasks",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.darkText,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Consumer(
                        builder: (context, ref, _) {
                          final tasks = ref.watch(todayTasksProvider);
                          if (tasks.isEmpty) {
                            return const Center(child: Text('No tasks for today!'));
                          }
                          return ListView.builder(
                            itemCount: tasks.length,
                            itemBuilder: (context, index) {
                              final task = tasks[index];
                              return TaskTile(
                                title: task.title,
                                time: "${task.date.hour}:${task.date.minute.toString().padLeft(2, '0')}", // Simple format
                                isCompleted: task.isCompleted,
                                onToggle: () => ref.read(taskListProvider.notifier).toggleTaskCompletion(task),
                                onTap: () {
                                  // Edit or view details
                                },
                              ).animate().fade(delay: (100 * index).ms).slideY(begin: 0.2);
                            },
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add-task');
        },
        child: const Icon(Icons.add),
      ).animate().scale(delay: 1000.ms),
    );
  }
}
