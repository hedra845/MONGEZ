import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';

class SubscriptionPlansScreen extends StatefulWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  State<SubscriptionPlansScreen> createState() => _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
  int _selectedPlanIndex = 1; // الفصل الدراسي هو الافتراضي (الأكثر توفيراً)

  final List<Map<String, dynamic>> _plans = [
    {
      "id": "monthly",
      "title": "الاشتراك الشهري",
      "price": "39",
      "period": "ج.م / شهرياً",
      "tag": "مرونة كاملة",
      "color": const Color(0xFF6366F1),
      "features": [
        "فتح جميع مزايا الذكاء الاصطناعي بلا حدود",
        "المعلم الذكي AI Tutor متاح 24/7",
        "توليد اختبارات ومراجعات غير محدودة",
        "الدخول في منافسات لوحة الشرف الأسبوعية",
      ],
    },
    {
      "id": "term",
      "title": "اشتراك الفصل الدراسي",
      "price": "29",
      "period": "ج.م / شهرياً (تدفع فصلياً)",
      "tag": "الأكثر توفيراً والشائع ⭐",
      "color": const Color(0xFF7C3AED),
      "isBestValue": true,
      "features": [
        "كل مزايا الاشتراك الشهري",
        "توفير أكثر من 25% من التكلفة",
        "تأهيل رسمي لمكافأة وجائزة نهاية العام من الإدارة 🎁",
        "حزمة أصوات التركيز النادرة مجاناً",
        "أولوية في سرعة استجابة المساعد الذكي",
      ],
    },
    {
      "id": "annual",
      "title": "اشتراك العام الدراسي الكامل",
      "price": "19",
      "period": "ج.م / شهرياً (تدفع سنوياً)",
      "tag": "قيمة استثنائية 👑",
      "color": const Color(0xFFD97706),
      "features": [
        "كل مزايا الفصلي والشهري",
        "خصم ضخم لأبطال الثانوية والعام الكامل",
        "درع حماية الاستمرارية (Streak Freeze) مجاني شهرياً",
        "شارة VIP في بروفايلك وغرف المذاكرة",
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D0B18) : const Color(0xFFF7F6FD),
      body: SafeArea(
        child: Column(
          children: [
            HeaderNavBar(
              title: "باقات الاشتراك الرمزي",
              onBack: () => Navigator.of(context).pop(),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Banner: Nominal Fee Concept
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDark
                              ? [const Color(0xFF1E1435), const Color(0xFF311E63)]
                              : [const Color(0xFFEDE9FE), const Color(0xFFDDD6FE)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(
                          color: const Color(0xFF7C3AED).withValues(alpha: 0.35),
                          width: 1.2,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF7C3AED).withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Text("💎", style: TextStyle(fontSize: 26)),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "استثمار رمزي لمستقبلك وتفوقك",
                                  style: GoogleFonts.cairo(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w900,
                                    color: isDark ? Colors.white : const Color(0xFF2E1065),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "مُنجز يقدم لك منظومة متكاملة بمبلغ بسيط في متناول جميع الطلاب، لضمان استمرارية التطوير وتوفير جوائز الإدارة للمتفوقين.",
                                  style: GoogleFonts.cairo(
                                    fontSize: 11.5,
                                    fontWeight: FontWeight.w600,
                                    color: isDark ? const Color(0xFFCBD5E1) : const Color(0xFF4C1D95),
                                    height: 1.35,
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
                      "اختر الباقة المناسبة لك:",
                      style: GoogleFonts.cairo(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Plans List
                    ...List.generate(_plans.length, (index) {
                      final plan = _plans[index];
                      final isSelected = _selectedPlanIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedPlanIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 14),
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF131124) : Colors.white,
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: isSelected
                                  ? (plan["color"] as Color)
                                  : (isDark ? const Color(0xFF261F40) : const Color(0xFFE5E2F0)),
                              width: isSelected ? 2.2 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isSelected
                                    ? (plan["color"] as Color).withValues(alpha: 0.15)
                                    : Colors.black.withValues(alpha: 0.02),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // Top Row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        isSelected
                                            ? Icons.radio_button_checked_rounded
                                            : Icons.radio_button_off_rounded,
                                        color: isSelected
                                            ? (plan["color"] as Color)
                                            : const Color(0xFF94A3B8),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        plan["title"],
                                        style: GoogleFonts.cairo(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: isDark ? Colors.white : const Color(0xFF0F172A),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: (plan["color"] as Color).withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      plan["tag"],
                                      style: GoogleFonts.cairo(
                                        fontSize: 10.5,
                                        fontWeight: FontWeight.bold,
                                        color: plan["color"],
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // Price Row
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text(
                                    "${plan['price']}",
                                    style: GoogleFonts.poppins(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w900,
                                      color: isSelected
                                          ? (plan["color"] as Color)
                                          : (isDark ? Colors.white : const Color(0xFF0F172A)),
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    plan["period"],
                                    style: GoogleFonts.cairo(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),
                              Divider(
                                color: isDark ? const Color(0xFF261F40) : const Color(0xFFF1F5F9),
                              ),
                              const SizedBox(height: 8),

                              // Features List
                              ...(plan["features"] as List<String>).map(
                                (feat) => Padding(
                                  padding: const EdgeInsets.only(bottom: 6),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.check_circle_rounded,
                                        color: plan["color"],
                                        size: 16,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          feat,
                                          style: GoogleFonts.cairo(
                                            fontSize: 11.5,
                                            fontWeight: FontWeight.w600,
                                            color: isDark
                                                ? const Color(0xFFCBD5E1)
                                                : const Color(0xFF334155),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 10),

                    // Payment Guarantee & Security Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.lock_rounded, size: 14, color: Color(0xFF10B981)),
                        const SizedBox(width: 6),
                        Text(
                          "دفع آمن وفوري عبر فودافون كاش / إنستاباي / فيزا",
                          style: GoogleFonts.cairo(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF10B981),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Subscribe CTA Button
                    SizedBox(
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          final selected = _plans[_selectedPlanIndex];
                          app.activateSubscription(selected["title"]);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "تم تفعيل ${selected['title']} بنجاح! استمتع بكل المزايا 🚀",
                                textAlign: TextAlign.right,
                                style: GoogleFonts.cairo(fontWeight: FontWeight.bold),
                              ),
                              backgroundColor: const Color(0xFF10B981),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          );
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6366F1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 3,
                          shadowColor: const Color(0xFF6366F1).withValues(alpha: 0.4),
                        ),
                        child: Text(
                          "تأكيد الاشتراك الآن (${_plans[_selectedPlanIndex]['price']} ج.م)",
                          style: GoogleFonts.cairo(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
