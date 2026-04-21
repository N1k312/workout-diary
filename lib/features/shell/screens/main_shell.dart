import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/router/route_paths.dart';

class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.child});

  final Widget child;

  static const _tabs = [
    AppRoutes.home,
    AppRoutes.history,
    AppRoutes.exercises,
    AppRoutes.profile,
  ];

  int _selectedIndex(String location) {
    if (location.startsWith(AppRoutes.home)) return 0;
    if (location.startsWith(AppRoutes.history)) return 1;
    if (location.startsWith(AppRoutes.exercises)) return 2;
    if (location.startsWith(AppRoutes.profile)) return 3;
    return -1;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;
    final selected = _selectedIndex(location);

    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: child,
      bottomNavigationBar: Container(
        height: 64 + MediaQuery.paddingOf(context).bottom,
        decoration: const BoxDecoration(
          color: AppColors.bgPrimary,
          border: Border(
            top: BorderSide(color: AppColors.borderDefault, width: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _NavItem(
              icon: LucideIcons.home,
              isSelected: selected == 0,
              onTap: () => context.go(_tabs[0]),
            ),
            _NavItem(
              icon: LucideIcons.layoutList,
              isSelected: selected == 1,
              onTap: () => context.go(_tabs[1]),
            ),
            _StartButton(onTap: () => context.push(AppRoutes.workoutStart)),
            _NavItem(
              icon: LucideIcons.dumbbell,
              isSelected: selected == 2,
              onTap: () => context.go(_tabs[2]),
            ),
            _NavItem(
              icon: LucideIcons.user,
              isSelected: selected == 3,
              onTap: () => context.go(_tabs[3]),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 48,
        height: 64,
        child: Center(
          child: Icon(
            icon,
            size: 22,
            color: isSelected ? AppColors.accentPrimary : AppColors.textTertiary,
          ),
        ),
      ),
    );
  }
}

class _StartButton extends StatelessWidget {
  const _StartButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: AppColors.accentPrimary,
          borderRadius: BorderRadius.all(Radius.circular(999)),
        ),
        child: const Icon(
          LucideIcons.plus,
          size: 20,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
