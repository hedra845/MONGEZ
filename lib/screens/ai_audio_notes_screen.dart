import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/extended_features_models.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';

class AiAudioNotesScreen extends StatefulWidget {
  const AiAudioNotesScreen({super.key});

  @override
  State<AiAudioNotesScreen> createState() => _AiAudioNotesScreenState();
}

class _AiAudioNotesScreenState extends State<AiAudioNotesScreen> {
  bool _isRecording = false;
  int _recordSeconds = 0;
  Timer? _recordTimer;
  String _selectedSubject = "الفيزياء";
  final List<String> _subjects = ["الفيزياء", "الرياضيات", "اللغة العربية", "الكيمياء", "عام"];

  @override
  void dispose() {
    _recordTimer?.cancel();
    super.dispose();
  }

  void _toggleRecording(AppProvider app) {
    if (_isRecording) {
      _recordTimer?.cancel();
      final mins = (_recordSeconds ~/ 60).toString().padLeft(2, '0');
      final secs = (_recordSeconds % 60).toString().padLeft(2, '0');
      final durationStr = "$mins:$secs";

      final newNote = AudioStudyNote(
        id: "aud_${DateTime.now().millisecondsSinceEpoch}",
        title: "تسجيل جديد: محاضرة $_selectedSubject",
        subject: _selectedSubject,
        durationText: durationStr.length <= 4 ? "0$durationStr" : durationStr,
        date: "الآن",
        transcript:
            "تم تحويل الصوت بنجاح بواسطة الذكاء الاصطناعي! يلخص هذا التسجيل أهم النقاط المطروحة في الحصة وشروحات الأستاذ مع استنتاجات سريعة.",
        bulletPoints: [
          "تم التركيز على المفاهيم الجوهرية وطرق الحل النموذجية.",
          "تنبيه المعلم على الأخطاء الشائعة التي يقع فيها الطلاب في الاختبارات.",
          "تطبيق مباشر على أمثلة عملية من امتحانات السنوات السابقة.",
        ],
        keyTerms: [
          "المفهوم الأساسي للمحاضرة",
          "القانون الرياضي المستنتج",
          "تطبيقات حياتية مباشرة",
        ],
        reviewQuestions: [
          "كيف تطبق القاعدة المذكورة في التسجيل عند تغير المعطيات؟",
          "ما الشرط الأساسي لصحة تطبيق القانون؟",
        ],
        color: _getColorForSubject(_selectedSubject),
      );

      app.addAudioNote(newNote);

      setState(() {
        _isRecording = false;
        _recordSeconds = 0;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "تم حفظ التسجيل وتوليد الملخص الذكي بنجاح! ✨",
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(),
          ),
          backgroundColor: const Color(0xFF10B981),
        ),
      );
    } else {
      setState(() {
        _isRecording = true;
        _recordSeconds = 0;
      });
      _recordTimer = Timer.periodic(const Duration(seconds: 1), (t) {
        setState(() => _recordSeconds++);
      });
    }
  }

  Color _getColorForSubject(String subj) {
    switch (subj) {
      case "الفيزياء":
        return const Color(0xFF0EA5E9);
      case "الرياضيات":
        return const Color(0xFF1E5BB8);
      case "اللغة العربية":
        return const Color(0xFF10B981);
      case "الكيمياء":
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF8B5CF6);
    }
  }

  String _formatTimer(int s) {
    final mins = (s ~/ 60).toString().padLeft(2, '0');
    final secs = (s % 60).toString().padLeft(2, '0');
    return "$mins:$secs";
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F182A) : const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            HeaderNavBar(
              title: "الملاحظات الصوتية والملخصات",
              onBack: () => Navigator.of(context).pop(),
            ),

            // Live Audio Recorder Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isRecording
                        ? [const Color(0xFFDC2626), const Color(0xFFEF4444)]
                        : (isDark
                            ? [const Color(0xFF16223B), const Color(0xFF101B2E)]
                            : [const Color(0xFF1E5BB8), const Color(0xFF0EA5E9)]),
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: (_isRecording ? const Color(0xFFEF4444) : const Color(0xFF1E5BB8))
                          .withValues(alpha: 0.28),
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
                        // Subject selector
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _selectedSubject,
                              dropdownColor: const Color(0xFF1E293B),
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                              items: _subjects.map((s) {
                                return DropdownMenuItem(
                                  value: s,
                                  child: Text(
                                    s,
                                    style: GoogleFonts.cairo(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) setState(() => _selectedSubject = val);
                              },
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _isRecording ? Colors.white : const Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _isRecording ? "جاري التسجيل الصوتي..." : "تسجيل صوتي وتفريغ ذكي",
                              style: GoogleFonts.cairo(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Mic Pulsing Button & Timer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => _toggleRecording(app),
                          child: Container(
                            width: 68,
                            height: 68,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 14,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                              size: 34,
                              color: _isRecording ? const Color(0xFFDC2626) : const Color(0xFF1E5BB8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isRecording ? _formatTimer(_recordSeconds) : "00:00",
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                            ),
                            Text(
                              _isRecording ? "اضغط للمعاينة والحفظ والتلخيص" : "اضغط لبدء تسجيل الحصة أو الفكرة",
                              style: GoogleFonts.cairo(
                                fontSize: 11,
                                color: Colors.white.withValues(alpha: 0.88),
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

            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E5BB8).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${app.audioNotes.length} تسجيلات",
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E5BB8),
                      ),
                    ),
                  ),
                  Text(
                    "المحاضرات المسجلة وملخصاتها الذكية",
                    style: GoogleFonts.cairo(
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0F2547),
                    ),
                  ),
                ],
              ),
            ),

            // Audio Notes List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                itemCount: app.audioNotes.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, idx) {
                  final note = app.audioNotes[idx];
                  return _buildAudioNoteCard(context, note, isDark, app);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAudioNoteCard(BuildContext context, AudioStudyNote note, bool isDark, AppProvider app) {
    return Container(
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
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header: Subject, Date, Delete
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444), size: 18),
                onPressed: () => app.deleteAudioNote(note.id),
              ),
              IconButton(
                icon: const Icon(Icons.copy_rounded, color: Color(0xFF64748B), size: 18),
                onPressed: () {
                  final fullText = "${note.title}\n\n${note.transcript}\n\nأهم النقاط:\n${note.bulletPoints.join('\n')}";
                  Clipboard.setData(ClipboardData(text: fullText));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("تم نسخ ملخص المحاضرة للحافظة", style: GoogleFonts.cairo(), textAlign: TextAlign.right),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
              const Spacer(),
              Text(
                note.date,
                style: GoogleFonts.cairo(
                  fontSize: 11,
                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: note.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  note.subject,
                  style: GoogleFonts.cairo(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: note.color,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Title
          Text(
            note.title,
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xFF0F2547),
            ),
          ),

          const SizedBox(height: 12),

          // Audio player simulator bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Text(
                  note.durationText,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: note.isPlaying ? 0.65 : 0.0,
                      backgroundColor: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1),
                      valueColor: AlwaysStoppedAnimation<Color>(note.color),
                      minHeight: 6,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () => app.toggleAudioPlayback(note.id),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: note.color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      note.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // AI Summary Box
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF101B2E) : const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isDark ? const Color(0xFF1E3A8A) : const Color(0xFFBFDBFE),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "الملخص المستخرج بالذكاء الاصطناعي ✨",
                      style: GoogleFonts.cairo(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E5BB8),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.auto_awesome, color: Color(0xFF1E5BB8), size: 16),
                  ],
                ),
                const SizedBox(height: 8),
                ...note.bulletPoints.map((point) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            point,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              color: isDark ? Colors.white70 : const Color(0xFF1E293B),
                              height: 1.4,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text("•", style: TextStyle(color: Color(0xFF1E5BB8), fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 8),
                // Key terms chips
                Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 6,
                  runSpacing: 4,
                  children: note.keyTerms.map((term) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.8),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xFF1E5BB8).withValues(alpha: 0.25),
                        ),
                      ),
                      child: Text(
                        term,
                        style: GoogleFonts.cairo(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1E5BB8),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
