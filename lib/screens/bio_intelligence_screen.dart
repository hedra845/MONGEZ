import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BioIntelligenceScreen extends StatefulWidget {
  const BioIntelligenceScreen({super.key});

  @override
  State<BioIntelligenceScreen> createState() => _BioIntelligenceScreenState();
}

class _BioIntelligenceScreenState extends State<BioIntelligenceScreen> {
  int _selectedBinauralIndex = 0;
  bool _isPlayingBinaural = false;

  final List<Map<String, dynamic>> _binauralWaves = [
    {
      "title": "موجات ألفا (Alpha 10Hz)",
      "desc": "للاستيعاب السريع والتركيز العميق بدون توتر",
      "state": "حالة التدفق الذهني",
      "color": const Color(0xFF10B981),
      "icon": Icons.waves_rounded,
    },
    {
      "title": "موجات بيتا (Beta 16Hz)",
      "desc": "لحل المسائل المعقدة والحسابات الرياضية والتحليل",
      "state": "نشاط منطقي مكثف",
      "color": const Color(0xFF0EA5E9),
      "icon": Icons.psychology_rounded,
    },
    {
      "title": "موجات ثيتا (Theta 6Hz)",
      "desc": "لتثبيت المعلومات في الذاكرة طويلة المدى قبل النوم",
      "state": "تثبيت الذاكرة",
      "color": const Color(0xFF8B5CF6),
      "icon": Icons.nightlight_round,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF07111E) : const Color(0xFFF1F5F9),
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
                color: const Color(0xFF10B981).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.5)),
              ),
              child: const Icon(Icons.psychology_alt_rounded, color: Color(0xFF10B981), size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              "الذكاء الحيوي (Bio Intelligence)",
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bio Status Card (النشاط البيولوجي الحالي)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF064E3B), Color(0xFF065F46), Color(0xFF042F2E)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFF34D399).withValues(alpha: 0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF10B981).withValues(alpha: 0.25),
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
                          color: const Color(0xFF10B981).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: const Color(0xFF34D399)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.bolt_rounded, color: Color(0xFF34D399), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              "ذروة التركيز واليقظة",
                              style: GoogleFonts.cairo(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF6EE7B7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "الساعة البيولوجية للدماغ",
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "88",
                        style: GoogleFonts.cairo(
                          fontSize: 50,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF6EE7B7),
                          height: 1,
                        ),
                      ),
                      Text(
                        "%",
                        style: GoogleFonts.cairo(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "مستوى الاستعداد الإدراكي العصبي الآن",
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "دماغك الآن في أنسب وقت لفهم المواد الصعبة والمعادلات العلمية",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontSize: 11.5,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.88,
                      minHeight: 8,
                      backgroundColor: Colors.white12,
                      valueColor: const AlwaysStoppedAnimation(Color(0xFF34D399)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Bio Rhythm Timeline (منحنى الطاقة والتركيز على مدار اليوم)
            Text(
              "منحنى طاقتك الحيوية اليوم",
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0D1B2A) : Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isDark ? const Color(0xFF1E2E46) : const Color(0xFFE2E8F0),
                ),
              ),
              child: Column(
                children: [
                  _buildRhythmSlot("8:00 ص - 11:30 ص", "ذروة الحفظ والتركيز التحليلي", "95% طاقة", const Color(0xFF10B981), true),
                  const Divider(height: 20, color: Colors.white10),
                  _buildRhythmSlot("1:00 م - 3:00 م", "انخفاض مؤقت (أنسب وقت لمراجعة خفيفة أو قيلولة)", "55% طاقة", const Color(0xFFF59E0B), false),
                  const Divider(height: 20, color: Colors.white10),
                  _buildRhythmSlot("5:00 م - 9:00 م", "ذروة الاستيعاب الثانية وحل التمارين", "88% طاقة", const Color(0xFF3B82F6), true),
                  const Divider(height: 20, color: Colors.white10),
                  _buildRhythmSlot("10:00 م فما فوق", "مرحلة المعالجة وتثبيت المعلومات بالذاكرة", "40% طاقة", const Color(0xFF8B5CF6), false),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Binaural Beats Audio Stimulator (محفز الترددات الحيوية)
            Text(
              "محفز الترددات الذهنية (Binaural Beats)",
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _binauralWaves.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final wave = _binauralWaves[index];
                final isSelected = _selectedBinauralIndex == index;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedBinauralIndex = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0D1B2A) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? (wave["color"] as Color) : (isDark ? const Color(0xFF1E2E46) : const Color(0xFFE2E8F0)),
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedBinauralIndex = index;
                              _isPlayingBinaural = !_isPlayingBinaural;
                            });
                          },
                          icon: Icon(
                            (isSelected && _isPlayingBinaural) ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded,
                            color: wave["color"] as Color,
                            size: 38,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: (wave["color"] as Color).withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      wave["state"] as String,
                                      style: GoogleFonts.cairo(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: wave["color"] as Color,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    wave["title"] as String,
                                    style: GoogleFonts.cairo(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                wave["desc"] as String,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cairo(
                                  fontSize: 11,
                                  color: isDark ? Colors.white60 : const Color(0xFF64748B),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // AI Bio Recommendations
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF10B981).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.health_and_safety_rounded, color: Color(0xFF10B981), size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "توصية ذكية لصحة دماغك",
                          style: GoogleFonts.cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                        Text(
                          "أنت تذاكر منذ 45 دقيقة. اشرب كوب ماء وخذ 3 أنفاس عميقة للحفاظ على مستوى الأكسجين وتجنب تشتت الانتباه.",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.cairo(
                            fontSize: 11.5,
                            color: isDark ? Colors.white70 : const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildRhythmSlot(String time, String title, String energy, Color color, bool isHigh) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            energy,
            style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold, color: color),
          ),
        ),
        const Spacer(),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                time,
                style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                title,
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : const Color(0xFF334155),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Icon(isHigh ? Icons.arrow_upward_rounded : Icons.pause_circle_outline_rounded, color: color, size: 20),
      ],
    );
  }
}
