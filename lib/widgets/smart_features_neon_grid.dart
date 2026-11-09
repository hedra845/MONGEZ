import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../screens/virtual_study_rooms_screen.dart';
import '../screens/active_timer_screen.dart';
import '../screens/bio_intelligence_screen.dart';
import '../screens/study_competition_screen.dart';
import '../screens/study_wallet_screen.dart';
import '../screens/interactive_learning_screen.dart';
import 'animated_theme_toggle_button.dart';

class SmartFeaturesNeonGrid extends StatelessWidget {
  final bool showHeader;

  const SmartFeaturesNeonGrid({
    super.key,
    this.showHeader = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0B1324) : Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: isDark ? const Color(0xFF1E2E46) : const Color(0xFFE2E8F0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.03),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showHeader) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Animated Light / Dark quick toggle button
                  AnimatedThemeToggleButton(
                    isDark: isDark,
                    onToggle: () => app.toggleTheme(),
                    showLabel: true,
                    size: 32,
                  ),

                  // Section Title
                  Row(
                    children: [
                      Text(
                        "أدوات التفوق الذكية",
                        style: GoogleFonts.cairo(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w800,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.stars_rounded, color: Color(0xFF2563EB), size: 18),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],

          // First Row: غرف الدراسة | المؤقت الذكي | الذكاء الحيوي
          Row(
            children: [
              // 1. غرف الدراسة
              Expanded(
                child: _buildAdaptiveCard(
                  context: context,
                  title: "غرف\nالدراسة",
                  icon: Icons.groups_rounded,
                  isDark: isDark,
                  lightBgGradient: const [Color(0xFFFAF5FF), Color(0xFFF3E8FF)],
                  darkBgGradient: const [Color(0xFF281156), Color(0xFF13092A)],
                  lightBorder: const Color(0xFFDDD6FE),
                  darkBorder: const Color(0xFF8B5CF6),
                  lightIconColor: const Color(0xFF7C3AED),
                  darkIconColor: const Color(0xFFC084FC),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const VirtualStudyRoomsScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),

              // 2. المؤقت الذكي
              Expanded(
                child: _buildAdaptiveCard(
                  context: context,
                  title: "المؤقت\nالذكي",
                  icon: Icons.timer_outlined,
                  isDark: isDark,
                  lightBgGradient: const [Color(0xFFF0F9FF), Color(0xFFE0F2FE)],
                  darkBgGradient: const [Color(0xFF072A4A), Color(0xFF031427)],
                  lightBorder: const Color(0xFFBAE6FD),
                  darkBorder: const Color(0xFF00B4D8),
                  lightIconColor: const Color(0xFF0284C7),
                  darkIconColor: const Color(0xFF38BDF8),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ActiveTimerScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),

              // 3. الذكاء الحيوي
              Expanded(
                child: _buildAdaptiveCard(
                  context: context,
                  title: "الذكاء\nالحيوي",
                  icon: Icons.psychology_rounded,
                  isDark: isDark,
                  lightBgGradient: const [Color(0xFFF0FDF4), Color(0xFFDCFCE7)],
                  darkBgGradient: const [Color(0xFF063F2F), Color(0xFF031E17)],
                  lightBorder: const Color(0xFFA7F3D0),
                  darkBorder: const Color(0xFF10B981),
                  lightIconColor: const Color(0xFF059669),
                  darkIconColor: const Color(0xFF34D399),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const BioIntelligenceScreen()),
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Second Row: المسابقة | محفظتي | التعلم التفاعلي
          Row(
            children: [
              // 4. المسابقة
              Expanded(
                child: _buildAdaptiveCard(
                  context: context,
                  title: "المسابقة",
                  icon: Icons.emoji_events_outlined,
                  isDark: isDark,
                  lightBgGradient: const [Color(0xFFFFFBEB), Color(0xFFFEF3C7)],
                  darkBgGradient: const [Color(0xFF452205), Color(0xFF221102)],
                  lightBorder: const Color(0xFFFDE68A),
                  darkBorder: const Color(0xFFF59E0B),
                  lightIconColor: const Color(0xFFD97706),
                  darkIconColor: const Color(0xFFFBBF24),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const StudyCompetitionScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),

              // 5. محفظتي (Study Coins)
              Expanded(
                child: _buildAdaptiveCard(
                  context: context,
                  title: "محفظتي\n(Study Coins)",
                  icon: Icons.account_balance_wallet_outlined,
                  isDark: isDark,
                  lightBgGradient: const [Color(0xFFECFEFF), Color(0xFFCFFAFE)],
                  darkBgGradient: const [Color(0xFF063A48), Color(0xFF031D24)],
                  lightBorder: const Color(0xFFA5F3FC),
                  darkBorder: const Color(0xFF06B6D4),
                  lightIconColor: const Color(0xFF0891B2),
                  darkIconColor: const Color(0xFF22D3EE),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const StudyWalletScreen()),
                    );
                  },
                ),
              ),
              const SizedBox(width: 8),

              // 6. التعلم التفاعلي
              Expanded(
                child: _buildAdaptiveCard(
                  context: context,
                  title: "التعلم\nالتفاعلي",
                  icon: Icons.view_in_ar_rounded,
                  isDark: isDark,
                  lightBgGradient: const [Color(0xFFF5F3FF), Color(0xFFEDE9FE)],
                  darkBgGradient: const [Color(0xFF341054), Color(0xFF19062B)],
                  lightBorder: const Color(0xFFDDD6FE),
                  darkBorder: const Color(0xFFA855F7),
                  lightIconColor: const Color(0xFF8B5CF6),
                  darkIconColor: const Color(0xFFE9D5FF),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const InteractiveLearningScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAdaptiveCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required bool isDark,
    required List<Color> lightBgGradient,
    required List<Color> darkBgGradient,
    required Color lightBorder,
    required Color darkBorder,
    required Color lightIconColor,
    required Color darkIconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        height: 104,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isDark ? darkBgGradient : lightBgGradient,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? darkBorder : lightBorder,
            width: isDark ? 1.5 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? darkBorder.withValues(alpha: 0.3)
                  : Colors.black.withValues(alpha: 0.02),
              blurRadius: isDark ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isDark ? darkIconColor : lightIconColor,
              size: 27,
            ),
            const SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: GoogleFonts.cairo(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
