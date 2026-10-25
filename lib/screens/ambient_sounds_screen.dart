import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';

class AmbientSoundsScreen extends StatelessWidget {
  const AmbientSoundsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderNavBar(
                title: "صوتيات التركيز الهادئة",
                onBack: () => Navigator.of(context).pop(),
              ),

              const SizedBox(height: 12),

              // Motivational Info Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF16223B), const Color(0xFF0F182A)]
                        : [const Color(0xFFEFF6FF), Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFBFDBFE),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E5BB8).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(Icons.headphones_rounded, color: Color(0xFF1E5BB8), size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "الضوضاء البيضاء وأصوات الطبيعة",
                            style: GoogleFonts.cairo(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : const Color(0xFF0F2547),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "تساعدك على عزل الضوضاء الخارجية وزيادة التركيز والاستيعاب بنسبة تصل إلى 40%",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF5A6E8C),
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Text(
                "اختر الأجواء الصوتية المفضلة لديك",
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0F2547),
                ),
              ),
              const SizedBox(height: 12),

              // Sounds List
              Expanded(
                child: ListView.separated(
                  itemCount: app.soundAtmospheres.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = app.soundAtmospheres[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF111A2D) : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: item.isPlaying
                              ? item.color
                              : (isDark ? const Color(0xFF1F2F4E) : const Color(0xFFDCE4F0)),
                          width: item.isPlaying ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: item.isPlaying
                                ? item.color.withValues(alpha: 0.15)
                                : Colors.black.withValues(alpha: 0.02),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Play/Pause Button
                              InkWell(
                                onTap: () => app.toggleSound(item),
                                borderRadius: BorderRadius.circular(14),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: item.isPlaying ? item.color : item.color.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: Icon(
                                    item.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                                    color: item.isPlaying ? Colors.white : item.color,
                                    size: 24,
                                  ),
                                ),
                              ),

                              const Spacer(),

                              // Title
                              Text(
                                item.name,
                                style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : const Color(0xFF0F2547),
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Icon
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: item.color.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Icon(item.icon, color: item.color, size: 24),
                              ),
                            ],
                          ),

                          // Volume Slider (Shown when playing)
                          if (item.isPlaying) ...[
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(Icons.volume_up_rounded, size: 18, color: Color(0xFF8F9FB5)),
                                Expanded(
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      activeTrackColor: item.color,
                                      thumbColor: item.color,
                                      trackHeight: 4,
                                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
                                    ),
                                    child: Slider(
                                      value: item.volume,
                                      onChanged: (val) {
                                        app.updateSoundVolume(item, val);
                                      },
                                    ),
                                  ),
                                ),
                                const Icon(Icons.volume_mute_rounded, size: 18, color: Color(0xFF8F9FB5)),
                              ],
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
