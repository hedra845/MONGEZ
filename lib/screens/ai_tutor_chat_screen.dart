import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';

class AiTutorChatScreen extends StatefulWidget {
  const AiTutorChatScreen({super.key});

  @override
  State<AiTutorChatScreen> createState() => _AiTutorChatScreenState();
}

class _AiTutorChatScreenState extends State<AiTutorChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    Provider.of<AppProvider>(context, listen: false).sendAiMessage(text);
    _controller.clear();

    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            HeaderNavBar(
              title: "المعلم الذكي الفوري (AI Tutor)",
              onBack: () => Navigator.of(context).pop(),
            ),

            // Top Status Banner
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1E5BB8).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFF1E5BB8).withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF10B981),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      "متصل ومستعد لشرح أي درس أو تلخيص أي مسألة في ثوانٍ",
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF1E5BB8),
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),

            // Messages List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: app.chatMessages.length,
                itemBuilder: (context, index) {
                  final msg = app.chatMessages[index];
                  final isAi = msg.sender == "ai";

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (isAi) ...[
                          Container(
                            width: 38,
                            height: 38,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [Color(0xFF1E5BB8), Color(0xFF0EA5E9)],
                              ),
                            ),
                            child: const Center(
                              child: Icon(Icons.smart_toy_rounded, color: Colors.white, size: 20),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isAi
                                  ? (isDark ? const Color(0xFF16223B) : Colors.white)
                                  : const Color(0xFF1E5BB8),
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(18),
                                topRight: const Radius.circular(18),
                                bottomLeft: isAi ? const Radius.circular(4) : const Radius.circular(18),
                                bottomRight: isAi ? const Radius.circular(18) : const Radius.circular(4),
                              ),
                              border: isAi
                                  ? Border.all(
                                      color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFDCE4F0),
                                    )
                                  : null,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Text(
                              msg.text,
                              style: GoogleFonts.cairo(
                                fontSize: 14,
                                height: 1.5,
                                color: isAi
                                    ? (isDark ? Colors.white : const Color(0xFF0F2547))
                                    : Colors.white,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        if (!isAi) ...[
                          const SizedBox(width: 10),
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFE2E8F0),
                            ),
                            child: const Center(
                              child: Icon(Icons.person_rounded, color: Color(0xFF1E5BB8), size: 20),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),

            // Suggested Quick Topics Chips
            SizedBox(
              height: 38,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                children: [
                  _buildQuickPromptChip("اشرح لي قاعدة التفاضل"),
                  _buildQuickPromptChip("ما هو قانون فاراداي؟"),
                  _buildQuickPromptChip("كيف أفرق بين النعت والحال؟"),
                  _buildQuickPromptChip("لخص لي جلسة المذاكرة"),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Input Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF111A2D) : Colors.white,
                border: Border(
                  top: BorderSide(
                    color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFDCE4F0),
                  ),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1E5BB8),
                      ),
                      child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                    ),
                    onPressed: _sendMessage,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: "اسأل عن أي مفهوم أو مسألة...",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: isDark ? const Color(0xFF16223B) : const Color(0xFFF1F5F9),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickPromptChip(String prompt) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: ActionChip(
        label: Text(
          prompt,
          style: GoogleFonts.cairo(fontSize: 11.5, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0EA5E9).withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        side: BorderSide.none,
        onPressed: () {
          _controller.text = prompt;
          _sendMessage();
        },
      ),
    );
  }
}
