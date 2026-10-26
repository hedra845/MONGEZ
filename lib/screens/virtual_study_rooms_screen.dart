import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/extended_features_models.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';

class VirtualStudyRoomsScreen extends StatefulWidget {
  const VirtualStudyRoomsScreen({super.key});

  @override
  State<VirtualStudyRoomsScreen> createState() => _VirtualStudyRoomsScreenState();
}

class _VirtualStudyRoomsScreenState extends State<VirtualStudyRoomsScreen> {
  String _selectedFilter = "الكل";
  final List<String> _filters = ["الكل", "الثانوية العامة", "هندسة وحاسبات", "مراجعات عامة"];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    final filteredRooms = _selectedFilter == "الكل"
        ? app.studyRooms
        : app.studyRooms.where((r) => r.topic.contains(_selectedFilter) || r.title.contains(_selectedFilter)).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F182A) : const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            HeaderNavBar(
              title: "غرف المذاكرة الجماعية",
              onBack: () => Navigator.of(context).pop(),
              actions: [
                IconButton(
                  tooltip: "إنشاء غرفة جديدة",
                  onPressed: () => _showCreateRoomSheet(context, app),
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

            // Live study active banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E5BB8), Color(0xFF0284C7)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1E5BB8).withValues(alpha: 0.28),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.groups_rounded, color: Colors.white, size: 28),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF10B981),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                "المذاكرة المشتركة الحية",
                                style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            "انضم لأصدقائك وتخلص من العزلة والتسويف. +140 طالباً يذاكرون الآن!",
                            textAlign: TextAlign.right,
                            style: GoogleFonts.cairo(
                              fontSize: 11.5,
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Filters
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: _filters.map((filter) {
                  final isSelected = _selectedFilter == filter;
                  return Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: InkWell(
                      onTap: () => setState(() => _selectedFilter = filter),
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF1E5BB8)
                              : (isDark ? const Color(0xFF16223B) : Colors.white),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF1E5BB8)
                                : (isDark ? const Color(0xFF1F2F4E) : const Color(0xFFE2E8F0)),
                          ),
                        ),
                        child: Text(
                          filter,
                          style: GoogleFonts.cairo(
                            fontSize: 12.5,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                            color: isSelected
                                ? Colors.white
                                : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569)),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Rooms List
            Expanded(
              child: filteredRooms.isEmpty
                  ? Center(
                      child: Text(
                        "لا توجد غرف في هذا القسم حالياً",
                        style: GoogleFonts.cairo(
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      itemCount: filteredRooms.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 14),
                      itemBuilder: (context, index) {
                        final room = filteredRooms[index];
                        return _buildRoomCard(context, room, isDark, app);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoomCard(BuildContext context, StudyRoom room, bool isDark, AppProvider app) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF16223B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFE2E8F0),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Room Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.people_alt_rounded, size: 14, color: Color(0xFF10B981)),
                    const SizedBox(width: 4),
                    Text(
                      "${room.activeMembersCount}/${room.maxMembers} طالب",
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    room.title,
                    style: GoogleFonts.cairo(
                      fontSize: 15.5,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0F2547),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: room.badgeColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            room.description,
            textAlign: TextAlign.right,
            style: GoogleFonts.cairo(
              fontSize: 12.5,
              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF5A6E8C),
              height: 1.4,
            ),
          ),

          const SizedBox(height: 14),

          // Avatars & Timer Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Enter Room Button
              ElevatedButton.icon(
                onPressed: () {
                  app.joinRoom(room);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ActiveStudyRoomScreen(room: room),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_back_rounded, size: 16, color: Colors.white),
                label: Text(
                  "انضمام للمذاكرة",
                  style: GoogleFonts.cairo(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1E5BB8),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              // Badges
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.timer_outlined, size: 14, color: room.badgeColor),
                        const SizedBox(width: 4),
                        Text(
                          "${room.focusMinutes} دقيقة تركيز",
                          style: GoogleFonts.cairo(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w600,
                            color: isDark ? Colors.white : const Color(0xFF334155),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      room.roomCode,
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showCreateRoomSheet(BuildContext context, AppProvider app) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final topicCtrl = TextEditingController();
    int focusMins = 45;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
              ),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF111A2D) : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "إنشاء غرفة مذاكرة جديدة",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F2547),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: titleCtrl,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(color: isDark ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        labelText: "اسم الغرفة (مثال: أبطال الكيمياء العضوية)",
                        labelStyle: GoogleFonts.cairo(fontSize: 13),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descCtrl,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(color: isDark ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        labelText: "وصف الغرفة وأهداف المذاكرة",
                        labelStyle: GoogleFonts.cairo(fontSize: 13),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: topicCtrl,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(color: isDark ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        labelText: "التخصص أو المادة",
                        labelStyle: GoogleFonts.cairo(fontSize: 13),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "مدة جلسة التركيز (Pomodoro): $focusMins دقيقة",
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F2547),
                      ),
                    ),
                    Slider(
                      value: focusMins.toDouble(),
                      min: 20,
                      max: 90,
                      divisions: 14,
                      activeColor: const Color(0xFF1E5BB8),
                      onChanged: (val) {
                        setModalState(() => focusMins = val.round());
                      },
                    ),
                    const SizedBox(height: 14),
                    ElevatedButton(
                      onPressed: () {
                        if (titleCtrl.text.trim().isEmpty) return;
                        final newRoom = StudyRoom(
                          id: "room_${DateTime.now().millisecondsSinceEpoch}",
                          title: titleCtrl.text.trim(),
                          description: descCtrl.text.trim().isEmpty
                              ? "جلسة مذاكرة هادئة ومنتجة"
                              : descCtrl.text.trim(),
                          topic: topicCtrl.text.trim().isEmpty ? "عام" : topicCtrl.text.trim(),
                          activeMembersCount: 1,
                          maxMembers: 20,
                          roomCode: "MNZ-${100 + DateTime.now().millisecond}",
                          focusMinutes: focusMins,
                          badgeColor: const Color(0xFF1E5BB8),
                          members: [
                            RoomMember(
                              id: "creator",
                              name: "${app.userName} (المنشئ)",
                              avatarColor: const Color(0xFF1E5BB8),
                              subject: topicCtrl.text.trim().isEmpty ? "مذاكرة" : topicCtrl.text.trim(),
                              streakDays: 14,
                              isStudying: true,
                            ),
                          ],
                        );
                        app.createStudyRoom(newRoom);
                        Navigator.pop(ctx);
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ActiveStudyRoomScreen(room: newRoom),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E5BB8),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(
                        "تأكيد وبدء الغرفة",
                        style: GoogleFonts.cairo(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// =========================================================================
// تفاصيل الغرفة النشطة والمذاكرة الحية التفاعلية
// =========================================================================
class ActiveStudyRoomScreen extends StatefulWidget {
  final StudyRoom room;
  const ActiveStudyRoomScreen({super.key, required this.room});

  @override
  State<ActiveStudyRoomScreen> createState() => _ActiveStudyRoomScreenState();
}

class _ActiveStudyRoomScreenState extends State<ActiveStudyRoomScreen> {
  late int _remainingSeconds;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = widget.room.focusMinutes * 60;
    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_remainingSeconds > 0) {
        setState(() => _remainingSeconds--);
      } else {
        _ticker?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String _formatTime(int totalSecs) {
    final m = (totalSecs ~/ 60).toString().padLeft(2, '0');
    final s = (totalSecs % 60).toString().padLeft(2, '0');
    return "$m:$s";
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
              title: widget.room.title,
              onBack: () => Navigator.of(context).pop(),
            ),

            // Synced Pomodoro Timer Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF16223B), const Color(0xFF101B2E)]
                        : [const Color(0xFF1E5BB8), const Color(0xFF0EA5E9)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1E5BB8).withValues(alpha: 0.3),
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
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "كود الغرفة: ${widget.room.roomCode}",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: Color(0xFF10B981),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              "مؤقت متزامن مباشر",
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
                    const SizedBox(height: 12),
                    Text(
                      _formatTime(_remainingSeconds),
                      style: GoogleFonts.poppins(
                        fontSize: 44,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      "جلسة تركيز جماعي عميق بدون مقاطعة 🤫",
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.88),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Members Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.room.members.length} متواجدون",
                    style: GoogleFonts.cairo(
                      fontSize: 13,
                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                    ),
                  ),
                  Text(
                    "الطلاب الحاضرون في الغرفة",
                    style: GoogleFonts.cairo(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0F2547),
                    ),
                  ),
                ],
              ),
            ),

            // Member List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: widget.room.members.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, idx) {
                  final m = widget.room.members[idx];
                  return Container(
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
                        // Cheer button
                        InkWell(
                          onTap: () {
                            app.cheerMember(widget.room.id, m.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "أرسلت تشجيعاً وتحفيزاً لـ ${m.name}! 👏🔥",
                                  textAlign: TextAlign.right,
                                  style: GoogleFonts.cairo(),
                                ),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF59E0B).withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Text("👏", style: TextStyle(fontSize: 14)),
                                const SizedBox(width: 4),
                                Text(
                                  "${m.cheersCount}",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFFF59E0B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Spacer(),

                        // Name & Subject
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "🔥 ${m.streakDays} أيام",
                                  style: GoogleFonts.cairo(
                                    fontSize: 11,
                                    color: const Color(0xFFEF4444),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  m.name,
                                  style: GoogleFonts.cairo(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white : const Color(0xFF0F2547),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              m.isStudying ? "يذاكر: ${m.subject}" : "في استراحة قصيرة ☕",
                              style: GoogleFonts.cairo(
                                fontSize: 11.5,
                                color: m.isStudying
                                    ? const Color(0xFF10B981)
                                    : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 12),

                        // Avatar
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: m.avatarColor.withValues(alpha: 0.18),
                          child: Text(
                            m.name.isNotEmpty ? m.name.characters.first : "ط",
                            style: GoogleFonts.cairo(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: m.avatarColor,
                            ),
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
    );
  }
}
