import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';
import 'distraction_lock_screen.dart';
import 'ai_quiz_generation_screen.dart';
import 'ambient_sounds_screen.dart';
import 'smart_flashcards_screen.dart';
import 'ai_audio_notes_screen.dart';

class ActiveTimerScreen extends StatelessWidget {
  const ActiveTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);
    final session = app.currentSession;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderNavBar(
                title: "جلسة المذاكرة",
                onBack: () => Navigator.of(context).pop(),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.shield_outlined, color: Color(0xFFEF4444)),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const DistractionLockScreen()),
                      );
                    },
                    tooltip: "قفل المشتتات",
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Subject Pill
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: (session?.color ?? const Color(0xFF2563EB)).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    session?.subject ?? "الرياضيات",
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: session?.color ?? const Color(0xFF2563EB),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Circular Countdown Timer
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Outer glow container
                    Container(
                      width: 270,
                      height: 270,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00C6FF).withOpacity(isDark ? 0.15 : 0.08),
                            blurRadius: 40,
                            spreadRadius: 10,
                          ),
                        ],
                      ),
                    ),

                    // Progress indicator
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: CircularProgressIndicator(
                        value: app.timerProgress,
                        strokeWidth: 12,
                        backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                        valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00C6FF)),
                        strokeCap: StrokeCap.round,
                      ),
                    ),

                    // Inner Timer Text
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          app.formattedTimer,
                          style: GoogleFonts.poppins(
                            fontSize: 46,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "دقيقة",
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Controls (Play / Pause)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(35),
                    onTap: () {
                      app.toggleTimer();
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF2563EB), Color(0xFF0284C7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2563EB).withOpacity(0.35),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        app.isTimerRunning ? Icons.pause_rounded : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // End Session Button
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    app.stopTimer();
                    app.addPoints(50);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => const AiQuizGenerationScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFEF4444),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "إنهاء الجلسة",
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Shortcuts row for Ambient Sounds, Flashcards & Audio Notes
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 6,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SmartFlashcardsScreen()),
                      );
                    },
                    icon: const Icon(Icons.style_outlined, size: 16, color: Color(0xFF10B981)),
                    label: Text(
                      "البطاقات الذكية",
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AmbientSoundsScreen()),
                      );
                    },
                    icon: const Icon(Icons.headphones_rounded, size: 16, color: Color(0xFF0EA5E9)),
                    label: Text(
                      "صوتيات التركيز",
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0EA5E9),
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const AiAudioNotesScreen()),
                      );
                    },
                    icon: const Icon(Icons.mic_external_on_rounded, size: 16, color: Color(0xFF8B5CF6)),
                    label: Text(
                      "ملاحظة صوتية",
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF8B5CF6),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
