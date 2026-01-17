import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../data/models/task_model.dart';
import '../../widgets/home/summary_header.dart';
import '../../widgets/task_card.dart';
import '../../providers/task_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String _filter = 'All'; // All, Pending, Completed

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final displayedTasks = ref.watch(filteredTasksProvider(_filter));
    final todayCount = ref.watch(todayCountProvider);
    final overdueCount = ref.watch(overdueCountProvider);
    final upcomingCount = ref.watch(upcomingCountProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header & Stats
              SummaryHeader(
                todayCount: todayCount,
                overdueCount: overdueCount,
                upcomingCount: upcomingCount,
              ).animate().fadeIn().slideY(begin: -0.2, end: 0),

              // Filter Tabs
              Container(
                height: 40,
                margin: const EdgeInsets.only(bottom: 16),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: ['All', 'Pending', 'Completed'].map((filter) {
                    final isSelected = _filter == filter;
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: ChoiceChip(
                        label: Text(filter),
                        selected: isSelected,
                        onSelected: (selected) {
                          if (selected) setState(() => _filter = filter);
                        },
                        selectedColor: theme.colorScheme.primaryContainer,
                        labelStyle: TextStyle(
                          color: isSelected ? theme.colorScheme.primary : theme.textTheme.bodyMedium?.color,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                        showCheckmark: false,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                         side: BorderSide.none,
                         backgroundColor: theme.cardColor,
                      ),
                    );
                  }).toList(),
                ),
              ).animate().fadeIn(delay: 200.ms),

              // Task List or Empty State
              Expanded(
                child: displayedTasks.isEmpty
                    ? _buildEmptyState(context)
                    : ListView.builder(
                        itemCount: displayedTasks.length,
                        padding: const EdgeInsets.only(bottom: 100),
                        itemBuilder: (context, index) {
                          final task = displayedTasks[index];
                          // Use a Key to ensure proper deletion animation/state
                          return Dismissible(
                            key: Key(task.id),
                            background: Container(
                              alignment: Alignment.centerRight,
                              color: theme.colorScheme.error,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
                            ),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              ref.read(taskListProvider.notifier).deleteTask(task.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text('Task deleted'),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      // TODO: Implement proper undo via Repository restoration or soft delete
                                      // For now re-add
                                      ref.read(taskListProvider.notifier).addTask(
                                        title: task.title,
                                        description: task.description,
                                        date: task.date,
                                        category: task.category,
                                        priority: task.priority,
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                            child: TaskCard(
                              task: task,
                              onToggle: (val) {
                                ref.read(taskListProvider.notifier).toggleTaskCompletion(task);
                              },
                              onTap: () {
                                // TODO: Navigate to Edit Task
                              },
                            ).animate().fadeIn(delay: (50 * index).ms).slideX(),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/add-task'),
        icon: const Icon(Icons.add_rounded),
        label: const Text('New Task'),
      ).animate().scale(delay: 500.ms),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.checklist_rounded, size: 80, color: Theme.of(context).disabledColor)
              .animate().scale(duration: 600.ms, curve: Curves.elasticOut),
          const SizedBox(height: 16),
          Text(
            'No tasks found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Keep it up! clear your mind.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
