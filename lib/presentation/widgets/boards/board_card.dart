import 'package:flutter/material.dart';
import 'package:flowdeck/data/models/board_model.dart';
import 'package:flowdeck/core/constants/app_constants.dart';

class BoardCard extends StatelessWidget {
  final BoardModel board;
  final VoidCallback? onTap;

  const BoardCard({
    required this.board,
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                board.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (board.description.isNotEmpty) ...[
                const SizedBox(height: AppDimensions.xs),
                Text(
                  board.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              const SizedBox(height: AppDimensions.sm),
              Row(
                children: [
                  Icon(
                    Icons.task_alt,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: AppDimensions.xs),
                  Text(
                    '0 tasks', // TODO: Implement task count
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
