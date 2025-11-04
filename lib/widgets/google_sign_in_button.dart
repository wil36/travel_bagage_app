import 'package:flutter/material.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        side: BorderSide(color: Colors.grey[300]!),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _GoogleIcon(),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class _GoogleIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(24, 24),
      painter: _GoogleIconPainter(),
    );
  }
}

class _GoogleIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Google "G" logo colors
    final bluePaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    final redPaint = Paint()
      ..color = const Color(0xFFEA4335)
      ..style = PaintingStyle.fill;

    final yellowPaint = Paint()
      ..color = const Color(0xFFFBBC05)
      ..style = PaintingStyle.fill;

    final greenPaint = Paint()
      ..color = const Color(0xFF34A853)
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw blue section (top right)
    canvas.save();
    canvas.translate(center.dx, center.dy);
    final bluePath = Path()
      ..moveTo(0, -radius)
      ..arcTo(
        Rect.fromCircle(center: Offset.zero, radius: radius),
        -90 * 3.14159 / 180,
        90 * 3.14159 / 180,
        false,
      )
      ..lineTo(radius * 0.4, 0)
      ..lineTo(radius * 0.4, -radius * 0.4)
      ..lineTo(0, -radius * 0.4)
      ..close();
    canvas.drawPath(bluePath, bluePaint);
    canvas.restore();

    // Draw red section (top left)
    canvas.save();
    canvas.translate(center.dx, center.dy);
    final redPath = Path()
      ..moveTo(-radius, 0)
      ..arcTo(
        Rect.fromCircle(center: Offset.zero, radius: radius),
        180 * 3.14159 / 180,
        -90 * 3.14159 / 180,
        false,
      )
      ..lineTo(0, -radius * 0.4)
      ..lineTo(-radius * 0.4, -radius * 0.4)
      ..lineTo(-radius * 0.4, 0)
      ..close();
    canvas.drawPath(redPath, redPaint);
    canvas.restore();

    // Draw yellow section (bottom left)
    canvas.save();
    canvas.translate(center.dx, center.dy);
    final yellowPath = Path()
      ..moveTo(-radius, 0)
      ..arcTo(
        Rect.fromCircle(center: Offset.zero, radius: radius),
        180 * 3.14159 / 180,
        90 * 3.14159 / 180,
        false,
      )
      ..lineTo(-radius * 0.4, radius * 0.4)
      ..lineTo(-radius * 0.4, 0)
      ..close();
    canvas.drawPath(yellowPath, yellowPaint);
    canvas.restore();

    // Draw green section (bottom right)
    canvas.save();
    canvas.translate(center.dx, center.dy);
    final greenPath = Path()
      ..moveTo(0, radius)
      ..arcTo(
        Rect.fromCircle(center: Offset.zero, radius: radius),
        90 * 3.14159 / 180,
        90 * 3.14159 / 180,
        false,
      )
      ..lineTo(radius * 0.4, 0)
      ..lineTo(0, 0)
      ..lineTo(0, radius * 0.4)
      ..close();
    canvas.drawPath(greenPath, greenPaint);
    canvas.restore();

    // Draw white center
    canvas.drawCircle(
      center,
      radius * 0.4,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
