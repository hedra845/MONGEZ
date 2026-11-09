import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/extended_features_models.dart';
import '../providers/app_provider.dart';
import '../screens/virtual_study_rooms_screen.dart';

class GroupStudyRoomsFeatureCard extends StatelessWidget {
  const GroupStudyRoomsFeatureCard({super.key});

  void _joinOrCreateRoom(BuildContext context, AppProvider app, String title, String topic, int count) {
    // Find or create matching room
    StudyRoom targetRoom = app.studyRooms.firstWhere(
      (r) => r.title.contains(title) || r.topic.contains(topic),
      orElse: () {
        final newRoom = StudyRoom(
          id: "room_${DateTime.now().millisecondsSinceEpoch}",
          title: title,
          description: "جلسة مذاكرة جماعية تفاعلية للتركيز وحل التمارين",
          topic: topic,
          activeMembersCount: count,
          maxMembers: 25,
          roomCode: "MNZ-${count + 100}",
          focusMinutes: 50,
          badgeColor: const Color(0xFF2563EB),
          members: [
            RoomMember(id: "m1", name: "محمد علي", avatarColor: const Color(0xFF3B82F6), subject: topic, streakDays: 8),
            RoomMember(id: "m2", name: "سارة أحمد", avatarColor: const Color(0xFF10B981), subject: topic, streakDays: 14),
            RoomMember(id: "m3", name: "كريم يوسف", avatarColor: const Color(0xFFF59E0B), subject: topic, streakDays: 5),
          ],
        );
        app.studyRooms.insert(0, newRoom);
        return newRoom;
      },
    );

    app.joinRoom(targetRoom);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ActiveStudyRoomScreen(room: targetRoom),
      ),
    );
  }

  void _openCreateRoomSheet(BuildContext context, AppProvider app) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const VirtualStudyRoomsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.fastOutSlowIn,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF060F22) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isDark
              ? const Color(0xFF00B4D8).withValues(alpha: 0.5)
              : const Color(0xFFE2E8F0),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? const Color(0xFF0077B6).withValues(alpha: 0.25)
                : Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ==========================================
          // Header: Group Icon + Title + Subtitle
          // ==========================================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Online Indicator Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF10B981).withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "غرف حية",
                      style: GoogleFonts.cairo(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF10B981),
                      ),
                    ),
                  ],
                ),
              ),

              // Title and Subtitle with Icon
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "غرف الدراسة الجماعية",
                        style: GoogleFonts.cairo(
                          fontSize: 15.5,
                          fontWeight: FontWeight.w900,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      Text(
                        "تعلم مع أصدقائك في أي وقت",
                        style: GoogleFonts.cairo(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF0F264A)
                          : const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFF0284C7).withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00B4D8).withValues(alpha: isDark ? 0.3 : 0.1),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.groups_rounded,
                      color: Color(0xFF00B4D8),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ==========================================
          // 1. Hero Card: مجموعة الفيزياء المتقدمة
          // ==========================================
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF0A1B38), const Color(0xFF07142A)]
                    : [const Color(0xFFF8FAFC), const Color(0xFFF1F5F9)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isDark
                    ? const Color(0xFF0284C7).withValues(alpha: 0.6)
                    : const Color(0xFFCBD5E1),
                width: 1.5,
              ),
              boxShadow: [
                if (isDark)
                  BoxShadow(
                    color: const Color(0xFF0284C7).withValues(alpha: 0.2),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Graphic Illustration Container
                Container(
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                    gradient: LinearGradient(
                      colors: isDark
                          ? [const Color(0xFF0F2854), const Color(0xFF1E1B4B), const Color(0xFF09142B)]
                          : [const Color(0xFF1E3A8A), const Color(0xFF2563EB), const Color(0xFF1D4ED8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Stack(
                    children: [
                      // Holographic Globe / Study Visual Effect
                      Center(
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xFF38BDF8).withValues(alpha: 0.8),
                                const Color(0xFF0284C7).withValues(alpha: 0.4),
                                Colors.transparent,
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.public_rounded,
                            color: Color(0xFFE0F2FE),
                            size: 48,
                          ),
                        ),
                      ),

                      // Left Student Avatar Group Graphic
                      Positioned(
                        left: 16,
                        bottom: 12,
                        child: Row(
                          children: [
                            _buildAvatarWithHeadset(
                              name: "أحمد",
                              avatarColor: const Color(0xFF3B82F6),
                              isDark: isDark,
                            ),
                            const SizedBox(width: 8),
                            _buildAvatarWithHeadset(
                              name: "عمر",
                              avatarColor: const Color(0xFF6366F1),
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ),

                      // Right Student Avatar Group Graphic
                      Positioned(
                        right: 16,
                        bottom: 12,
                        child: Row(
                          children: [
                            _buildAvatarWithHeadset(
                              name: "كريم",
                              avatarColor: const Color(0xFF0284C7),
                              isDark: isDark,
                            ),
                            const SizedBox(width: 8),
                            _buildAvatarWithHeadset(
                              name: "ياسين",
                              avatarColor: const Color(0xFF0EA5E9),
                              isDark: isDark,
                            ),
                          ],
                        ),
                      ),

                      // Online Badge: "متصل الآن" (Top Right)
                      Positioned(
                        top: 10,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF064E3B).withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: const Color(0xFF34D399),
                              width: 1.2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF10B981).withValues(alpha: 0.35),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF34D399),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "متصل الآن",
                                style: GoogleFonts.cairo(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF6EE7B7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Card Details & Join Button
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    children: [
                      Text(
                        "مجموعة الفيزياء المتقدمة",
                        style: GoogleFonts.cairo(
                          fontSize: 14.5,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "12 طالباً • الجلسة الآن",
                        style: GoogleFonts.cairo(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF0284C7),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Join Button (الانضمام)
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () => _joinOrCreateRoom(
                            context,
                            app,
                            "مجموعة الفيزياء المتقدمة",
                            "الفيزياء المتقدمة",
                            12,
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF6366F1), Color(0xFF3B82F6), Color(0xFF2563EB)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF3B82F6).withValues(alpha: 0.4),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "الانضمام",
                                    style: GoogleFonts.cairo(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Icon(
                                    Icons.play_arrow_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ==========================================
          // 2. Secondary Card: مجموعة الرياضيات
          // ==========================================
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0A1830) : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: isDark
                    ? const Color(0xFF0284C7).withValues(alpha: 0.5)
                    : const Color(0xFFE2E8F0),
                width: 1.2,
              ),
            ),
            child: Row(
              children: [
                // Join Button (Pill Button)
                ElevatedButton(
                  onPressed: () => _joinOrCreateRoom(
                    context,
                    app,
                    "مجموعة الرياضيات",
                    "الرياضيات",
                    8,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    elevation: 0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "الانضمام",
                        style: GoogleFonts.cairo(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.play_arrow_rounded, size: 16),
                    ],
                  ),
                ),

                const Spacer(),

                // Room Details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "مجموعة الرياضيات",
                      style: GoogleFonts.cairo(
                        fontSize: 13.5,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      "8 طلاب • منذ 10 دقائق",
                      style: GoogleFonts.cairo(
                        fontSize: 11,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),

                const SizedBox(width: 10),

                // Left Thumbnail Preview
                Container(
                  width: 58,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF312E81), Color(0xFF1E3A8A)],
                    ),
                    border: Border.all(
                      color: const Color(0xFF0284C7).withValues(alpha: 0.4),
                    ),
                  ),
                  child: const Icon(
                    Icons.calculate_rounded,
                    color: Color(0xFF93C5FD),
                    size: 26,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ==========================================
          // 3. Bottom Button: إنشاء غرفة جديدة
          // ==========================================
          SizedBox(
            width: double.infinity,
            height: 44,
            child: OutlinedButton(
              onPressed: () => _openCreateRoomSheet(context, app),
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                  color: isDark ? const Color(0xFF00B4D8) : const Color(0xFF2563EB),
                  width: 1.4,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: isDark
                    ? const Color(0xFF061833)
                    : const Color(0xFFEFF6FF),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.groups_rounded,
                    color: Color(0xFF00B4D8),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "إنشاء غرفة جديدة",
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

  Widget _buildAvatarWithHeadset({
    required String name,
    required Color avatarColor,
    required bool isDark,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: avatarColor.withValues(alpha: 0.3),
              child: const Icon(Icons.person_rounded, color: Colors.white, size: 18),
            ),
            // Glowing Blue Headset Badge
            Positioned(
              top: -3,
              right: -3,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Color(0xFF0284C7),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.headphones_rounded,
                  color: Colors.white,
                  size: 10,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          name,
          style: GoogleFonts.cairo(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
