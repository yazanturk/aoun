import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 900));
    _fadeAnim = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 600;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWide ? 480 : double.infinity),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isWide ? 40 : 32),
            child: FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    _Logo(),
                    const SizedBox(height: 28),
                    const Text(
                      'عون',
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'خدماتك القانونية بين يديك',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.subText,
                      ),
                    ),
                    const Spacer(flex: 2),
                    _ScalesIllustration(),
                    const Spacer(flex: 3),
                    AppButton(
                      label: 'ابدأ رحلتك معنا الآن',
                      onPressed: () => context.go('/login'),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: const Text(
                        'لدي حساب بالفعل – تسجيل الدخول',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          color: AppColors.subText,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.35),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: const Center(
        child: Text(
          'ع',
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 44,
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

class _ScalesIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 200,
      child: CustomPaint(painter: _ScalesPainter()),
    );
  }
}

class _ScalesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final primaryPaint = Paint()
      ..color = AppColors.primary
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final goldPaint = Paint()
      ..color = AppColors.secondary
      ..style = PaintingStyle.fill;
    final basePaint = Paint()
      ..color = AppColors.mediumGray
      ..style = PaintingStyle.fill;

    // pole
    canvas.drawLine(Offset(cx, 20), Offset(cx, 90), primaryPaint);
    // crossbar
    canvas.drawLine(Offset(cx - 60, 38), Offset(cx + 60, 38), primaryPaint);
    // base
    final baseRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(cx, 95), width: 70, height: 10),
      const Radius.circular(5),
    );
    canvas.drawRRect(baseRect, basePaint..style = PaintingStyle.fill..color = AppColors.divider);

    // left pan
    final leftPanPaint = Paint()
      ..color = AppColors.secondary.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    final leftPanStroke = Paint()
      ..color = AppColors.secondary
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(cx - 60, 38), Offset(cx - 60, 60), primaryPaint);
    final leftPan = Rect.fromCenter(center: Offset(cx - 60, 70), width: 44, height: 20);
    canvas.drawOval(leftPan, leftPanPaint);
    canvas.drawOval(leftPan, leftPanStroke);

    // right pan (slightly lower)
    final rightPanPaint = Paint()
      ..color = AppColors.secondary.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    canvas.drawLine(Offset(cx + 60, 38), Offset(cx + 60, 68), primaryPaint);
    final rightPan = Rect.fromCenter(center: Offset(cx + 60, 78), width: 44, height: 20);
    canvas.drawOval(rightPan, rightPanPaint);
    canvas.drawOval(rightPan, leftPanStroke);

    // top knob
    canvas.drawCircle(Offset(cx, 20), 5, goldPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
