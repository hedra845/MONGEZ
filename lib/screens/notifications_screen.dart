import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  NotificationType? _selectedType;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    final filteredList = _selectedType == null
        ? app.notifications
        : app.notifications.where((n) => n.type == _selectedType).toList();

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0B1324) : const Color(0xFFF6F8FC),
      body: SafeArea(
        child: Column(
          children: [
            HeaderNavBar(
              title: "الإشعارات والتنبيهات",
              onBack: () => Navigator.of(context).pop(),
              actions: [
                if (app.unreadNotificationsCount > 0)
                  TextButton.icon(
                    onPressed: () => app.markAllNotificationsAsRead(),
                    icon: const Icon(Icons.done_all_rounded, size: 16, color: Color(0xFF2563EB)),
                    label: Text(
                      "قراءة الكل",
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2563EB),
                      ),
                    ),
                  ),
              ],
            ),

            // Top Status & Filter Chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip("الكل (${app.notifications.length})", null, isDark),
                    const SizedBox(width: 8),
                    _buildFilterChip("المذاكرة 📚", NotificationType.study, isDark),
                    const SizedBox(width: 8),
                    _buildFilterChip("دعم نفسي 💖", NotificationType.support, isDark),
                    const SizedBox(width: 8),
                    _buildFilterChip("النقاط 🪙", NotificationType.rewards, isDark),
                    const SizedBox(width: 8),
                    _buildFilterChip("المواعيد 📅", NotificationType.system, isDark),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 6),

            // Notifications List
            Expanded(
              child: filteredList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark ? const Color(0xFF131D33) : const Color(0xFFEFF6FF),
                            ),
                            child: const Icon(
                              Icons.notifications_none_rounded,
                              size: 36,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            "لا توجد إشعارات حالياً",
                            style: GoogleFonts.cairo(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "صندوق إشعاراتك نظيف. استمر في التركيز والمذاكرة! ✨",
                            style: GoogleFonts.cairo(
                              fontSize: 12,
                              color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      itemCount: filteredList.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final notif = filteredList[index];
                        return _buildNotificationCard(context, notif, isDark, app);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, NotificationType? type, bool isDark) {
    final isSelected = _selectedType == type;
    return InkWell(
      onTap: () => setState(() => _selectedType = type),
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF2563EB)
              : (isDark ? const Color(0xFF131D33) : Colors.white),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF2563EB)
                : (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0)),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
            color: isSelected
                ? Colors.white
                : (isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569)),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    AppNotification notif,
    bool isDark,
    AppProvider app,
  ) {
    return Dismissible(
      key: Key(notif.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        app.deleteNotification(notif.id);
      },
      background: Container(
        padding: const EdgeInsets.only(left: 20),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: const Color(0xFFEF4444),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 24),
      ),
      child: InkWell(
        onTap: () {
          app.markNotificationAsRead(notif.id);
        },
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: notif.isRead
                ? (isDark ? const Color(0xFF131D33) : Colors.white)
                : (isDark ? const Color(0xFF162544) : const Color(0xFFF0F6FF)),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: notif.isRead
                  ? (isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0))
                  : const Color(0xFF2563EB).withValues(alpha: 0.4),
              width: notif.isRead ? 1.0 : 1.4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.015),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Unread indicator dot
              if (!notif.isRead)
                Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.only(top: 6),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2563EB),
                    shape: BoxShape.circle,
                  ),
                )
              else
                const SizedBox(width: 8),

              const SizedBox(width: 8),

              // Title, Body, Time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          notif.timeAgo,
                          style: GoogleFonts.cairo(
                            fontSize: 10.5,
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          notif.title,
                          style: GoogleFonts.cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      notif.body,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(
                        fontSize: 11.5,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569),
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // Leading Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: notif.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(notif.icon, color: notif.color, size: 22),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
