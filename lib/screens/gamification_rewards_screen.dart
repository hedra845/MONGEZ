import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/advanced_features_models.dart';
import '../providers/app_provider.dart';

class GamificationRewardsScreen extends StatefulWidget {
  const GamificationRewardsScreen({super.key});

  @override
  State<GamificationRewardsScreen> createState() => _GamificationRewardsScreenState();
}

class _GamificationRewardsScreenState extends State<GamificationRewardsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D0B18) : const Color(0xFFF7F6FD),
      body: SafeArea(
        child: Column(
          children: [
            // Top Custom Modern Bar (Clean without logo)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Daily Mystery Chest Button
                  InkWell(
                    onTap: () => _openDailyChest(context, app),
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: app.isDailyChestClaimed
                              ? [
                                  isDark ? const Color(0xFF1E1B2E) : const Color(0xFFE5E2F0),
                                  isDark ? const Color(0xFF2D2845) : const Color(0xFFD4CFE6),
                                ]
                              : const [Color(0xFF8B5CF6), Color(0xFF6D28D9), Color(0xFF4C1D95)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: app.isDailyChestClaimed
                            ? null
                            : [
                                BoxShadow(
                                  color: const Color(0xFF7C3AED).withValues(alpha: 0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            app.isDailyChestClaimed ? "تم الفتح" : "صندوقك اليومي",
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: app.isDailyChestClaimed
                                  ? (isDark ? const Color(0xFF9E99B3) : const Color(0xFF6B6684))
                                  : Colors.white,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Text("🎁", style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ),
                  ),

                  // Screen Title with Trophy
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "نظام النقاط والمكافآت",
                        style: GoogleFonts.cairo(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : const Color(0xFF1E1B38),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7C3AED).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.emoji_events_rounded, color: Color(0xFF8B5CF6), size: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        child: Column(
                          children: [
                            // Level & Coins Hero Card
                            _buildHeroLevelCard(context, app, isDark),
                            const SizedBox(height: 14),

                            // Leaderboard / Motivation Banner
                            _buildMotivationBanner(context, app, isDark),
                            const SizedBox(height: 14),

                            // Tabs Bar
                            Container(
                              height: 50,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: isDark ? const Color(0xFF171329) : const Color(0xFFEDE9FE),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isDark ? const Color(0xFF292348) : const Color(0xFFDDD6FE),
                                  width: 0.8,
                                ),
                              ),
                              child: TabBar(
                                controller: _tabController,
                                isScrollable: true,
                                tabAlignment: TabAlignment.start,
                                indicatorSize: TabBarIndicatorSize.tab,
                                indicator: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF6366F1), Color(0xFF7C3AED)],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF6366F1).withValues(alpha: 0.35),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                labelColor: Colors.white,
                                unselectedLabelColor:
                                    isDark ? const Color(0xFFA5B4FC) : const Color(0xFF6B7280),
                                labelStyle: GoogleFonts.cairo(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w800,
                                ),
                                tabs: const [
                                  Tab(text: "متجر الجوائز 🎁"),
                                  Tab(text: "مهام النقاط ⚡"),
                                  Tab(text: "الأوسمة 🏆"),
                                  Tab(text: "لوحة الشرف 🌟"),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    // Tab 1: Rewards Store
                    _buildRewardsStoreTab(context, app, isDark),

                    // Tab 2: Daily Points Tasks
                    _buildPointsTasksTab(context, app, isDark),

                    // Tab 3: Badges
                    _buildBadgesTab(context, app, isDark),

                    // Tab 4: Leaderboard
                    _buildLeaderboardTab(context, app, isDark),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Motivation & Rank Banner
  // ---------------------------------------------------------------------------
  Widget _buildMotivationBanner(BuildContext context, AppProvider app, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E1E2E), const Color(0xFF131D33)]
              : [const Color(0xFFFFFBEB), Colors.white],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFF59E0B).withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("🏆", style: TextStyle(fontSize: 12)),
                const SizedBox(width: 4),
                Text(
                  "الترتيب #3",
                  style: GoogleFonts.cairo(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "أنت من أكثر 5% طلاب نشاطاً هذا الأسبوع! واصل استمرارك 🔥",
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isDark ? const Color(0xFFE2E8F0) : const Color(0xFF334155),
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Hero Level & Coins Card (فخامة بتصميم Glassmorphic وعصري)
  // ---------------------------------------------------------------------------
  Widget _buildHeroLevelCard(BuildContext context, AppProvider app, bool isDark) {
    final progress = (app.currentXp / app.targetXp).clamp(0.0, 1.0);
    final percent = (progress * 100).toInt();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1E1435), const Color(0xFF311E63), const Color(0xFF1B1842)]
              : [const Color(0xFF4338CA), const Color(0xFF6366F1), const Color(0xFF7C3AED)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: isDark ? 0.35 : 0.32),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background ambient aesthetic glow circles
          Positioned(
            left: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            right: -30,
            bottom: -30,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Column(
              children: [
                // Top Row: Shield & Student Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Shield
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.shield_rounded, size: 15, color: Color(0xFF38BDF8)),
                          const SizedBox(width: 5),
                          Text(
                            "${app.streakFreezeCount} درع حماية",
                            style: GoogleFonts.cairo(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Level Title & Badge
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "المستوى ${app.userLevel} • ${app.studentLevelTitle}",
                          style: GoogleFonts.cairo(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFBBF24).withValues(alpha: 0.4),
                              width: 1,
                            ),
                          ),
                          child: const Text("👑", style: TextStyle(fontSize: 14)),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // XP Progress Bar Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "$percent%",
                          style: GoogleFonts.poppins(
                            fontSize: 12.5,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFFDE68A),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          "(${app.currentXp} / ${app.targetXp} XP)",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.75),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "التقدم نحو المستوى التالي",
                      style: GoogleFonts.cairo(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),

                // XP Progress Bar (Glowing design)
                Container(
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFBBF24)),
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                Divider(color: Colors.white.withValues(alpha: 0.14), height: 1),
                const SizedBox(height: 14),

                // 3-Column Stats: Streaks, Coins & Excellence Stars
                Row(
                  children: [
                    // Excellence Stars (نجمة درجات الاختبار والالتزام)
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFFFBBF24).withValues(alpha: 0.25),
                              const Color(0xFFF59E0B).withValues(alpha: 0.1),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFFDE68A).withValues(alpha: 0.4),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Text("⭐", style: TextStyle(fontSize: 16)),
                            ),
                            const SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${app.excellenceStars}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    height: 1.1,
                                  ),
                                ),
                                Text(
                                  "نجمة تفوق",
                                  style: GoogleFonts.cairo(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFDE68A),
                                    height: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Streaks
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: const Color(0xFFEF4444).withValues(alpha: 0.25),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Text("🔥", style: TextStyle(fontSize: 16)),
                            ),
                            const SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${app.streakDays} أيام",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    height: 1.1,
                                  ),
                                ),
                                Text(
                                  "استمرارية",
                                  style: GoogleFonts.cairo(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFCA5A5),
                                    height: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Mongez Coins
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.15),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF59E0B).withValues(alpha: 0.25),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: const Text("🪙", style: TextStyle(fontSize: 16)),
                            ),
                            const SizedBox(width: 6),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${app.userCoins}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                    height: 1.1,
                                  ),
                                ),
                                Text(
                                  "نقاط مُنجز",
                                  style: GoogleFonts.cairo(
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFFDE68A),
                                    height: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Management Grand Prize Banner (مكافأة إدارة التطبيق السنوية)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "مكافأة الإدارة 🎁",
                          style: GoogleFonts.cairo(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          "أعلى مجموع بنهاية العام يفوز بجائزة كبرى قيّمة تكريماً من إدارة مُنجز!",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.cairo(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFDE68A),
                            height: 1.2,
                          ),
                        ),
                      ),
                    ],
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
  // Tab 1: Rewards Store
  // ---------------------------------------------------------------------------
  Widget _buildRewardsStoreTab(BuildContext context, AppProvider app, bool isDark) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: app.redeemableRewards.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final reward = app.redeemableRewards[index];
        final canAfford = app.userCoins >= reward.pointsCost;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF131D33) : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: reward.isClaimed
                  ? const Color(0xFF10B981).withValues(alpha: 0.45)
                  : (canAfford
                      ? const Color(0xFF2563EB).withValues(alpha: 0.3)
                      : (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0))),
              width: reward.isClaimed || canAfford ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.05 : 0.025),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Claim / Redeem Button
              if (reward.isClaimed)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0xFF10B981).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "مُفعّل",
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),
                )
              else
                ElevatedButton(
                  onPressed: canAfford
                      ? () {
                          final success = app.redeemReward(reward.id);
                          if (success) {
                            _showRedeemSuccessDialog(context, reward);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6366F1),
                    disabledBackgroundColor:
                        isDark ? const Color(0xFF1E1B2E) : const Color(0xFFEDE9FE),
                    disabledForegroundColor:
                        isDark ? const Color(0xFF6B6684) : const Color(0xFF9E99B3),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: canAfford ? 3 : 0,
                    shadowColor: const Color(0xFF6366F1).withValues(alpha: 0.4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("🪙", style: TextStyle(fontSize: 13)),
                      const SizedBox(width: 4),
                      Text(
                        "${reward.pointsCost}",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: canAfford
                              ? Colors.white
                              : (isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        "استبدال",
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: canAfford
                              ? Colors.white
                              : (isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(width: 14),

              // Title and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      reward.title,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      reward.description,
                      textAlign: TextAlign.right,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Icon Badge
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      reward.color.withValues(alpha: 0.2),
                      reward.color.withValues(alpha: 0.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: reward.color.withValues(alpha: 0.25),
                  ),
                ),
                child: Icon(reward.icon, color: reward.color, size: 24),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Tab 2: Daily Points Tasks
  // ---------------------------------------------------------------------------
  Widget _buildPointsTasksTab(BuildContext context, AppProvider app, bool isDark) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: app.dailyPointsTasks.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final task = app.dailyPointsTasks[index];

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF131D33) : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: task.isCompleted && !task.isClaimed
                  ? const Color(0xFF10B981).withValues(alpha: 0.55)
                  : (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
              width: task.isCompleted && !task.isClaimed ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.05 : 0.025),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Claim button or reward tag
              if (task.isClaimed)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.25)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle_rounded, color: Color(0xFF10B981), size: 15),
                      const SizedBox(width: 4),
                      Text(
                        "تم الاستلام",
                        style: GoogleFonts.cairo(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF10B981),
                        ),
                      ),
                    ],
                  ),
                )
              else if (task.isCompleted)
                ElevatedButton(
                  onPressed: () {
                    app.claimTaskPoints(task.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "مبروك! حصلت على +${task.pointsReward} نقطة مُنجز 🎉",
                              style: GoogleFonts.cairo(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text("🪙", style: TextStyle(fontSize: 18)),
                          ],
                        ),
                        backgroundColor: const Color(0xFF10B981),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    shadowColor: const Color(0xFF10B981).withValues(alpha: 0.4),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("🎁", style: TextStyle(fontSize: 12)),
                      const SizedBox(width: 4),
                      Text(
                        "استلم +${task.pointsReward}",
                        style: GoogleFonts.cairo(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.25)),
                  ),
                  child: Text(
                    "+${task.pointsReward} نقطة",
                    style: GoogleFonts.cairo(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFF59E0B),
                    ),
                  ),
                ),

              const SizedBox(width: 12),

              // Title and Progress
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      task.title,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${task.currentProgress} / ${task.targetProgress}",
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: (task.currentProgress / task.targetProgress).clamp(0.0, 1.0),
                              backgroundColor:
                                  isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                              valueColor: AlwaysStoppedAnimation<Color>(task.color),
                              minHeight: 6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      task.color.withValues(alpha: 0.2),
                      task.color.withValues(alpha: 0.08),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: task.color.withValues(alpha: 0.25),
                  ),
                ),
                child: Icon(task.icon, color: task.color, size: 24),
              ),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Tab 3: Badges
  // ---------------------------------------------------------------------------
  Widget _buildBadgesTab(BuildContext context, AppProvider app, bool isDark) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      itemCount: app.badges.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.88,
      ),
      itemBuilder: (context, index) {
        final badge = app.badges[index];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF131D33) : Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: badge.isUnlocked
                  ? badge.color.withValues(alpha: 0.6)
                  : (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
              width: badge.isUnlocked ? 1.5 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: badge.isUnlocked
                    ? badge.color.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.02),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: badge.isUnlocked
                      ? LinearGradient(
                          colors: [
                            badge.color.withValues(alpha: 0.25),
                            badge.color.withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                  color: badge.isUnlocked
                      ? null
                      : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
                  border: Border.all(
                    color: badge.isUnlocked ? badge.color : Colors.transparent,
                    width: 2,
                  ),
                  boxShadow: badge.isUnlocked
                      ? [
                          BoxShadow(
                            color: badge.color.withValues(alpha: 0.25),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Icon(
                  badge.icon,
                  color: badge.isUnlocked ? badge.color : const Color(0xFF94A3B8),
                  size: 28,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                badge.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 2),
              Expanded(
                child: Text(
                  badge.description,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.cairo(
                    fontSize: 10.5,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    height: 1.25,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              if (badge.isUnlocked)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: badge.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: badge.color.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_rounded, color: badge.color, size: 13),
                      const SizedBox(width: 4),
                      Text(
                        "مكتمل",
                        style: GoogleFonts.cairo(
                          fontSize: 10.5,
                          fontWeight: FontWeight.bold,
                          color: badge.color,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    Text(
                      "${badge.progress.toInt()}%",
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                      ),
                    ),
                    const SizedBox(height: 3),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: badge.progress / 100,
                        backgroundColor:
                            isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                        valueColor: AlwaysStoppedAnimation<Color>(badge.color),
                        minHeight: 5,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  // ---------------------------------------------------------------------------
  // Tab 4: Leaderboard (لوحة الشرف والمنافسة الأسبوعية)
  // ---------------------------------------------------------------------------
  Widget _buildLeaderboardTab(BuildContext context, AppProvider app, bool isDark) {
    final topStudents = [
      {
        "rank": 1,
        "name": "سارة المحمدي",
        "xp": 3420,
        "streak": 18,
        "stars": 19,
        "badge": "🥇",
        "color": const Color(0xFFF59E0B),
        "isMe": false,
      },
      {
        "rank": 2,
        "name": "عمر الشامي",
        "xp": 2890,
        "streak": 12,
        "stars": 16,
        "badge": "🥈",
        "color": const Color(0xFF94A3B8),
        "isMe": false,
      },
      {
        "rank": 3,
        "name": "${app.userName} (أنت)",
        "xp": app.currentXp + 600,
        "streak": app.streakDays,
        "stars": app.excellenceStars,
        "badge": "🥉",
        "color": const Color(0xFFCD7F32),
        "isMe": true,
      },
      {
        "rank": 4,
        "name": "كريم عبد العزيز",
        "xp": 1820,
        "streak": 9,
        "stars": 11,
        "badge": "⭐",
        "color": const Color(0xFF6366F1),
        "isMe": false,
      },
      {
        "rank": 5,
        "name": "نور الهدى إبراهيم",
        "xp": 1650,
        "streak": 7,
        "stars": 9,
        "badge": "⭐",
        "color": const Color(0xFF6366F1),
        "isMe": false,
      },
      {
        "rank": 6,
        "name": "يوسف طارق",
        "xp": 1410,
        "streak": 5,
        "stars": 7,
        "badge": "⭐",
        "color": const Color(0xFF6366F1),
        "isMe": false,
      },
    ];

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      children: [
        // Annual Grand Prize by App Management Card (مكافأة الإدارة السنوية الكبرى)
        Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF3B1E08), const Color(0xFF1E1435)]
                  : [const Color(0xFFFFF7ED), const Color(0xFFFDF4FF)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xFFF59E0B).withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF59E0B), Color(0xFFEA580C)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      "جائزة نهاية العام الكبرى 🏆",
                      style: GoogleFonts.cairo(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "تكريم خاص من إدارة مُنجز",
                        style: GoogleFonts.cairo(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFD97706),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text("🎖️", style: TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "نظام نجوم التفوق ومكافأة الإدارة 🌟",
                style: GoogleFonts.cairo(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : const Color(0xFF1E1B38),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "• كل طالب يحصل على درجات مرتفعة في الاختبارات وينتظم في مواعيد الحصص وجلسات المذاكرة يحصل على نجمة تفوق (⭐) داخل التطبيق.\n• في ختام العام الدراسي، الطالب الحاصل على أعلى مجموع سيحصل على مكافأة وتكريم رسمي مالي/عيني من إدارة التطبيق مباشرة! 🎁",
                style: GoogleFonts.cairo(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),

        // Podium (Top 3 Visualizer)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [const Color(0xFF1E1435), const Color(0xFF2E1A47)]
                  : [const Color(0xFFF3E8FF), const Color(0xFFEDE9FE)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: const Color(0xFF7C3AED).withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.stars_rounded, color: Color(0xFFF59E0B), size: 20),
                  const SizedBox(width: 6),
                  Text(
                    "أبطال هذا الأسبوع",
                    style: GoogleFonts.cairo(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : const Color(0xFF3B0764),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // #2
                  _buildPodiumUser(
                    rank: "2",
                    name: "عمر",
                    xp: "2,890 XP",
                    height: 80,
                    badge: "🥈",
                    color: const Color(0xFF94A3B8),
                    isDark: isDark,
                  ),
                  // #1 (Center & Taller)
                  _buildPodiumUser(
                    rank: "1",
                    name: "سارة",
                    xp: "3,420 XP",
                    height: 105,
                    badge: "🥇",
                    color: const Color(0xFFF59E0B),
                    isDark: isDark,
                    isChampion: true,
                  ),
                  // #3
                  _buildPodiumUser(
                    rank: "3",
                    name: "أنت",
                    xp: "${app.currentXp + 600} XP",
                    height: 70,
                    badge: "🥉",
                    color: const Color(0xFFD97706),
                    isDark: isDark,
                    isMe: true,
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // List Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "تحديث الترتيب يتم كل أحد ⏳",
              style: GoogleFonts.cairo(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? const Color(0xFFA5B4FC) : const Color(0xFF6B7280),
              ),
            ),
            Text(
              "الترتيب العام",
              style: GoogleFonts.cairo(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: isDark ? Colors.white : const Color(0xFF1E1B38),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Leaderboard items
        ...topStudents.map((st) {
          final isMe = st["isMe"] as bool;
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isMe
                  ? (isDark
                      ? const Color(0xFF311E63)
                      : const Color(0xFFEDE9FE))
                  : (isDark ? const Color(0xFF131124) : Colors.white),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isMe
                    ? const Color(0xFF7C3AED)
                    : (isDark ? const Color(0xFF261F40) : const Color(0xFFE5E2F0)),
                width: isMe ? 1.8 : 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isMe
                      ? const Color(0xFF7C3AED).withValues(alpha: 0.15)
                      : Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                // XP Score
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: (st["color"] as Color).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("⚡", style: TextStyle(fontSize: 11)),
                      const SizedBox(width: 3),
                      Text(
                        "${st['xp']} XP",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: st["color"] as Color,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Streak Flame
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("🔥", style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 2),
                    Text(
                      "${st['streak']}",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFEF4444),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 8),

                // Excellence Stars
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("⭐", style: TextStyle(fontSize: 11)),
                      const SizedBox(width: 2),
                      Text(
                        "${st['stars']}",
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFF59E0B),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Name
                Text(
                  st["name"] as String,
                  style: GoogleFonts.cairo(
                    fontSize: 13,
                    fontWeight: isMe ? FontWeight.w900 : FontWeight.bold,
                    color: isMe
                        ? (isDark ? Colors.white : const Color(0xFF4C1D95))
                        : (isDark ? Colors.white : const Color(0xFF1E1B38)),
                  ),
                ),

                const SizedBox(width: 12),

                // Rank Badge / Number
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: (st["color"] as Color).withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    st["badge"] as String,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPodiumUser({
    required String rank,
    required String name,
    required String xp,
    required double height,
    required String badge,
    required Color color,
    required bool isDark,
    bool isChampion = false,
    bool isMe = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isChampion) ...[
          const Text("👑", style: TextStyle(fontSize: 18)),
          const SizedBox(height: 2),
        ],
        CircleAvatar(
          radius: isChampion ? 24 : 20,
          backgroundColor: color.withValues(alpha: 0.2),
          child: Text(badge, style: TextStyle(fontSize: isChampion ? 20 : 16)),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: GoogleFonts.cairo(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : const Color(0xFF1E1B38),
          ),
        ),
        Text(
          xp,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: 70,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withValues(alpha: 0.4),
                color.withValues(alpha: 0.15),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
          alignment: Alignment.center,
          child: Text(
            "#$rank",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : const Color(0xFF1E1B38),
            ),
          ),
        ),
      ],
    );
  }

  void _openDailyChest(BuildContext context, AppProvider app) {
    if (app.isDailyChestClaimed) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "لقد فتحت صندوق اليوم بالفعل! عُد غداً لمكافأة جديدة 🎁",
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color(0xFF0284C7),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
      return;
    }

    final coins = app.claimDailyChest();
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                ),
                alignment: Alignment.center,
                child: const Text("🎁", style: TextStyle(fontSize: 42)),
              ),
              const SizedBox(height: 14),
              Text(
                "صندوق المكافأة اليومية!",
                style: GoogleFonts.cairo(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(
                "مبروك! حصلت على +$coins نقطة مُنجز لمواظبتك اليومية على فتح التطبيق.",
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    "رائع، شكراً!",
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showRedeemSuccessDialog(BuildContext context, RedeemableReward reward) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 10),
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: reward.color.withValues(alpha: 0.15),
                  border: Border.all(color: reward.color.withValues(alpha: 0.3), width: 2),
                ),
                child: Icon(reward.icon, color: reward.color, size: 36),
              ),
              const SizedBox(height: 16),
              Text(
                "تم استبدال المكافأة بنجاح! 🎉",
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "حصلت على: ${reward.title}\nتم تفعيل ميزتك بنجاح لتستمتع بها أثناء المذاكرة.",
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(fontSize: 13, height: 1.4),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(ctx),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    "استمرار بالمذاكرة 🚀",
                    style: GoogleFonts.cairo(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
