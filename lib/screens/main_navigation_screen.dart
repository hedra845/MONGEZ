import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_dashboard_screen.dart';
import 'dynamic_schedule_screen.dart';
import 'gamification_rewards_screen.dart';
import 'profile_screen.dart';
import 'more_features_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 2; // الرئيسية (Home) is active by default as shown in design

  late final List<Widget> _screens = [
    const MoreFeaturesScreen(),
    const DynamicScheduleScreen(),
    HomeDashboardScreen(
      onNavigateToSchedule: () => setState(() => _currentIndex = 1),
      onNavigateToRewards: () => setState(() => _currentIndex = 3),
    ),
    const GamificationRewardsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        height: 68,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF0F182A) : Colors.white,
          border: Border(
            top: BorderSide(
              color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFE2E8F0),
              width: 1.0,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0F2547).withValues(alpha: isDark ? 0.3 : 0.04),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0, "المزيد", Icons.grid_view_rounded, isDark),
            _buildNavItem(1, "الجدول", Icons.calendar_month_outlined, isDark),
            _buildNavItem(2, "الرئيسية", Icons.home_rounded, isDark),
            _buildNavItem(3, "النقاط", Icons.star_outline_rounded, isDark),
            _buildNavItem(4, "الملف الشخصي", Icons.person_outline_rounded, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon, bool isDark) {
    final isSelected = _currentIndex == index;
    const activeColor = Color(0xFF2563EB);
    final inactiveColor = isDark ? const Color(0xFF64748B) : const Color(0xFF8F9FB5);

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 23,
              color: isSelected ? activeColor : inactiveColor,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.cairo(
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                color: isSelected ? activeColor : inactiveColor,
              ),
            ),
            const SizedBox(height: 3),
            // Blue bottom indicator underline like the design
            Container(
              width: 22,
              height: 2.5,
              decoration: BoxDecoration(
                color: isSelected ? activeColor : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
