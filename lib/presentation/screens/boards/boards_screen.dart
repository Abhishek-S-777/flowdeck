import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flowdeck/core/constants/app_constants.dart';
import 'package:flowdeck/core/routing/app_router.dart';
import 'package:flowdeck/presentation/viewmodels/board_viewmodel.dart';
import 'package:flowdeck/presentation/widgets/boards/board_card.dart';
import 'package:flowdeck/presentation/widgets/common/empty_state.dart';

class BoardsScreen extends ConsumerStatefulWidget {
  const BoardsScreen({super.key});

  @override
  ConsumerState<BoardsScreen> createState() => _BoardsScreenState();
}

class _BoardsScreenState extends ConsumerState<BoardsScreen> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boards = ref.watch(boardsViewModelProvider);
    final searchQuery = ref.watch(boardSearchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Boards'),
        centerTitle: false,
      ),
      body: Column(
        children: [
          // Search Bar
          if (_searchController.text.isNotEmpty || searchQuery.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(AppDimensions.md),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search boards...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
                onChanged: (query) {
                  ref
                      .read(boardSearchQueryProvider.notifier)
                      .updateQuery(query);
                },
              ),
            ),

          // Boards List
          Expanded(
            child: boards.isEmpty
                ? EmptyState(
                    icon: Icons.dashboard_outlined,
                    title: searchQuery.isEmpty
                        ? 'No boards yet'
                        : 'No boards found',
                    subtitle: searchQuery.isEmpty
                        ? 'Create your first board to get started'
                        : 'Try adjusting your search terms',
                    actionLabel: searchQuery.isEmpty ? 'Create Board' : null,
                    onAction: searchQuery.isEmpty
                        ? () => context.push(AppRoutes.createBoard)
                        : null,
                  )
                : RefreshIndicator(
                    onRefresh: () async {
                      ref.invalidate(boardsViewModelProvider);
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(AppDimensions.md),
                      itemCount: boards.length,
                      itemBuilder: (context, index) {
                        final board = boards[index];
                        return Padding(
                          padding:
                              const EdgeInsets.only(bottom: AppDimensions.md),
                          child: BoardCard(
                            board: board,
                            onTap: () => context.push(
                              AppRoutes.boardDetail
                                  .replaceFirst(':boardId', board.id),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.createBoard),
        child: const Icon(Icons.add),
      ),
    );
  }
}
