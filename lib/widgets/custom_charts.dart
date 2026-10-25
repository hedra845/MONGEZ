import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomWeeklyBarChart extends StatelessWidget {
  final bool isDark;
  final List<double> values;
  final List<String> labels;

  const CustomWeeklyBarChart({
    super.key,
    required this.isDark,
    required this.values,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    const double maxVal = 8.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(values.length, (index) {
        final val = values[index];
        final heightRatio = (val / maxVal).clamp(0.05, 1.0);

        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Background bar
                Container(
                  width: 18,
                  height: 110,
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                // Active bar
                Container(
                  width: 18,
                  height: 110 * heightRatio,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF38BDF8), Color(0xFF2563EB)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              labels[index],
              style: GoogleFonts.cairo(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class CustomTrendLineChart extends StatelessWidget {
  final bool isDark;
  final List<double> points; // values 0 to 100

  const CustomTrendLineChart({
    super.key,
    required this.isDark,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(double.infinity, 90),
      painter: _LineChartPainter(points: points, isDark: isDark),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> points;
  final bool isDark;

  _LineChartPainter({required this.points, required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final linePaint = Paint()
      ..color = const Color(0xFF00C6FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.5
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()
      ..color = const Color(0xFF00C6FF)
      ..style = PaintingStyle.fill;

    final dotInnerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF00C6FF).withValues(alpha: 0.25),
          const Color(0xFF00C6FF).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final stepX = size.width / (points.length - 1);
    final path = Path();
    final fillPath = Path();

    double getY(double val) {
      // Map 40..100 to size.height..0
      final normalized = ((val - 40) / 60).clamp(0.0, 1.0);
      return size.height - (normalized * size.height);
    }

    path.moveTo(0, getY(points[0]));
    fillPath.moveTo(0, size.height);
    fillPath.lineTo(0, getY(points[0]));

    for (int i = 1; i < points.length; i++) {
      final x1 = (i - 1) * stepX;
      final y1 = getY(points[i - 1]);
      final x2 = i * stepX;
      final y2 = getY(points[i]);

      final controlX = (x1 + x2) / 2;
      path.cubicTo(controlX, y1, controlX, y2, x2, y2);
      fillPath.cubicTo(controlX, y1, controlX, y2, x2, y2);
    }

    fillPath.lineTo(size.width, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, linePaint);

    // Draw dots
    for (int i = 0; i < points.length; i++) {
      final x = i * stepX;
      final y = getY(points[i]);
      canvas.drawCircle(Offset(x, y), 5.5, dotPaint);
      canvas.drawCircle(Offset(x, y), 2.5, dotInnerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) => true;
}
