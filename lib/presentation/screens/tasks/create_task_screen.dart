import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flowdeck/core/constants/app_constants.dart';

class CreateTaskScreen extends ConsumerWidget {

  const CreateTaskScreen({
    super.key,
    this.boardId,
  });
  final String? boardId;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_task,
              size: 64,
              color: AppColors.onSurfaceVariant,
            ),
            SizedBox(height: AppDimensions.md),
            Text(
              'Create Task Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppDimensions.sm),
            Text(
              'Task creation form will be implemented here',
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
