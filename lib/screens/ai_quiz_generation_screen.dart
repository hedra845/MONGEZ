import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/common_widgets.dart';
import 'ai_quiz_screen.dart';

class AiQuizGenerationScreen extends StatefulWidget {
  const AiQuizGenerationScreen({super.key});

  @override
  State<AiQuizGenerationScreen> createState() => _AiQuizGenerationScreenState();
}

class _AiQuizGenerationScreenState extends State<AiQuizGenerationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  String _selectedSubject = "الرياضيات والفيزياء";
  String _selectedDifficulty = "متوسط";
  int _questionCount = 3;
  bool _isGenerating = false;

  final List<Map<String, dynamic>> _subjects = [
    {"name": "الرياضيات والفيزياء", "icon": Icons.calculate_rounded, "color": Color(0xFF2563EB)},
    {"name": "اللغة العربية", "icon": Icons.menu_book_rounded, "color": Color(0xFF8B5CF6)},
    {"name": "الكيمياء والأحياء", "icon": Icons.science_rounded, "color": Color(0xFF10B981)},
    {"name": "اللغة الإنجليزية", "icon": Icons.language_rounded, "color": Color(0xFF0EA5E9)},
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _generateQuiz() {
    setState(() {
      _isGenerating = true;
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => AiQuizScreen(
              subject: _selectedSubject,
              difficulty: _selectedDifficulty,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF090E18) : const Color(0xFFF6F8FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderNavBar(
                title: "مولّد الاختبارات الذكية AI",
                onBack: () => Navigator.of(context).pop(),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // AI Robot Core Animation
                      Center(
                        child: AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _isGenerating ? _pulseAnimation.value : 1.0,
                              child: child,
                            );
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFF2563EB).withValues(alpha: 0.12),
                                ),
                              ),
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF1E5BB8), Color(0xFF0EA5E9), Color(0xFF8B5CF6)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF2563EB).withValues(alpha: 0.4),
                                      blurRadius: 26,
                                      offset: const Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Icon(
                                    _isGenerating ? Icons.auto_awesome : Icons.smart_toy_rounded,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Center(
                        child: Column(
                          children: [
                            Text(
                              _isGenerating
                                  ? "جاري توليد الأسئلة وتحليل المستوى..."
                                  : "اختبار مخصص وموجّه بالذكاء الاصطناعي",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cairo(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "يحلل الـ AI نقاط القوة والضعف ويصمم لك أسئلة تقيس مستوى فهمك الحقيقي بدقة",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.cairo(
                                fontSize: 12,
                                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 22),

                      if (!_isGenerating) ...[
                        // Select Subject
                        Text(
                          "المادة المستهدفة:",
                          style: GoogleFonts.cairo(
                            fontSize: 13.5,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: _subjects.map((sub) {
                            final isSel = _selectedSubject == sub["name"];
                            return InkWell(
                              onTap: () => setState(() => _selectedSubject = sub["name"]),
                              borderRadius: BorderRadius.circular(14),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSel
                                      ? (sub["color"] as Color).withValues(alpha: 0.15)
                                      : (isDark ? const Color(0xFF131D33) : Colors.white),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isSel
                                        ? (sub["color"] as Color)
                                        : (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
                                    width: isSel ? 2 : 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(sub["icon"] as IconData, size: 16, color: sub["color"] as Color),
                                    const SizedBox(width: 6),
                                    Text(
                                      sub["name"] as String,
                                      style: GoogleFonts.cairo(
                                        fontSize: 12,
                                        fontWeight: isSel ? FontWeight.bold : FontWeight.w600,
                                        color: isSel
                                            ? (sub["color"] as Color)
                                            : (isDark ? Colors.white70 : const Color(0xFF334155)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 18),

                        // Difficulty & Count Row
                        Row(
                          children: [
                            // Difficulty
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "مستوى الصعوبة:",
                                    style: GoogleFonts.cairo(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF131D33) : Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                                      ),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: _selectedDifficulty,
                                        isExpanded: true,
                                        dropdownColor: isDark ? const Color(0xFF131D33) : Colors.white,
                                        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF2563EB)),
                                        items: ["سهل ومباشر", "متوسط", "تحدي الأوائل"].map((val) {
                                          return DropdownMenuItem<String>(
                                            value: val,
                                            child: Text(
                                              val,
                                              style: GoogleFonts.cairo(
                                                fontSize: 12.5,
                                                fontWeight: FontWeight.bold,
                                                color: isDark ? Colors.white : const Color(0xFF0F172A),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          if (val != null) setState(() => _selectedDifficulty = val);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),

                            // Question Count
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "عدد الأسئلة:",
                                    style: GoogleFonts.cairo(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: isDark ? const Color(0xFF131D33) : Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (_questionCount > 3) setState(() => _questionCount--);
                                          },
                                          child: const Icon(Icons.remove_circle_outline, size: 20, color: Color(0xFF2563EB)),
                                        ),
                                        Text(
                                          "$_questionCount أسئلة",
                                          style: GoogleFonts.cairo(
                                            fontSize: 12.5,
                                            fontWeight: FontWeight.bold,
                                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (_questionCount < 10) setState(() => _questionCount++);
                                          },
                                          child: const Icon(Icons.add_circle_outline, size: 20, color: Color(0xFF2563EB)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // AI Excellence Star Badge Notice
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Text("⭐", style: TextStyle(fontSize: 22)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  "إحرازك 80% فأعلى يمنحك نجمة تفوق رسمية و100 نقطة لدخول سحب مكافأة نهاية العام!",
                                  style: GoogleFonts.cairo(
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? const Color(0xFFFDE68A) : const Color(0xFFB45309),
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        // Generating animation indicator
                        const SizedBox(height: 30),
                        Center(
                          child: Column(
                            children: [
                              const SizedBox(
                                width: 36,
                                height: 36,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                "يقوم الذكاء الاصطناعي الآن بصياغة أسئلة دقيقة...",
                                style: GoogleFonts.cairo(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2563EB),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Action Button
              if (!_isGenerating)
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _generateQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E5BB8),
                      elevation: 4,
                      shadowColor: const Color(0xFF1E5BB8).withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          "بدء توليد الاختبار الآن",
                          style: GoogleFonts.cairo(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

