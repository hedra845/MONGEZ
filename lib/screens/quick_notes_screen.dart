import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../models/extended_features_models.dart';
import '../widgets/common_widgets.dart';

class QuickNotesScreen extends StatefulWidget {
  const QuickNotesScreen({super.key});

  @override
  State<QuickNotesScreen> createState() => _QuickNotesScreenState();
}

class _QuickNotesScreenState extends State<QuickNotesScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String _selectedSubject = "الرياضيات";

  void _showAddNoteDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? const Color(0xFF16223B) : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20,
            right: 20,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "تدوين ملاحظة دراسية سريعة",
                textAlign: TextAlign.center,
                style: GoogleFonts.cairo(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0F2547),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  hintText: "عنوان الفكرة أو الملاحظة...",
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _contentController,
                maxLines: 3,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  hintText: "اكتب الشرح أو القانون أو التنبيه هنا...",
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_titleController.text.trim().isNotEmpty) {
                    Provider.of<AppProvider>(context, listen: false).addNote(
                      StudyNote(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        subject: _selectedSubject,
                        title: _titleController.text.trim(),
                        content: _contentController.text.trim(),
                        date: "الآن",
                        color: const Color(0xFF1E5BB8),
                      ),
                    );
                    _titleController.clear();
                    _contentController.clear();
                    Navigator.pop(context);
                  }
                },
                child: Text("حفظ الملاحظة", style: GoogleFonts.cairo(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
    );
  }

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
                title: "الملاحظات السريعة",
                onBack: () => Navigator.of(context).pop(),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline_rounded, color: Color(0xFF1E5BB8), size: 28),
                    onPressed: _showAddNoteDialog,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              Expanded(
                child: app.notes.isEmpty
                    ? Center(
                        child: Text(
                          "لا توجد ملاحظات حالياً، اضغط + لإضافة واحدة",
                          style: GoogleFonts.cairo(color: const Color(0xFF8F9FB5)),
                        ),
                      )
                    : ListView.separated(
                        itemCount: app.notes.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 14),
                        itemBuilder: (context, index) {
                          final note = app.notes[index];
                          return Container(
                            padding: const EdgeInsets.all(18),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444), size: 20),
                                      onPressed: () => app.deleteNote(note.id),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          note.date,
                                          style: GoogleFonts.cairo(
                                            fontSize: 11,
                                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF8F9FB5),
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
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  note.title,
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : const Color(0xFF0F2547),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  note.content,
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(
                                    fontSize: 13,
                                    color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF475569),
                                    height: 1.5,
                                  ),
                                ),
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
