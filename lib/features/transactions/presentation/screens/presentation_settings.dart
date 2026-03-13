import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:expense_tracker/core/providers/theme_provider.dart';

class PresentationSettingsScreen extends ConsumerWidget {
  const PresentationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF121212) : const Color(0xFFF8F9FB);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(context, isDark),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildProfileHeader(isDark),
            const SizedBox(height: 32),
            _buildSection(
              title: 'PREFERENCES',
              children: [
                _buildSettingsTile(
                  icon: Icons.nightlight_round_rounded,
                  iconColor: const Color(0xFF6C63FF),
                  title: 'Dark Appearance',
                  trailing: Switch(
                    value: ref.watch(themeProvider) == ThemeMode.dark,
                    onChanged: (v) {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                    activeTrackColor: const Color(0xFF6C63FF),
                  ),
                  isDark: isDark,
                ),
                _buildSettingsTile(
                  icon: Icons.payments_rounded,
                  iconColor: const Color(0xFF6C63FF),
                  title: 'Default Currency',
                  subtitle: 'USD (\$)',
                  onTap: () {},
                  isDark: isDark,
                  showChevron: true,
                ),
              ],
              isDark: isDark,
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'FINANCIAL',
              children: [
                _buildSettingsTile(
                  icon: Icons.account_balance_rounded,
                  iconColor: const Color(0xFF6C63FF),
                  title: 'Linked Accounts',
                  subtitle: '3 banks connected',
                  onTap: () {},
                  isDark: isDark,
                  showChevron: true,
                ),
                _buildSettingsTile(
                  icon: Icons.ios_share_rounded,
                  iconColor: const Color(0xFF6C63FF),
                  title: 'Export Data (CSV/PDF)',
                  onTap: () {},
                  isDark: isDark,
                  showChevron: true,
                ),
              ],
              isDark: isDark,
            ),
            const SizedBox(height: 24),
            _buildSection(
              title: 'SECURITY & SUPPORT',
              children: [
                _buildSettingsTile(
                  icon: Icons.fingerprint_rounded,
                  iconColor: const Color(0xFF6C63FF),
                  title: 'FaceID / TouchID',
                  trailing: Switch(
                    value: true,
                    onChanged: (v) {},
                    activeTrackColor: const Color(0xFF6C63FF),
                  ),
                  isDark: isDark,
                ),
                _buildSettingsTile(
                  icon: Icons.help_outline_rounded,
                  iconColor: const Color(0xFF6C63FF),
                  title: 'Support Center',
                  onTap: () {},
                  isDark: isDark,
                  showChevron: true,
                ),
              ],
              isDark: isDark,
            ),
            const SizedBox(height: 40),
            _buildLogoutButton(isDark),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isDark) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        onPressed: () => context.pop(),
      ),
      title: const Text(
        'Settings',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.notifications_rounded, size: 24, color: isDark ? Colors.white : Colors.black87),
              Positioned(
                top: 14,
                right: 2,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader(bool isDark) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF6C63FF).withValues(alpha: 0.2), width: 2),
              ),
              child: const CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1599566150163-29194dcaad36?ixlib=rb-4.0.3&auto=format&fit=crop&w=256&q=80'),
              ),
            ),
            Positioned(
              bottom: 4,
              right: 4,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF6C63FF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.edit_rounded, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Alex Harrison',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Icon(Icons.verified_rounded, color: Color(0xFF6C63FF), size: 20),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF6C63FF).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'PREMIUM MEMBER',
            style: TextStyle(
              color: Color(0xFF6C63FF),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Member since Jan 2023',
          style: TextStyle(color: Colors.grey.withValues(alpha: 0.6), fontSize: 13),
        ),
      ],
    ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildSection({required String title, required List<Widget> children, required bool isDark}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.grey.withValues(alpha: 0.6),
              letterSpacing: 1,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.03) : Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: isDark
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    Widget? trailing,
    required bool isDark,
    bool showChevron = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: iconColor, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey.withValues(alpha: 0.6), fontSize: 13),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing
            else if (showChevron)
              Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey.withValues(alpha: 0.4)),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(bool isDark) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFFFEBEB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(20),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_rounded, color: Color(0xFFFF4D4D), size: 20),
                  SizedBox(width: 12),
                  Text(
                    'Log Out',
                    style: TextStyle(
                      color: Color(0xFFFF4D4D),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
        ),
      ),
    ).animate().fadeIn(duration: 800.ms, delay: 400.ms);
  }
}
