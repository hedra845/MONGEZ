import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimatedThemeToggleButton extends StatelessWidget {
  final bool isDark;
  final VoidCallback onToggle;
  final bool showLabel;
  final double size;

  const AnimatedThemeToggleButton({
    super.key,
    required this.isDark,
    required this.onToggle,
    this.showLabel = false,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(size / 2),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.fastOutSlowIn,
        height: size,
        padding: showLabel
            ? const EdgeInsets.symmetric(horizontal: 10, vertical: 4)
            : EdgeInsets.all(size * 0.2),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: BorderRadius.circular(size / 2),
          border: Border.all(
            color: isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? const Color(0xFF38BDF8).withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Rotating & Morphing Animated Switcher
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return RotationTransition(
                  turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                  child: ScaleTransition(
                    scale: animation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  ),
                );
              },
              child: isDark
                  ? const Icon(
                      Icons.light_mode_rounded,
                      key: ValueKey("light_icon"),
                      size: 20,
                      color: Color(0xFFFBBF24),
                    )
                  : const Icon(
                      Icons.dark_mode_rounded,
                      key: ValueKey("dark_icon"),
                      size: 20,
                      color: Color(0xFF6366F1),
                    ),
            ),
            if (showLabel) ...[
              const SizedBox(width: 6),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 400),
                style: GoogleFonts.cairo(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white70 : const Color(0xFF475569),
                ),
                child: Text(isDark ? "نهاري" : "ليلي"),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
