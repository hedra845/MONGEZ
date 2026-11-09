import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'ai_quiz_screen.dart';

class StudyCompetitionScreen extends StatefulWidget {
  const StudyCompetitionScreen({super.key});

  @override
  State<StudyCompetitionScreen> createState() => _StudyCompetitionScreenState();
}

class _StudyCompetitionScreenState extends State<StudyCompetitionScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
      backgroundColor: isDark ? const Color(0xFF090E17) : const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.5)),
              ),
              child: const Icon(Icons.emoji_events_rounded, color: Color(0xFFF59E0B), size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              "ساحة المسابقات والتحديات",
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Live Competition Big Banner
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF78350F), Color(0xFFB45309), Color(0xFF92400E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFFBBF24).withValues(alpha: 0.6),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFF59E0B).withValues(alpha: 0.3),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFFFDE68A)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.local_fire_department_rounded, color: Color(0xFFFDE68A), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              "مباشر الآن",
                              style: GoogleFonts.cairo(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFFDE68A),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "جائزة المركز الأول: 250 كوينز",
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFFDE68A),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.monetization_on_rounded, color: Color(0xFFFDE68A), size: 18),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => const AiQuizScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFDE68A),
                          foregroundColor: const Color(0xFF78350F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          elevation: 0,
                        ),
                        child: Text(
                          "انضم للتحدي",
                          style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.w800),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "مسابقة العباقرة اليومية 🏆",
                            style: GoogleFonts.cairo(
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "15 سؤالاً في الفيزياء والرياضيات - 324 طالب يتنافسون",
                            style: GoogleFonts.cairo(
                              fontSize: 11,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Tabs
          TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFFF59E0B),
            labelColor: const Color(0xFFF59E0B),
            unselectedLabelColor: isDark ? Colors.white60 : const Color(0xFF64748B),
            labelStyle: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 13),
            tabs: const [
              Tab(text: "التحديات المباشرة"),
              Tab(text: "لوحة الشرف الأسبوعية"),
              Tab(text: "تحدي 1 ضد 1"),
            ],
          ),

          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildLiveCompetitionsTab(isDark, context),
                _buildLeaderboardTab(isDark, app),
                _buildOneVsOneTab(isDark, context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveCompetitionsTab(bool isDark, BuildContext context) {
    final contests = [
      {
        "title": "تحدي التفوق الرياضي",
        "subject": "الرياضيات والمنطق",
        "participants": "142 طالب",
        "prize": "300 كوينز",
        "time": "تبدأ بعد 15 دقيقة",
        "color": const Color(0xFF2563EB),
      },
      {
        "title": "سباق مصطلحات الأحياء",
        "subject": "الأحياء والجيولوجيا",
        "participants": "98 طالب",
        "prize": "200 كوينز",
        "time": "تبدأ 8:00 م اليوم",
        "color": const Color(0xFF10B981),
      },
      {
        "title": "ماراثون قواعد النحو واللغة",
        "subject": "اللغة العربية",
        "participants": "210 طالب",
        "prize": "500 كوينز + وسام النحوي",
        "time": "تبدأ غداً 5:00 م",
        "color": const Color(0xFF8B5CF6),
      },
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: contests.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final c = contests[index];
        final color = c["color"] as Color;
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF0F172A) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      c["time"] as String,
                      style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold, color: color),
                    ),
                  ),
                  Text(
                    c["title"] as String,
                    style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF0F172A)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                "المادة: ${c['subject']} | المتنافسون: ${c['participants']}",
                style: GoogleFonts.cairo(fontSize: 11.5, color: const Color(0xFF64748B)),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AiQuizScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      elevation: 0,
                    ),
                    child: Text("حجز مقعد بالتحدي", style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold)),
                  ),
                  Row(
                    children: [
                      Text(
                        c["prize"] as String,
                        style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.w800, color: const Color(0xFFF59E0B)),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.stars_rounded, color: Color(0xFFF59E0B), size: 18),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLeaderboardTab(bool isDark, AppProvider app) {
    final leaders = [
      {"name": "سارة إبراهيم", "faculty": "طب بشري", "score": "3,420", "rank": "1", "badge": "🥇"},
      {"name": "أحمد محمد (أنت)", "faculty": "هندسة طيران", "score": "3,150", "rank": "2", "badge": "🥈"},
      {"name": "عمر خالد", "faculty": "حاسبات ومعلومات", "score": "2,980", "rank": "3", "badge": "🥉"},
      {"name": "مريم حسن", "faculty": "صيدلة إكلينيكية", "score": "2,640", "rank": "4", "badge": "4"},
      {"name": "زياد طارق", "faculty": "ألسن", "score": "2,410", "rank": "5", "badge": "5"},
    ];

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: leaders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final l = leaders[index];
        final isMe = index == 1;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isMe
                ? (isDark ? const Color(0xFF1E293B) : const Color(0xFFFEF3C7))
                : (isDark ? const Color(0xFF0F172A) : Colors.white),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isMe ? const Color(0xFFF59E0B) : (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
              width: isMe ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Text(
                "${l['score']} نقطة",
                style: GoogleFonts.cairo(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFF59E0B),
                ),
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    l["name"] as String,
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    l["faculty"] as String,
                    style: GoogleFonts.cairo(fontSize: 10.5, color: const Color(0xFF64748B)),
                  ),
                ],
              ),
              const SizedBox(width: 12),
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: index < 3 ? const Color(0xFFF59E0B).withValues(alpha: 0.15) : Colors.grey.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  l["badge"] as String,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOneVsOneTab(bool isDark, BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFF59E0B).withValues(alpha: 0.4), width: 2),
              ),
              child: const Icon(Icons.flash_on_rounded, size: 60, color: Color(0xFFF59E0B)),
            ),
            const SizedBox(height: 20),
            Text(
              "تحدي 1 ضد 1 المباشر",
              style: GoogleFonts.cairo(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "نافس طالباً عشوائياً في 5 أسئلة سريعة مدتها 60 ثانية، والفائز يحصل على كوينز الخصم!",
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 12.5,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "جاري البحث عن خصم متطابق في مستواك الدراسي...",
                      style: GoogleFonts.cairo(),
                    ),
                    backgroundColor: const Color(0xFFD97706),
                  ),
                );
              },
              icon: const Icon(Icons.search_rounded, color: Colors.white),
              label: Text(
                "ابحث عن منافس الآن",
                style: GoogleFonts.cairo(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFD97706),
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
