import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flowdeck/core/constants/app_constants.dart';
import 'package:flowdeck/presentation/screens/boards/boards_screen.dart';
import 'package:flowdeck/presentation/screens/tasks/tasks_screen.dart';
import 'package:flowdeck/presentation/screens/profile/profile_screen.dart';
import 'package:flowdeck/presentation/screens/notifications/notifications_screen.dart';

class MainWrapper extends ConsumerStatefulWidget {

  const MainWrapper({
    required this.child,
    super.key,
  });
  final Widget child;

  @override
  ConsumerState<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends ConsumerState<MainWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const BoardsScreen(),
    const TasksScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  final List<BottomNavigationBarItem> _navigationItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.dashboard_outlined),
      activeIcon: Icon(Icons.dashboard),
      label: AppStrings.boards,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.task_outlined),
      activeIcon: Icon(Icons.task),
      label: AppStrings.tasks,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.notifications_outlined),
      activeIcon: Icon(Icons.notifications),
      label: AppStrings.notifications,
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outlined),
      activeIcon: Icon(Icons.person),
      label: AppStrings.profile,
    ),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _navigationItems,
      ),
    );
}
