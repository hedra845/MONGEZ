import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';

class SmartFlashcardsScreen extends StatelessWidget {
  const SmartFlashcardsScreen({super.key});

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
                title: "البطاقات التعليمية الذكية",
                onBack: () => Navigator.of(context).pop(),
              ),

              const SizedBox(height: 10),

              Center(
                child: Text(
                  "انقر على أي بطاقة لكشف الإجابة أو القاعدة الذهبية",
                  style: GoogleFonts.cairo(
                    fontSize: 13,
                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF5A6E8C),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Flashcards List
              Expanded(
                child: ListView.separated(
                  itemCount: app.flashcards.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final card = app.flashcards[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(22),
                      onTap: () => app.flipFlashcard(card),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: card.isFlipped
                                ? (isDark
                                    ? [const Color(0xFF1E3A5F), const Color(0xFF16223B)]
                                    : [const Color(0xFFEFF6FF), Colors.white])
                                : (isDark
                                    ? [const Color(0xFF111A2D), const Color(0xFF16223B)]
                                    : [Colors.white, const Color(0xFFF8FAFC)]),
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: card.isFlipped
                                ? const Color(0xFF1E5BB8)
                                : (isDark ? const Color(0xFF1F2F4E) : const Color(0xFFDCE4F0)),
                            width: card.isFlipped ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: card.isFlipped
                                  ? const Color(0xFF1E5BB8).withValues(alpha: 0.15)
                                  : Colors.black.withValues(alpha: 0.03),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: (card.isFlipped ? const Color(0xFF10B981) : const Color(0xFF1E5BB8))
                                        .withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    card.isFlipped ? "الإجابة النموذجية ✓" : "سؤال مراجعة",
                                    style: GoogleFonts.cairo(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      color: card.isFlipped ? const Color(0xFF10B981) : const Color(0xFF1E5BB8),
                                    ),
                                  ),
                                ),
                                Text(
                                  card.subject,
                                  style: GoogleFonts.cairo(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF0EA5E9),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              card.isFlipped ? card.answer : card.question,
                              textAlign: TextAlign.right,
                              style: GoogleFonts.cairo(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : const Color(0xFF0F2547),
                                height: 1.5,
                              ),
                            ),
                            const SizedBox(height: 14),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  card.isFlipped ? "انقر للعودة للسؤال" : "انقر لرؤية الإجابة",
                                  style: GoogleFonts.cairo(
                                    fontSize: 11,
                                    color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF8F9FB5),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Icon(
                                  Icons.flip_rounded,
                                  size: 16,
                                  color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF8F9FB5),
                                ),
                              ],
                            ),
                          ],
                        ),
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
