import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/ai_tutor_chat_screen.dart';

class AiAssistantItem {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color glowColor;
  final String samplePrompt;

  const AiAssistantItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.glowColor,
    required this.samplePrompt,
  });
}

class AiAssistantsSection extends StatefulWidget {
  final bool isStandaloneScreen;

  const AiAssistantsSection({
    super.key,
    this.isStandaloneScreen = false,
  });

  @override
  State<AiAssistantsSection> createState() => _AiAssistantsSectionState();
}

class _AiAssistantsSectionState extends State<AiAssistantsSection> {
  int _selectedAssistantIndex = 0;

  static const List<AiAssistantItem> assistants = [
    AiAssistantItem(
      id: "smart_assistant",
      title: "المساعد الذكي",
      subtitle: "مساعدك الشخصي الذكي",
      icon: Icons.smart_toy_rounded,
      color: Color(0xFF0EA5E9),
      glowColor: Color(0xFF38BDF8),
      samplePrompt: "أهلاً بك! أنا مساعدك الشخصي الذكي، كيف أساعدك في تنظيم جدولك ومذاكرتك اليوم؟",
    ),
    AiAssistantItem(
      id: "virtual_tutor",
      title: "المعلم الافتراضي",
      subtitle: "شرح مبسط وتفاعلي",
      icon: Icons.school_rounded,
      color: Color(0xFF2563EB),
      glowColor: Color(0xFF60A5FA),
      samplePrompt: "مرحباً! أنا معلمك الافتراضي، ما هو الدرس أو القانون العلمي الذي تود أن أشرحه لك خطوة بخطوة؟",
    ),
    AiAssistantItem(
      id: "academic_analyst",
      title: "المحلل التعليمي",
      subtitle: "تحليل أدائك وتقاريرك",
      icon: Icons.bar_chart_rounded,
      color: Color(0xFF06B6D4),
      glowColor: Color(0xFF22D3EE),
      samplePrompt: "أهلاً! قمت بتحليل معدل إنجازك في المواد. مستواك ممتاز في الرياضيات، ودعنا نرفع درجات اللغة الإنجليزية معاً!",
    ),
    AiAssistantItem(
      id: "wellness_counselor",
      title: "المستشار النفسي",
      subtitle: "دعم نفسي وتحفيزي",
      icon: Icons.favorite_rounded,
      color: Color(0xFFA855F7),
      glowColor: Color(0xFFE879F9),
      samplePrompt: "سلامتك النفسية وطاقتك هي سر تفوقك. لا تقلق من الامتحانات، خذ نفساً عميقاً وأنا هنا لأستمع إليك وأدعمك دائماً 💜",
    ),
    AiAssistantItem(
      id: "productivity_expert",
      title: "خبير الإنتاجية",
      subtitle: "نصائح لرفع كفاءتك",
      icon: Icons.bolt_rounded,
      color: Color(0xFFF59E0B),
      glowColor: Color(0xFFFBBF24),
      samplePrompt: "جاهز لإنتاجية مضاعفة؟ اليوم سنطبق تقنية فاينمان وبومودورو للقضاء التام على التسويف والمشتتات ⚡",
    ),
  ];

  void _openAssistantChat(AiAssistantItem item) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => AiTutorChatScreen(
          assistantTitle: item.title,
          assistantSubtitle: item.subtitle,
          assistantIcon: item.icon,
          assistantColor: item.color,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF060F22) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? const Color(0xFF0284C7).withValues(alpha: 0.5)
              : const Color(0xFFE2E8F0),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? const Color(0xFF0284C7).withValues(alpha: 0.2)
                : Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section Header: Chip AI Icon + Title
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "المساعدون الأذكياء",
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF0B1D3D) : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF0284C7),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF0284C7).withValues(alpha: 0.35),
                      blurRadius: 8,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  "AI",
                  style: GoogleFonts.cairo(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF00B4D8),
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // List of 5 AI Assistants
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: assistants.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final item = assistants[index];
              final isSelected = _selectedAssistantIndex == index;

              return InkWell(
                onTap: () {
                  setState(() => _selectedAssistantIndex = index);
                  _openAssistantChat(item);
                },
                borderRadius: BorderRadius.circular(18),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? (isSelected
                              ? [const Color(0xFF0B2447), const Color(0xFF07172E)]
                              : [const Color(0xFF081B38), const Color(0xFF051022)])
                          : (isSelected
                              ? [const Color(0xFFEFF6FF), const Color(0xFFDBEAFE)]
                              : [const Color(0xFFF8FAFC), const Color(0xFFF1F5F9)]),
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isDark
                          ? (isSelected
                              ? const Color(0xFF38BDF8)
                              : const Color(0xFF0284C7).withValues(alpha: 0.6))
                          : (isSelected
                              ? const Color(0xFF2563EB)
                              : const Color(0xFFE2E8F0)),
                      width: isSelected ? 1.8 : 1.2,
                    ),
                    boxShadow: [
                      if (isDark)
                        BoxShadow(
                          color: item.glowColor.withValues(alpha: isSelected ? 0.35 : 0.15),
                          blurRadius: isSelected ? 12 : 6,
                          offset: const Offset(0, 2),
                        ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Arrow (leads to chat)
                      Icon(
                        Icons.chevron_left_rounded,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        size: 22,
                      ),

                      const Spacer(),

                      // Title & Subtitle
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            item.title,
                            style: GoogleFonts.cairo(
                              fontSize: 13.5,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            item.subtitle,
                            style: GoogleFonts.cairo(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 12),

                      // Avatar / Icon Container
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF0E2242)
                              : item.color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: item.color.withValues(alpha: 0.5),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: item.glowColor.withValues(alpha: isDark ? 0.35 : 0.12),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Icon(
                          item.icon,
                          color: item.color,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 14),

          // Bottom Button: "اختيار مساعد ⭐"
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton(
              onPressed: () {
                final current = assistants[_selectedAssistantIndex];
                _openAssistantChat(current);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: isDark ? const Color(0xFF0284C7) : const Color(0xFF2563EB),
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: isDark
                    ? const Color(0xFF0B2144).withValues(alpha: 0.6)
                    : const Color(0xFFEFF6FF),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("⭐", style: TextStyle(fontSize: 13)),
                  const SizedBox(width: 6),
                  Text(
                    "اختيار مساعد",
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF1E40AF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
