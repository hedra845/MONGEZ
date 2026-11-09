import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InteractiveLearningScreen extends StatefulWidget {
  const InteractiveLearningScreen({super.key});

  @override
  State<InteractiveLearningScreen> createState() => _InteractiveLearningScreenState();
}

class _InteractiveLearningScreenState extends State<InteractiveLearningScreen> {
  int _selectedCategoryIndex = 0;
  double _simulationVoltage = 12.0;
  double _simulationResistance = 4.0;
  bool _isLightOn = true;

  final List<String> _categories = ["الكل", "الفيزياء", "الكيمياء", "الأحياء", "الرياضيات"];

  final List<Map<String, dynamic>> _models = [
    {
      "title": "تشريح القلب البشري والدورة الدموية",
      "subject": "الأحياء",
      "type": "نموذج 3D تفاعلي",
      "icon": Icons.favorite_rounded,
      "color": const Color(0xFFEF4444),
      "parts": "البطينين، الأذينين، الشريان الأورطي",
    },
    {
      "title": "بنية ذرة الكربون والروابط التساهمية",
      "subject": "الكيمياء",
      "type": "محاكاة جزيئية",
      "icon": Icons.bubble_chart_rounded,
      "color": const Color(0xFF10B981),
      "parts": "الإلكترونات، البروتونات، مستويات الطاقة",
    },
    {
      "title": "الدوائر الكهربية وقانون أوم",
      "subject": "الفيزياء",
      "type": "معمل افتراضي",
      "icon": Icons.bolt_rounded,
      "color": const Color(0xFFF59E0B),
      "parts": "الجهد، المقاومة، شدة التيار",
    },
    {
      "title": "الهندسة الفراغية والمجسمات",
      "subject": "الرياضيات",
      "type": "تحريك 360 درجة",
      "icon": Icons.view_in_ar_rounded,
      "color": const Color(0xFF8B5CF6),
      "parts": "المخروط، الهرم، الكرة، الأسطوانة",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentCurrent = (_simulationVoltage / _simulationResistance).toStringAsFixed(1);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0C091C) : const Color(0xFFF8FAFC),
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
                color: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF8B5CF6).withValues(alpha: 0.5)),
              ),
              child: const Icon(Icons.view_in_ar_rounded, color: Color(0xFF8B5CF6), size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              "التعلم التفاعلي والمجسمات 3D",
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
            // Interactive 3D Lab Simulation Hero Widget
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B0764), Color(0xFF581C87), Color(0xFF6B21A8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFC084FC).withValues(alpha: 0.6),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
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
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.science_rounded, color: Color(0xFFE9D5FF), size: 16),
                            const SizedBox(width: 4),
                            Text(
                              "معمل فيزياء مباشر",
                              style: GoogleFonts.cairo(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFFE9D5FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "تجربة قانون أوم التفاعلية",
                        style: GoogleFonts.cairo(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Visual Circuit Representation
                  Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white12),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () => setState(() => _isLightOn = !_isLightOn),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  _isLightOn ? Icons.lightbulb_rounded : Icons.lightbulb_outline_rounded,
                                  color: _isLightOn ? const Color(0xFFFDE047) : Colors.white30,
                                  size: 36,
                                ),
                                Text(
                                  _isLightOn ? "المصباح مضيء" : "مغلق",
                                  style: GoogleFonts.cairo(fontSize: 10, color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          Container(width: 1, height: 40, color: Colors.white24),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "$currentCurrent A",
                                style: GoogleFonts.cairo(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF38BDF8),
                                ),
                              ),
                              Text(
                                "شدة التيار (I = V / R)",
                                style: GoogleFonts.cairo(fontSize: 10, color: Colors.white70),
                              ),
                            ],
                          ),
                          Container(width: 1, height: 40, color: Colors.white24),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${_simulationVoltage.toInt()} V",
                                style: GoogleFonts.cairo(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFF472B6),
                                ),
                              ),
                              Text(
                                "فرق الجهد الكهربي",
                                style: GoogleFonts.cairo(fontSize: 10, color: Colors.white70),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Interactive Sliders
                  Row(
                    children: [
                      Text(
                        "${_simulationVoltage.toInt()}V",
                        style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Slider(
                          value: _simulationVoltage,
                          min: 2,
                          max: 36,
                          activeColor: const Color(0xFFC084FC),
                          inactiveColor: Colors.white24,
                          onChanged: (val) => setState(() => _simulationVoltage = val),
                        ),
                      ),
                      Text("الجهد V:", style: GoogleFonts.cairo(color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "${_simulationResistance.toInt()}Ω",
                        style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: Slider(
                          value: _simulationResistance,
                          min: 1,
                          max: 12,
                          activeColor: const Color(0xFF38BDF8),
                          inactiveColor: Colors.white24,
                          onChanged: (val) => setState(() => _simulationResistance = val),
                        ),
                      ),
                      Text("المقاومة R:", style: GoogleFonts.cairo(color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Categories Filter
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                reverse: true,
                itemCount: _categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = _selectedCategoryIndex == index;
                  return InkWell(
                    onTap: () => setState(() => _selectedCategoryIndex = index),
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF8B5CF6)
                            : (isDark ? const Color(0xFF1E1B4B).withValues(alpha: 0.5) : Colors.white),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF8B5CF6) : (isDark ? const Color(0xFF312E81) : const Color(0xFFE2E8F0)),
                        ),
                      ),
                      child: Text(
                        _categories[index],
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : (isDark ? Colors.white70 : const Color(0xFF475569)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // 3D Models Catalog Grid
            Text(
              "نماذج ثلاثية الأبعاد تفاعلية (3D Visuals)",
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 10),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _models.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final model = _models[index];
                final color = model["color"] as Color;
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF13102B) : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isDark ? const Color(0xFF2E236C) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              model["subject"] as String,
                              style: GoogleFonts.cairo(fontSize: 10, fontWeight: FontWeight.bold, color: color),
                            ),
                          ),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(model["icon"] as IconData, color: color, size: 20),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        model["title"] as String,
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        model["parts"] as String,
                        textAlign: TextAlign.right,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.cairo(
                          fontSize: 10,
                          color: isDark ? Colors.white54 : const Color(0xFF64748B),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: 32,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("جاري تحميل المجسم ثلاثي الأبعاد 3D...", style: GoogleFonts.cairo()),
                                backgroundColor: color,
                              ),
                            );
                          },
                          icon: const Icon(Icons.open_in_full_rounded, size: 14),
                          label: Text(
                            "فتح النموذج",
                            style: GoogleFonts.cairo(fontSize: 11, fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: color,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 0,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
