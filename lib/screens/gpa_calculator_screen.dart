import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/extended_features_models.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';

class GpaCalculatorScreen extends StatefulWidget {
  const GpaCalculatorScreen({super.key});

  @override
  State<GpaCalculatorScreen> createState() => _GpaCalculatorScreenState();
}

class _GpaCalculatorScreenState extends State<GpaCalculatorScreen> {
  // Target predictor states
  double _targetPercent = 92.0;
  final double _finalExamWeight = 40.0; // 40% final weight

  String _getGradeLabel(double gpa, GpaScale scale) {
    if (scale == GpaScale.percentage) {
      if (gpa >= 90) return "امتياز مع مرتبة الشرف 🏆";
      if (gpa >= 80) return "جيد جداً مرتفع 🌟";
      if (gpa >= 70) return "جيد جداً 👍";
      if (gpa >= 60) return "جيد 📚";
      if (gpa >= 50) return "مقبول ⚠️";
      return "يحتاج إلى تحسين سريع 🚨";
    } else if (scale == GpaScale.scale4) {
      if (gpa >= 3.7) return "امتياز (First Class Honors) 🏆";
      if (gpa >= 3.3) return "جيد جداً مرتفع 🌟";
      if (gpa >= 2.8) return "جيد جداً 👍";
      if (gpa >= 2.0) return "جيد 📚";
      return "إنذار أكاديمي ⚠️";
    } else {
      if (gpa >= 4.75) return "ممتاز مرتفع 🏆";
      if (gpa >= 4.25) return "جيد جداً مرتفع 🌟";
      if (gpa >= 3.5) return "جيد جداً 👍";
      return "مقبول ⚠️";
    }
  }

