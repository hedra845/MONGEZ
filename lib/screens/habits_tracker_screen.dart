import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/extended_features_models.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';

class HabitsTrackerScreen extends StatefulWidget {
  const HabitsTrackerScreen({super.key});

  @override
  State<HabitsTrackerScreen> createState() => _HabitsTrackerScreenState();
}

class _HabitsTrackerScreenState extends State<HabitsTrackerScreen> {
  HabitCategory? _selectedCategory;
  final List<String> _daysOfWeek = ["سبت", "أحد", "إثنين", "ثلاثاء", "أربعاء", "خميس", "جمعة"];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);
    final quote = app.currentQuote;

    final filteredHabits = _selectedCategory == null
        ? app.habits
        : app.habits.where((h) => h.category == _selectedCategory).toList();

    final completionRate = app.habitsCompletionRate;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F182A) : const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Column(
          children: [
            HeaderNavBar(
              title: "تتبع العادات والدعم النفسي",
              onBack: () => Navigator.of(context).pop(),
              actions: [
                IconButton(
                  tooltip: "إضافة عادة جديدة",
                  onPressed: () => _showAddHabitSheet(context, app),
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

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // =========================================================
                    // كارت الدعم النفسي وإشعارات الطمأنينة (Psychological Support Banner)
                    // =========================================================
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDark
                              ? [const Color(0xFF1E1B4B), const Color(0xFF16223B)]
                              : [const Color(0xFF4338CA), const Color(0xFF6366F1)],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4338CA).withValues(alpha: 0.3),
                            blurRadius: 18,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Top Row: Notification Switch & Tag
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Notification status chip
                              InkWell(
                                onTap: () => _showNotificationSettingsDialog(context, app),
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.18),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        app.isSupportNotificationsEnabled
                                            ? Icons.notifications_active_rounded
                                            : Icons.notifications_off_rounded,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        app.isSupportNotificationsEnabled
                                            ? "إشعارات الدعم: ${app.notificationFrequency}"
                                            : "التنبيهات متوقفة",
                                        style: GoogleFonts.cairo(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              Row(
                                children: [
                                  Text(
                                    quote.authorOrContext,
                                    style: GoogleFonts.cairo(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withValues(alpha: 0.9),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(Icons.favorite_rounded, color: Color(0xFFF472B6), size: 16),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // Quote Message
                          Text(
                            quote.message,
                            textAlign: TextAlign.right,
                            style: GoogleFonts.cairo(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Actions Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  _showInstantSupportDialog(context, quote.message);
                                },
                                icon: const Icon(Icons.spa_rounded, size: 16, color: Color(0xFF4338CA)),
                                label: Text(
                                  "جرعة دعم فوري 💖",
                                  style: GoogleFonts.cairo(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF4338CA),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),

                              // Next random quote
                              InkWell(
                                onTap: () => app.nextRandomQuote(),
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "جملة أخرى",
                                        style: GoogleFonts.cairo(
                                          fontSize: 11.5,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(Icons.cached_rounded, size: 15, color: Colors.white),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // =========================================================
                    // شريط إنجاز العادات الأسبوعي (Weekly Habits Progress)
                    // =========================================================
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF16223B) : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFE2E8F0),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 10,
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
                              Text(
                                "${app.completedTodayHabitsCount} من ${app.habits.length} منجز اليوم",
                                style: GoogleFonts.cairo(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF10B981),
                                ),
                              ),
                              Text(
                                "إنجاز العادات اليومي والأسبوعي",
                                style: GoogleFonts.cairo(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : const Color(0xFF0F2547),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: completionRate,
                              backgroundColor: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF10B981)),
                              minHeight: 10,
                            ),
                          ),
                          const SizedBox(height: 14),

                          // Days of week indicator
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(7, (i) {
                              final isToday = i == 6; // last day is today
                              return Column(
                                children: [
                                  Text(
                                    _daysOfWeek[i],
                                    style: GoogleFonts.cairo(
                                      fontSize: 11,
                                      color: isToday
                                          ? const Color(0xFF1E5BB8)
                                          : (isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
                                      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isToday
                                          ? const Color(0xFF1E5BB8)
                                          : (const Color(0xFF10B981).withValues(alpha: i < 5 ? 0.8 : 0.2)),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        i < 5 || (isToday && completionRate > 0.5)
                                            ? Icons.check
                                            : Icons.circle,
                                        size: i < 5 || (isToday && completionRate > 0.5) ? 14 : 6,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Category Filter Chips
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildFilterChip("الكل", null),
                          const SizedBox(width: 8),
                          _buildFilterChip("دراسة 📚", HabitCategory.study),
                          const SizedBox(width: 8),
                          _buildFilterChip("صحة ونشاط 🏃", HabitCategory.health),
                          const SizedBox(width: 8),
                          _buildFilterChip("دعم وهدوء 🧘", HabitCategory.mindset),
                          const SizedBox(width: 8),
                          _buildFilterChip("تنظيم وقت ⏱️", HabitCategory.timeManagement),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Habits List Header
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "اضغط على العادة لتأكيد إنجازها اليوم",
                          style: GoogleFonts.cairo(
                            fontSize: 11.5,
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                        ),
                        Text(
                          "عاداتك اليومية",
                          style: GoogleFonts.cairo(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF0F2547),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Habits items
                    ...filteredHabits.map((habit) {
                      return _buildHabitCard(context, habit, isDark, app);
                    }),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, HabitCategory? category) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = _selectedCategory == category;
    return InkWell(
      onTap: () => setState(() => _selectedCategory = category),
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

  Widget _buildHabitCard(BuildContext context, HabitItem habit, bool isDark, AppProvider app) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => app.toggleHabit(habit.id),
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF16223B) : Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: habit.isCompletedToday
                  ? const Color(0xFF10B981).withValues(alpha: 0.5)
                  : (isDark ? const Color(0xFF1F2F4E) : const Color(0xFFE2E8F0)),
              width: habit.isCompletedToday ? 1.5 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.02),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              // Checkbox indicator
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: habit.isCompletedToday
                      ? const Color(0xFF10B981)
                      : (isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9)),
                  border: Border.all(
                    color: habit.isCompletedToday
                        ? const Color(0xFF10B981)
                        : (isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
                    width: 2,
                  ),
                ),
                child: habit.isCompletedToday
                    ? const Icon(Icons.check, color: Colors.white, size: 18)
                    : null,
              ),

              const SizedBox(width: 12),

              // Streak Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Text("🔥", style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 2),
                    Text(
                      "${habit.streakDays}d",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFEF4444),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // Title and Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      habit.title,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F2547),
                        decoration: habit.isCompletedToday ? TextDecoration.lineThrough : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      habit.description,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.cairo(
                        fontSize: 11.5,
                        color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              // Leading Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: habit.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(habit.icon, color: habit.color, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNotificationSettingsDialog(BuildContext context, AppProvider app) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF111A2D) : Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
              ),
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
                    "إعدادات إشعارات الدعم النفسي 🔔",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.cairo(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : const Color(0xFF0F2547),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: Text(
                      "تفعيل إشعارات الدعم والتحفيز",
                      style: GoogleFonts.cairo(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Text(
                      "استلام رسائل تطمين نفسي في أوقات المذاكرة والضغط",
                      style: GoogleFonts.cairo(fontSize: 11.5),
                    ),
                    value: app.isSupportNotificationsEnabled,
                    activeColor: const Color(0xFF4338CA),
                    onChanged: (val) {
                      app.toggleSupportNotifications(val);
                      setSheetState(() {});
                    },
                  ),
                  const Divider(),
                  Text(
                    "تكرار إرسال جمل الدعم:",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    alignment: WrapAlignment.end,
                    children: ["كل ساعة", "كل ساعتين", "كل 4 ساعات", "مرتان يومياً"].map((freq) {
                      final isSelected = app.notificationFrequency == freq;
                      return ChoiceChip(
                        label: Text(freq, style: GoogleFonts.cairo(fontSize: 12)),
                        selected: isSelected,
                        selectedColor: const Color(0xFF4338CA),
                        labelStyle: TextStyle(color: isSelected ? Colors.white : null),
                        onSelected: (_) {
                          app.setNotificationFrequency(freq);
                          setSheetState(() {});
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(ctx),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4338CA),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      "حفظ الإعدادات",
                      style: GoogleFonts.cairo(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showInstantSupportDialog(BuildContext context, String currentMsg) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: isDark ? const Color(0xFF111A2D) : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "رسالة لك من القلب 💌",
                style: GoogleFonts.cairo(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0F2547),
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.favorite_rounded, color: Color(0xFFEC4899)),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF4338CA).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFF4338CA).withValues(alpha: 0.3)),
                ),
                child: Text(
                  currentMsg,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.cairo(
                    fontSize: 14,
                    height: 1.6,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF1E1B4B),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.air_rounded, color: Color(0xFF10B981), size: 18),
                  const SizedBox(width: 6),
                  Text(
                    "خذ نفساً عميقاً، أنت أقوى مما تظن 🌿",
                    style: GoogleFonts.cairo(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4338CA),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text(
                "شكراً، استعدت همّتي!",
                style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddHabitSheet(BuildContext context, AppProvider app) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    HabitCategory selectedCategory = HabitCategory.study;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return StatefulBuilder(
          builder: (context, setSheetState) {
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
                      "إضافة عادة دراسية أو صحية جديدة",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.cairo(
                        fontSize: 17,
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
                        labelText: "اسم العادة (مثال: حفظ 20 كلمة إنجليزية)",
                        labelStyle: GoogleFonts.cairo(fontSize: 12.5),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descCtrl,
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(color: isDark ? Colors.white : Colors.black),
                      decoration: InputDecoration(
                        labelText: "وصف العادة والهدف منها",
                        labelStyle: GoogleFonts.cairo(fontSize: 12.5),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      "تصنيف العادة:",
                      textAlign: TextAlign.right,
                      style: GoogleFonts.cairo(fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 8,
                      alignment: WrapAlignment.end,
                      children: [
                        _buildCategoryChoice("دراسة", HabitCategory.study, selectedCategory, (c) {
                          setSheetState(() => selectedCategory = c);
                        }),
                        _buildCategoryChoice("صحة", HabitCategory.health, selectedCategory, (c) {
                          setSheetState(() => selectedCategory = c);
                        }),
                        _buildCategoryChoice("دعم نفسي", HabitCategory.mindset, selectedCategory, (c) {
                          setSheetState(() => selectedCategory = c);
                        }),
                        _buildCategoryChoice("تنظيم وقت", HabitCategory.timeManagement, selectedCategory, (c) {
                          setSheetState(() => selectedCategory = c);
                        }),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        if (titleCtrl.text.trim().isEmpty) return;
                        app.addHabit(
                          HabitItem(
                            id: "h_${DateTime.now().millisecondsSinceEpoch}",
                            title: titleCtrl.text.trim(),
                            description: descCtrl.text.trim().isEmpty
                                ? "عادة يومية للاستمرار والنجاح"
                                : descCtrl.text.trim(),
                            category: selectedCategory,
                            icon: _getIconForCategory(selectedCategory),
                            color: _getColorForCategory(selectedCategory),
                            streakDays: 0,
                            isCompletedToday: false,
                            weeklyHistory: [false, false, false, false, false, false, false],
                          ),
                        );
                        Navigator.pop(ctx);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E5BB8),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      ),
                      child: Text(
                        "إضافة العادة والبدء بالالتزام 🚀",
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

  Widget _buildCategoryChoice(
    String label,
    HabitCategory cat,
    HabitCategory current,
    Function(HabitCategory) onSelect,
  ) {
    final isSelected = cat == current;
    return ChoiceChip(
      label: Text(label, style: GoogleFonts.cairo(fontSize: 12)),
      selected: isSelected,
      selectedColor: const Color(0xFF1E5BB8),
      labelStyle: TextStyle(color: isSelected ? Colors.white : null),
      onSelected: (_) => onSelect(cat),
    );
  }

  IconData _getIconForCategory(HabitCategory cat) {
    switch (cat) {
      case HabitCategory.study:
        return Icons.menu_book_rounded;
      case HabitCategory.health:
        return Icons.directions_run_rounded;
      case HabitCategory.mindset:
        return Icons.spa_rounded;
      case HabitCategory.timeManagement:
        return Icons.alarm_on_rounded;
    }
  }

  Color _getColorForCategory(HabitCategory cat) {
    switch (cat) {
      case HabitCategory.study:
        return const Color(0xFF1E5BB8);
      case HabitCategory.health:
        return const Color(0xFF0EA5E9);
      case HabitCategory.mindset:
        return const Color(0xFF10B981);
      case HabitCategory.timeManagement:
        return const Color(0xFFF59E0B);
    }
  }
}
