import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../widgets/add_transaction_modal.dart';

class PresentationDashboardScreen extends ConsumerStatefulWidget {
  final StatefulNavigationShell navigationShell;
  const PresentationDashboardScreen({super.key, required this.navigationShell});

  @override
  ConsumerState<PresentationDashboardScreen> createState() =>
      _PresentationDashboardScreenState();
}

class _PresentationDashboardScreenState
    extends ConsumerState<PresentationDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FB),
      body: widget.navigationShell,
      bottomNavigationBar: _buildBottomNav(theme, isDark),
      floatingActionButton: _buildAddButton(theme),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildBottomNav(ThemeData theme, bool isDark) {
    return BottomAppBar(
      height: 70,
      notchMargin: 8,
      shape: const CircularNotchedRectangle(),
      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home_filled, 'HOME', widget.navigationShell.currentIndex == 0, 0, theme),
          _buildNavItem(Icons.pie_chart_rounded, 'STATS', widget.navigationShell.currentIndex == 1, 1, theme),
          const SizedBox(width: 40),
          _buildNavItem(Icons.account_balance_wallet_rounded, 'WALLET', widget.navigationShell.currentIndex == 2, 2, theme),
          _buildNavItem(Icons.person_rounded, 'PROFILE', widget.navigationShell.currentIndex == 3, 3, theme),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    bool isActive,
    int index,
    ThemeData theme,
  ) {
    return GestureDetector(
      onTap: () => widget.navigationShell.goBranch(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive
                ? theme.colorScheme.primary
                : Colors.grey.withValues(alpha: 0.5),
            size: 26,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: isActive
                  ? theme.colorScheme.primary
                  : Colors.grey.withValues(alpha: 0.5),
              fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton(ThemeData theme) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [Color(0xFF6C63FF), Color(0xFF4B4B9D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withValues(alpha: 0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: IconButton(
        icon: const Icon(Icons.add, color: Colors.white, size: 32),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const AddTransactionModal(),
          );
        },
      ),
    );
  }
}