  // Calculate needed score in final exam to hit the target
  double _calcNeededFinal(double currentAvg) {
    // Current coursework is (100 - weight)%, Final is weight%
    // target = (current * (100 - weight) + needed * weight) / 100
    // needed = (target * 100 - current * (100 - weight)) / weight
    final courseworkWeight = 100.0 - _finalExamWeight;
    final needed = (_targetPercent * 100.0 - currentAvg * courseworkWeight) / _finalExamWeight;
    return needed.clamp(0.0, 100.0);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);
    final currentGpa = app.calculateCurrentGpa();
    final neededFinal = _calcNeededFinal(currentGpa);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F182A) : const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            HeaderNavBar(
              title: "حاسبة المعدل وتوقع النتيجة",
              onBack: () => Navigator.of(context).pop(),
              actions: [
                IconButton(
                  tooltip: "إضافة مادة جديدة",
                  onPressed: () => _showAddCourseDialog(context, app),
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E5BB8).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.add_rounded, color: Color(0xFF1E5BB8), size: 22),
                  ),
                ),
              ],
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Scale Switcher Tabs
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF16223B) : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          _buildScaleTab("نظام 5.0", GpaScale.scale5, app.currentGpaScale, app, isDark),
                          _buildScaleTab("نظام 4.0", GpaScale.scale4, app.currentGpaScale, app, isDark),
                          _buildScaleTab("النسبة المئوية %", GpaScale.percentage, app.currentGpaScale, app, isDark),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Main GPA Result Card
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDark
                              ? [const Color(0xFF16223B), const Color(0xFF101B2E)]
                              : [const Color(0xFF1E5BB8), const Color(0xFF0284C7)],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1E5BB8).withValues(alpha: 0.3),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            app.currentGpaScale == GpaScale.percentage ? "معدلك التراكمي العام" : "معدلك التراكمي (GPA)",
                            style: GoogleFonts.cairo(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                currentGpa.toStringAsFixed(app.currentGpaScale == GpaScale.percentage ? 1 : 2),
                                style: GoogleFonts.poppins(
                                  fontSize: 48,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                              if (app.currentGpaScale == GpaScale.percentage)
                                Text(
                                  "%",
                                  style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withValues(alpha: 0.8),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _getGradeLabel(currentGpa, app.currentGpaScale),
                              style: GoogleFonts.cairo(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Divider(color: Colors.white.withValues(alpha: 0.2)),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildSummaryItem("عدد المواد", "${app.gpaCourses.length}"),
                              _buildSummaryItem(
                                "إجمالي الساعات",
                                "${app.gpaCourses.fold<double>(0, (prev, c) => prev + c.creditHours).toInt()}",
                              ),
                              _buildSummaryItem(
                                "الهدف المستهدف",
                                "${app.targetPercentage.toInt()}%",
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Smart Target Final Grade Predictor Card
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF16223B) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFE2E8F0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "توقع الدرجة المطلوبة في الفاينل 🎯",
                                style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : const Color(0xFF0F2547),
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(Icons.auto_graph_rounded, color: Color(0xFF10B981), size: 22),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "احسب كم تحتاج أن تحرز في الاختبار النهائي لتصل للهدف الذي تطمح له:",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${_targetPercent.toInt()}%",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF1E5BB8),
                                ),
                              ),
                              Text(
                                "النسبة المستهدفة الكلية:",
                                style: GoogleFonts.cairo(fontSize: 12.5),
                              ),
                            ],
                          ),
                          Slider(
                            value: _targetPercent,
                            min: 60,
                            max: 100,
                            activeColor: const Color(0xFF1E5BB8),
                            onChanged: (val) => setState(() => _targetPercent = val),
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF10B981).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: const Color(0xFF10B981).withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "${neededFinal.toStringAsFixed(1)}%",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF10B981),
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "الدرجة المطلوبة في الفاينل",
                                      style: GoogleFonts.cairo(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF0F2547),
                                      ),
                                    ),
                                    Text(
                                      neededFinal <= 100
                                          ? "الهدف ممكن ومتاح بكل سهولة! ركز على المراجعات ✨"
                                          : "تحتاج لرفع درجات أعمال السنة لتخفيف العبء",
                                      style: GoogleFonts.cairo(
                                        fontSize: 11,
                                        color: const Color(0xFF059669),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 22),

                    // Courses Section Title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () => _showAddCourseDialog(context, app),
                          icon: const Icon(Icons.add_circle_outline, size: 16, color: Color(0xFF1E5BB8)),
                          label: Text(
                            "مادة جديدة",
                            style: GoogleFonts.cairo(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E5BB8),
                            ),
                          ),
                        ),
                        Text(
                          "المواد المسجلة ودرجاتها",
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF0F2547),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Courses List
                    ...app.gpaCourses.map((course) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF16223B) : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFE2E8F0),
                            ),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444), size: 20),
                                onPressed: () => app.removeGpaCourse(course.id),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1E5BB8).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  course.letterGrade,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1E5BB8),
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    course.name,
                                    style: GoogleFonts.cairo(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? Colors.white : const Color(0xFF0F2547),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "${course.creditHours.toInt()} ساعات • الدرجة: ${course.score.toInt()}%",
                                    style: GoogleFonts.cairo(
                                      fontSize: 11.5,
                                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(String title, String val) {
    return Column(
      children: [
        Text(
          val,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          title,
          style: GoogleFonts.cairo(
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildScaleTab(
    String label,
    GpaScale scale,
    GpaScale current,
    AppProvider app,
    bool isDark,
  ) {
    final isSelected = scale == current;
    return Expanded(
      child: InkWell(
        onTap: () => app.setGpaScale(scale),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? const Color(0xFF1E5BB8) : Colors.white)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 6,
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: GoogleFonts.cairo(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: isSelected
                  ? (isDark ? Colors.white : const Color(0xFF1E5BB8))
                  : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
            ),
          ),
        ),
      ),
    );
  }

  void _showAddCourseDialog(BuildContext context, AppProvider app) {
    final nameCtrl = TextEditingController();
    final scoreCtrl = TextEditingController(text: "85");
    final hoursCtrl = TextEditingController(text: "3");
    String letterGrade = "A";

    showDialog(
      context: context,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: isDark ? const Color(0xFF111A2D) : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              title: Text(
                "إضافة مادة دراسية",
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0F2547),
                ),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameCtrl,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(color: isDark ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        labelText: "اسم المادة (مثال: كيمياء تحليلية)",
                        labelStyle: GoogleFonts.cairo(fontSize: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: scoreCtrl,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(color: isDark ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        labelText: "الدرجة المئوية (من 100)",
                        labelStyle: GoogleFonts.cairo(fontSize: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: hoursCtrl,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.poppins(color: isDark ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        labelText: "عدد الساعات أو الوزن (مثال: 3)",
                        labelStyle: GoogleFonts.cairo(fontSize: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: Text("إلغاء", style: GoogleFonts.cairo(color: const Color(0xFF94A3B8))),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (nameCtrl.text.trim().isEmpty) return;
                    final score = double.tryParse(scoreCtrl.text) ?? 85.0;
                    final hours = double.tryParse(hoursCtrl.text) ?? 3.0;

                    if (score >= 95) {
                      letterGrade = "A+";
                    } else if (score >= 90) {
                      letterGrade = "A";
                    } else if (score >= 85) {
                      letterGrade = "B+";
                    } else if (score >= 80) {
                      letterGrade = "B";
                    } else if (score >= 70) {
                      letterGrade = "C";
                    } else {
                      letterGrade = "D";
                    }

                    app.addGpaCourse(
                      GpaCourse(
                        id: "c_${DateTime.now().millisecondsSinceEpoch}",
                        name: nameCtrl.text.trim(),
                        creditHours: hours,
                        score: score,
                        letterGrade: letterGrade,
                      ),
                    );
                    Navigator.pop(ctx);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E5BB8),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text("إضافة", style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
