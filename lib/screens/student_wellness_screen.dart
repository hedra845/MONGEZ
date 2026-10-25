import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';

class StudentWellnessScreen extends StatelessWidget {
  const StudentWellnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderNavBar(
                title: "صحة ورفاهية الطالب",
                onBack: () => Navigator.of(context).pop(),
              ),

              const SizedBox(height: 10),

              // Hydration Card (تتبع شرب الماء أثناء المذاكرة)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF0C2444), const Color(0xFF111A2D)]
                        : [const Color(0xFFE0F2FE), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF0EA5E9).withValues(alpha: 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0EA5E9).withValues(alpha: 0.1),
                      blurRadius: 16,
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
                            color: const Color(0xFF0EA5E9).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "${app.waterCupsDrunk} من ${app.targetWaterCups} أكواب",
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF0284C7),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "تذكير شرب الماء",
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : const Color(0xFF0F2547),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(Icons.water_drop_rounded, color: Color(0xFF0EA5E9), size: 24),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Water Cups Indicator Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(app.targetWaterCups, (index) {
                        final isFilled = index < app.waterCupsDrunk;
                        return Icon(
                          Icons.local_drink_rounded,
                          color: isFilled ? const Color(0xFF0EA5E9) : const Color(0xFF94A3B8).withValues(alpha: 0.35),
                          size: 28,
                        );
                      }),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => app.addWaterCup(),
                          icon: const Icon(Icons.add, size: 18),
                          label: Text("شربت كوباً الآن 💧", style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0EA5E9),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                "تمارين استرخاء وراحة الذهن",
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0F2547),
                ),
              ),
              const SizedBox(height: 12),

              // Wellness Exercises List
              ...app.wellnessExercises.map((exercise) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF111A2D) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFDCE4F0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Start exercise button
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: exercise.color.withValues(alpha: 0.15),
                            ),
                            child: Icon(Icons.play_arrow_rounded, color: exercise.color, size: 22),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "تم بدء ${exercise.title}.. خذ نفساً عميقاً واسترخِ.",
                                  style: GoogleFonts.cairo(),
                                  textAlign: TextAlign.right,
                                ),
                                backgroundColor: exercise.color,
                              ),
                            );
                          },
                        ),

                        const Spacer(),

                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                exercise.title,
                                style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : const Color(0xFF0F2547),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                exercise.subtitle,
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cairo(
                                  fontSize: 12,
                                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF5A6E8C),
                                  height: 1.3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),

                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: exercise.color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(exercise.icon, color: exercise.color, size: 26),
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
    );
  }
}
