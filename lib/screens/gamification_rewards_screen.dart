import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../widgets/common_widgets.dart';

class GamificationRewardsScreen extends StatelessWidget {
  const GamificationRewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final app = Provider.of<AppProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              HeaderNavBar(
                title: "نظام الجوائز والأوسمة",
                onBack: null,
              ),

              const SizedBox(height: 12),

              // Streak & Coins Top Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E5BB8), Color(0xFF0EA5E9)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1E5BB8).withValues(alpha: 0.35),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Streak Column
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.local_fire_department_rounded, color: Color(0xFFFF5252), size: 28),
                            const SizedBox(width: 6),
                            Text(
                              "${app.streakDays}",
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "أيام متتالية",
                          style: GoogleFonts.cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),

                    Container(width: 1.5, height: 45, color: Colors.white.withValues(alpha: 0.25)),

                    // Mongez Coins
                    Column(
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.stars_rounded, color: Color(0xFFFFD700), size: 28),
                            const SizedBox(width: 6),
                            Text(
                              "${app.userCoins}",
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "نقاط مُنجز",
                          style: GoogleFonts.cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                "أوسمة الإنجاز والتفوق",
                textAlign: TextAlign.right,
                style: GoogleFonts.cairo(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xFF0F2547),
                ),
              ),
              const SizedBox(height: 12),

              // Badges Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: app.badges.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.74,
                ),
                itemBuilder: (context, index) {
                  final badge = app.badges[index];
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF111A2D) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: badge.isUnlocked
                            ? badge.color.withValues(alpha: 0.4)
                            : (isDark ? const Color(0xFF1F2F4E) : const Color(0xFFDCE4F0)),
                        width: badge.isUnlocked ? 1.5 : 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: badge.isUnlocked
                              ? badge.color.withValues(alpha: 0.08)
                              : Colors.black.withValues(alpha: 0.02),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: badge.isUnlocked
                                ? badge.color.withValues(alpha: 0.15)
                                : (isDark ? const Color(0xFF1F2F4E) : const Color(0xFFE2E8F0)),
                          ),
                          child: Icon(
                            badge.icon,
                            color: badge.isUnlocked ? badge.color : const Color(0xFF94A3B8),
                            size: 26,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          badge.title,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cairo(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF0F2547),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          badge.description,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.cairo(
                            fontSize: 10.5,
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF5A6E8C),
                            height: 1.25,
                          ),
                        ),
                        const SizedBox(height: 6),
                        if (badge.isUnlocked)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: badge.color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "مكتمل ✓",
                              style: GoogleFonts.cairo(
                                fontSize: 10.5,
                                fontWeight: FontWeight.bold,
                                color: badge.color,
                              ),
                            ),
                          )
                        else
                          ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: badge.progress / 100,
                              backgroundColor: isDark ? const Color(0xFF1F2F4E) : const Color(0xFFE2E8F0),
                              valueColor: AlwaysStoppedAnimation<Color>(badge.color),
                              minHeight: 6,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
