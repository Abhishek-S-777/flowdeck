import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flowdeck/core/constants/app_constants.dart';

class TaskDetailScreen extends ConsumerWidget {

  const TaskDetailScreen({
    required this.taskId, super.key,
  });
  final String taskId;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Edit task
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task_outlined,
              size: 64,
              color: AppColors.onSurfaceVariant,
            ),
            SizedBox(height: AppDimensions.md),
            Text(
              'Task Detail Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppDimensions.sm),
            Text(
              'Task details will be implemented here',
              style: TextStyle(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
}
