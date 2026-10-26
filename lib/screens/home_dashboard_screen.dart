import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import 'active_timer_screen.dart';
import 'distraction_lock_screen.dart';
import 'ai_quiz_generation_screen.dart';
import 'gamification_rewards_screen.dart';
import 'habits_tracker_screen.dart';
import 'session_setup_screen.dart';
import 'notifications_screen.dart';

class HomeDashboardScreen extends StatelessWidget {
  final VoidCallback? onNavigateToSchedule;
  final VoidCallback? onNavigateToRewards;

  const HomeDashboardScreen({
    super.key,
    this.onNavigateToSchedule,
    this.onNavigateToRewards,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0B1324) : const Color(0xFFF6F8FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // =======================================================
              // 1. Top Header Bar (شريط الترويسة العلوي)
              // =======================================================
              _buildTopHeader(context, app, isDark),

              const SizedBox(height: 14),

              // =======================================================
              // 2. Goal & Motivation Card (كارت الهدف اليومي مع الجبل والراية)
              // =======================================================
              _buildGoalAndMotivationCard(context, app, isDark),

              const SizedBox(height: 18),

              // =======================================================
              // 3. Study Schedule Section (جدول المذاكرة)
              // =======================================================
              _buildStudyScheduleSection(context, app, isDark),

              const SizedBox(height: 18),

              // =======================================================
              // 4. Middle Widgets: Study Timer & 2x2 Feature Grid
              // =======================================================
              _buildMiddleWidgetsRow(context, app, isDark),

              const SizedBox(height: 18),

              // =======================================================
              // 5. Progress in Subjects (تقدمك في المواد)
              // =======================================================
              _buildSubjectsProgressSection(context, app, isDark),

              const SizedBox(height: 16),

              // =======================================================
              // 6. Encouragement Banner (بانر التحفيز والاستمرار)
              // =======================================================
              _buildEncouragementBanner(context, isDark),

              const SizedBox(height: 14),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top Header Bar
  // ---------------------------------------------------------------------------
  Widget _buildTopHeader(BuildContext context, AppProvider app, bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // User Profile & Greeting
        Expanded(
          child: Row(
            children: [
              // Avatar
              CircleAvatar(
                radius: 19,
                backgroundColor: const Color(0xFF3B82F6).withValues(alpha: 0.15),
                child: const Icon(Icons.person_rounded, color: Color(0xFF2563EB), size: 22),
              ),

              const SizedBox(width: 10),

              // User Info
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "مرحبا ${app.userName.split(' ').first}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                        height: 1.1,
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            "مستمر في طريق النجاح",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.cairo(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF64748B),
                              height: 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Text("💪", style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // Bell Notification with live badge
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.notifications_none_rounded,
                  size: 22,
                  color: isDark ? Colors.white70 : const Color(0xFF475569),
                ),
              ),
              if (app.unreadNotificationsCount > 0)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark ? const Color(0xFF0B1324) : Colors.white,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Goal & Motivation Card with Mountain Illustration
  // ---------------------------------------------------------------------------
  Widget _buildGoalAndMotivationCard(BuildContext context, AppProvider app, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF131D33) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Right Column in RTL: Daily Goal & Progress Bar
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "هدفك اليوم",
                  style: GoogleFonts.cairo(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "إكمال ${app.dailyGoalHours} ساعات مذاكرة",
                  style: GoogleFonts.cairo(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: app.completedGoalHours / app.dailyGoalHours,
                          backgroundColor:
                              isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "${app.completedGoalHours}/${app.dailyGoalHours}",
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white70 : const Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Center: Mountain Peak with Flag Graphic
          Expanded(
            flex: 3,
            child: Center(
              child: SizedBox(
                width: 70,
                height: 58,
                child: CustomPaint(
                  painter: MountainFlagPainter(),
                ),
              ),
            ),
          ),

          // Left Column in RTL: Date & Quote
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "السبت، 26 أكتوبر 2026",
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.calendar_today_rounded, size: 13, color: Color(0xFF64748B)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  "\"كل مجهود صغير اليوم\nيصنع فرقا كبيرا غدا.\"",
                  textAlign: TextAlign.end,
                  style: GoogleFonts.cairo(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Study Schedule Section
  // ---------------------------------------------------------------------------
  Widget _buildStudyScheduleSection(BuildContext context, AppProvider app, bool isDark) {
    return Column(
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onNavigateToSchedule,
              child: Row(
                children: [
                  const Icon(Icons.chevron_left_rounded, size: 16, color: Color(0xFF2563EB)),
                  Text(
                    "عرض الكل",
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2563EB),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "جدول المذاكرة",
                  style: GoogleFonts.cairo(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.calendar_month_outlined, size: 18, color: Color(0xFF2563EB)),
              ],
            ),
          ],
        ),

        const SizedBox(height: 8),

        // Schedule Items List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: app.sessions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final session = app.sessions[index];
            return _buildScheduleItemCard(context, session, isDark);
          },
        ),
      ],
    );
  }

  Widget _buildScheduleItemCard(BuildContext context, StudySession session, bool isDark) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => SessionSetupScreen(session: session)),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF131D33) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.015),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Chevron
            const Icon(Icons.chevron_left_rounded, size: 16, color: Color(0xFF94A3B8)),
            const SizedBox(width: 6),

