import 'package:flutter/material.dart';
import '../../data/models/task_model.dart';
import '../../../core/theme/app_theme.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final Function(bool?) onToggle;
  final VoidCallback onTap;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = task.isCompleted;
    final isOverdue = task.dueDate != null && 
        task.dueDate!.isBefore(DateTime.now()) && 
        !isCompleted;

    Color borderColor = Colors.transparent;
    if (isOverdue) borderColor = theme.colorScheme.error;
    else if (isCompleted) borderColor = theme.colorScheme.onSurface.withOpacity(0.1);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: borderColor, width: isOverdue ? 1.5 : 1),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Checkbox with custom style
              Transform.scale(
                scale: 1.2,
                child: Checkbox(
                  value: isCompleted,
                  onChanged: onToggle,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  activeColor: AppTheme.success,
                  side: BorderSide(
                    color: isOverdue ? theme.colorScheme.error : theme.colorScheme.onSurface.withOpacity(0.4),
                    width: 1.5,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                         decoration: isCompleted ? TextDecoration.lineThrough : null,
                         color: isCompleted ? theme.disabledColor : theme.colorScheme.onSurface,
                      ),
                    ),
                    if (task.dueDate != null) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 14,
                            color: isOverdue ? theme.colorScheme.error : theme.textTheme.bodySmall?.color,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('MMM d, h:mm a').format(task.dueDate!),
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isOverdue ? theme.colorScheme.error : null,
                              fontWeight: isOverdue ? FontWeight.bold : null,
                            ),
                          ),
                           if (task.category.isNotEmpty) ...[
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                task.category,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
