import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/primary_button.dart';
import '../../providers/task_provider.dart';

class AddTaskScreen extends ConsumerStatefulWidget {
  const AddTaskScreen({super.key});

  @override
  ConsumerState<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends ConsumerState<AddTaskScreen> {
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController(); 
  DateTime _selectedDate = DateTime.now();
  String _priority = 'Medium'; 

  @override
  void dispose() {
    _titleController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _saveTask() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    await ref.read(taskListProvider.notifier).addTask(
      title: title,
      date: _selectedDate,
      category: _categoryController.text.trim().isEmpty ? 'General' : _categoryController.text.trim(),
      priority: _priority,
    );

    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Task'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Task Title
            TextField(
              controller: _titleController,
              autofocus: true,
              style: theme.textTheme.headlineMedium,
              decoration: const InputDecoration(
                hintText: 'What needs to be done?',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                fillColor: Colors.transparent, 
              ),
              maxLines: null,
            ),
            
            const SizedBox(height: 32),
            
            // 2. Priority
            Text('Priority', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            Row(
              children: ['High', 'Medium', 'Low'].map((p) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ChoiceChip(
                    label: Text(p),
                    selected: _priority == p,
                    onSelected: (selected) => setState(() => _priority = p),
                     selectedColor: p == 'High' ? AppTheme.error.withOpacity(0.2) 
                         : p == 'Medium' ? AppTheme.warning.withOpacity(0.2)
                         : AppTheme.success.withOpacity(0.2),
                     labelStyle: TextStyle(
                       color: _priority == p ? Colors.black : theme.disabledColor,
                       fontWeight: FontWeight.bold,
                     ),
                  ),
                ),
              )).toList(),
            ),

            const SizedBox(height: 24),

            // 3. Date
            Text('Due Date', style: theme.textTheme.titleMedium),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) setState(() => _selectedDate = date);
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: theme.dividerColor),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today_rounded),
                    const SizedBox(width: 12),
                    Text(
                      DateFormat('EEE, MMM d, y').format(_selectedDate),
                      style: theme.textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 24),
             
             // 4. Category
             Text('Category', style: theme.textTheme.titleMedium),
             const SizedBox(height: 12),
              TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                hintText: 'e.g. Work, Personal',
                prefixIcon: Icon(Icons.label_outline_rounded),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: PrimaryButton(
          text: 'Create Task',
          onPressed: _saveTask,
        ),
      ),
    );
  }
}