            // Status Badge
            _buildStatusBadge(session.status),

            const Spacer(),

            // Time Range
            Text(
              session.timeRange,
              style: GoogleFonts.cairo(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              ),
            ),

            const SizedBox(width: 10),

            // Subject Title
            Expanded(
              child: Text(
                session.subject,
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
            ),

            const SizedBox(width: 8),

            // Subject Icon
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: session.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(session.icon, color: session.color, size: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(SessionStatus status) {
    switch (status) {
      case SessionStatus.completed:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFF10B981).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, size: 12, color: Color(0xFF10B981)),
              const SizedBox(width: 4),
              Text(
                "تم الانتهاء",
                style: GoogleFonts.cairo(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
        );
      case SessionStatus.inProgress:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFF2563EB).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.circle, size: 8, color: Color(0xFF2563EB)),
              const SizedBox(width: 4),
              Text(
                "جاري الآن",
                style: GoogleFonts.cairo(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2563EB),
                ),
              ),
            ],
          ),
        );
      case SessionStatus.upcoming:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFF64748B).withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.schedule_rounded, size: 11, color: Color(0xFF64748B)),
              const SizedBox(width: 4),
              Text(
                "قادم",
                style: GoogleFonts.cairo(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF64748B),
                ),
              ),
            ],
          ),
        );
    }
  }

  // ---------------------------------------------------------------------------
  // Middle Widgets Row: Timer Card + 2x2 Quick Feature Grid
  // ---------------------------------------------------------------------------
  Widget _buildMiddleWidgetsRow(BuildContext context, AppProvider app, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left Column: Study Timer Card
        Expanded(
          flex: 48,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF131D33) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "مؤقت المذاكرة",
                      style: GoogleFonts.cairo(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.timer_outlined, size: 16, color: Color(0xFF2563EB)),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  "25:00",
                  style: GoogleFonts.poppins(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                    letterSpacing: 1.5,
                  ),
                ),
                Text(
                  "🎯 ركّز .. أنت تستطيع",
                  style: GoogleFonts.cairo(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 38,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      app.startTimer();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const ActiveTimerScreen()),
                      );
                    },
                    icon: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 18),
                    label: Text(
                      "ابدأ الآن",
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2563EB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Right Column: 2x2 Quick Feature Grid
        Expanded(
          flex: 52,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: _buildQuickFeatureBox(
                      context: context,
                      title: "الاختبارات",
                      subtitle: "اختبر معلوماتك",
                      icon: Icons.assignment_outlined,
                      bgColor: isDark ? const Color(0xFF132238) : const Color(0xFFEFF6FF),
                      accentColor: const Color(0xFF2563EB),
                      isDark: isDark,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const AiQuizGenerationScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildQuickFeatureBox(
                      context: context,
                      title: "قفل المشتتات",
                      subtitle: "ركّز على هدفك",
                      icon: Icons.lock_outline_rounded,
                      bgColor: isDark ? const Color(0xFF2A1520) : const Color(0xFFFFF1F2),
                      accentColor: const Color(0xFFF43F5E),
                      isDark: isDark,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const DistractionLockScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickFeatureBox(
                      context: context,
                      title: "نظام النقاط",
                      subtitle: "اكسب نقاطك",
                      icon: Icons.star_rounded,
                      bgColor: isDark ? const Color(0xFF2B2213) : const Color(0xFFFFFBEB),
                      accentColor: const Color(0xFFF59E0B),
                      isDark: isDark,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const GamificationRewardsScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _buildQuickFeatureBox(
                      context: context,
                      title: "دعم نفسي",
                      subtitle: "كُن أقوى دائماً",
                      icon: Icons.psychology_outlined,
                      bgColor: isDark ? const Color(0xFF1E1730) : const Color(0xFFFAF5FF),
                      accentColor: const Color(0xFF9333EA),
                      isDark: isDark,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const HabitsTrackerScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickFeatureBox({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color bgColor,
    required Color accentColor,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        constraints: const BoxConstraints(minHeight: 74),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: accentColor.withValues(alpha: isDark ? 0.3 : 0.15),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: accentColor, size: 20),
            const SizedBox(height: 2),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cairo(
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
                height: 1.15,
              ),
            ),
            Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cairo(
                fontSize: 8.5,
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Progress in Subjects (تقدمك في المواد)
  // ---------------------------------------------------------------------------
  Widget _buildSubjectsProgressSection(BuildContext context, AppProvider app, bool isDark) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: onNavigateToSchedule,
              child: Row(
                children: [
                  const Icon(Icons.chevron_left_rounded, size: 16, color: Color(0xFF2563EB)),
                  Text(
                    "عرض الكل",
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2563EB),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  "تقدمك في المواد",
                  style: GoogleFonts.cairo(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : const Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(Icons.bar_chart_rounded, size: 18, color: Color(0xFF2563EB)),
              ],
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Horizontal Subject Cards
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true, // RTL natural flow
          child: Row(
            children: app.subjectsProgress.map((sub) {
              return Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Container(
                  width: 96,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF131D33) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(sub.icon, color: sub.color, size: 16),
                          Expanded(
                            child: Text(
                              sub.name,
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.cairo(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "${sub.percentage}%",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: sub.percentage / 100,
                          backgroundColor:
                              isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                          valueColor: AlwaysStoppedAnimation<Color>(sub.color),
                          minHeight: 4,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Encouragement Banner
  // ---------------------------------------------------------------------------
  Widget _buildEncouragementBanner(BuildContext context, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF102820) : const Color(0xFFECFDF5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF10B981).withValues(alpha: 0.25),
        ),
      ),
      child: Row(
        children: [
          // Left chevron
          const Icon(Icons.chevron_left_rounded, size: 18, color: Color(0xFF10B981)),

          const Spacer(),

          // Middle text
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "أنت على الطريق الصحيح!",
                style: GoogleFonts.cairo(
                  fontSize: 12.5,
                  fontWeight: FontWeight.bold,
                  color: isDark ? const Color(0xFF34D399) : const Color(0xFF047857),
                ),
              ),
              Text(
                "استمر، فكل خطوة تقربك من حلمك",
                style: GoogleFonts.cairo(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFA7F3D0) : const Color(0xFF059669),
                ),
              ),
            ],
          ),

          const SizedBox(width: 10),

          // Sprout Plant Graphic
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color(0xFF10B981).withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.eco_rounded, color: Color(0xFF10B981), size: 20),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Mountain with Summit Flag Custom Painter
// =============================================================================
class MountainFlagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Background circle tint
    final bgPaint = Paint()
      ..color = const Color(0xFFE0F2FE)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(w / 2, h / 2), w * 0.45, bgPaint);

    // Left Mountain (Dark Blue)
    final leftMountain = Path()
      ..moveTo(w * 0.12, h * 0.88)
      ..lineTo(w * 0.38, h * 0.42)
      ..lineTo(w * 0.65, h * 0.88)
      ..close();
    final leftMountainPaint = Paint()
      ..color = const Color(0xFF1E3A8A)
      ..style = PaintingStyle.fill;
    canvas.drawPath(leftMountain, leftMountainPaint);

    // Right Mountain (Medium Blue)
    final rightMountain = Path()
      ..moveTo(w * 0.45, h * 0.88)
      ..lineTo(w * 0.72, h * 0.48)
      ..lineTo(w * 0.92, h * 0.88)
      ..close();
    final rightMountainPaint = Paint()
      ..color = const Color(0xFF1D4ED8)
      ..style = PaintingStyle.fill;
    canvas.drawPath(rightMountain, rightMountainPaint);

    // Main Center Mountain (Summit)
    final centerMountain = Path()
      ..moveTo(w * 0.22, h * 0.88)
      ..lineTo(w * 0.52, h * 0.28)
      ..lineTo(w * 0.82, h * 0.88)
      ..close();
    final centerMountainPaint = Paint()
      ..color = const Color(0xFF2563EB)
      ..style = PaintingStyle.fill;
    canvas.drawPath(centerMountain, centerMountainPaint);

    // Snow peak on center mountain
    final snowPeak = Path()
      ..moveTo(w * 0.52, h * 0.28)
      ..lineTo(w * 0.60, h * 0.42)
      ..lineTo(w * 0.54, h * 0.39)
      ..lineTo(w * 0.49, h * 0.43)
      ..lineTo(w * 0.44, h * 0.41)
      ..close();
    final snowPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawPath(snowPeak, snowPaint);

    // Flagpole
    final polePaint = Paint()
      ..color = const Color(0xFF0F172A)
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(w * 0.52, h * 0.28), Offset(w * 0.52, h * 0.10), polePaint);

    // Waving Blue Flag
    final flag = Path()
      ..moveTo(w * 0.52, h * 0.10)
      ..lineTo(w * 0.68, h * 0.15)
      ..lineTo(w * 0.52, h * 0.20)
      ..close();
    final flagPaint = Paint()
      ..color = const Color(0xFF0284C7)
      ..style = PaintingStyle.fill;
    canvas.drawPath(flag, flagPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
