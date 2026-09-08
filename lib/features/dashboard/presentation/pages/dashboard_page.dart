import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/router/app_router.dart';
import '../../../../widgets/bottom_nav_bar.dart';

/// SheShield – Dashboard Shell
///
/// Main shell with custom bottom navigation that wraps all main tabs.
class DashboardPage extends StatefulWidget {
  final Widget child;

  const DashboardPage({super.key, required this.child});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  void _onNavTap(int index) {
    // Index 4 = SOS (full screen)
    if (index == 4) {
      context.push(AppRouter.sos);
      return;
    }

    setState(() => _currentIndex = index);

    switch (index) {
      case 0:
        context.go(AppRouter.home);
        break;
      case 1:
        context.go(AppRouter.tracking);
        break;
      case 2:
        context.go(AppRouter.contacts);
        break;
      case 3:
        context.go(AppRouter.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Detect current tab from location
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) _currentIndex = 0;
    if (location.startsWith('/tracking')) _currentIndex = 1;
    if (location.startsWith('/contacts')) _currentIndex = 2;
    if (location.startsWith('/profile')) _currentIndex = 3;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onNavTap,
      ),
    );
  }
}
