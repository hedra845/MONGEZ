import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import 'gamification_rewards_screen.dart';

class StudyWalletScreen extends StatelessWidget {
  const StudyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    final transactions = [
      {
        "title": "إتمام جلسة بومودورو (45 دقيقة)",
        "date": "اليوم 6:30 م",
        "amount": "+50",
        "isCredit": true,
        "icon": Icons.timer_rounded,
        "color": const Color(0xFF10B981),
      },
      {
        "title": "الفوز بمسابقة الفيزياء السريعة",
        "date": "اليوم 4:15 م",
        "amount": "+150",
        "isCredit": true,
        "icon": Icons.emoji_events_rounded,
        "color": const Color(0xFFF59E0B),
      },
      {
        "title": "استبدال درع حماية الاستمرارية",
        "date": "أمس 9:00 م",
        "amount": "-180",
        "isCredit": false,
        "icon": Icons.shield_rounded,
        "color": const Color(0xFFEF4444),
      },
      {
        "title": "مكافأة الحضور اليومي والالتزام",
        "date": "أمس 8:00 ص",
        "amount": "+40",
        "isCredit": true,
        "icon": Icons.card_giftcard_rounded,
        "color": const Color(0xFF0EA5E9),
      },
      {
        "title": "إنجاز 3 اختبارات بنك الأسئلة",
        "date": "24 أكتوبر",
        "amount": "+90",
        "isCredit": true,
        "icon": Icons.quiz_rounded,
        "color": const Color(0xFF8B5CF6),
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF070F1E) : const Color(0xFFF1F5F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: isDark ? Colors.white : const Color(0xFF0F172A),
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF0284C7).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFF0284C7).withValues(alpha: 0.5)),
              ),
              child: const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF0284C7), size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              "محفظتي (Study Coins)",
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Glowing Digital Wallet Card
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF075985), Color(0xFF0284C7), Color(0xFF0369A1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFF38BDF8).withValues(alpha: 0.6),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0284C7).withValues(alpha: 0.35),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
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
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          "بطاقة المتفوق الذهبية",
                          style: GoogleFonts.cairo(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "مُنجز PAY",
                            style: GoogleFonts.cairo(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(Icons.contactless_rounded, color: Colors.white, size: 20),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "رصيدك الحالي من الكوينز",
                    textAlign: TextAlign.right,
                    style: GoogleFonts.cairo(
                      fontSize: 12.5,
                      color: Colors.white70,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        "كوينز",
                        style: GoogleFonts.cairo(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFBAE6FD),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${app.userCoins}",
                        style: GoogleFonts.cairo(
                          fontSize: 44,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.monetization_on_rounded, color: Color(0xFFFDE047), size: 36),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Ahmed Mohamed • ID: 29481",
                        style: GoogleFonts.cairo(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w600,
                          color: Colors.white60,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.shield_rounded, color: Color(0xFF38BDF8), size: 14),
                          const SizedBox(width: 4),
                          Text(
                            "محفظة آمنة وموثقة",
                            style: GoogleFonts.cairo(
                              fontSize: 10.5,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Quick Actions Bar
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const GamificationRewardsScreen()),
                      );
                    },
                    icon: const Icon(Icons.redeem_rounded, size: 18),
                    label: Text(
                      "استبدال الجوائز",
                      style: GoogleFonts.cairo(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0284C7),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      app.addPoints(50);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "مبروك! حصلت على 50 كوينز مجانية لدعم مذاكرتك 🎁",
                            style: GoogleFonts.cairo(),
                          ),
                          backgroundColor: const Color(0xFF0284C7),
                        ),
                      );
                    },
                    icon: const Icon(Icons.card_giftcard_rounded, size: 18, color: Color(0xFF0284C7)),
                    label: Text(
                      "هدية الكوينز اليومية",
                      style: GoogleFonts.cairo(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF0284C7)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // Transactions Title
            Text(
              "سجل كسب واستخدام الكوينز",
              textAlign: TextAlign.right,
              style: GoogleFonts.cairo(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 10),

            // Transactions List
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: transactions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final tx = transactions[index];
                final color = tx["color"] as Color;
                final isCredit = tx["isCredit"] as bool;

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0E1726) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "${tx['amount']} كوينز",
                        style: GoogleFonts.cairo(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: isCredit ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                        ),
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            tx["title"] as String,
                            style: GoogleFonts.cairo(
                              fontSize: 12.5,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : const Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            tx["date"] as String,
                            style: GoogleFonts.cairo(fontSize: 10, color: const Color(0xFF64748B)),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(tx["icon"] as IconData, color: color, size: 20),
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
