import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      context.go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 600;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isWide ? 500 : double.infinity),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _Header(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: isWide ? 40 : 24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 32),
                          const Text(
                            'مرحباً بك مجدداً',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: AppColors.darkText,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'سجّل دخولك للوصول إلى خدماتك القانونية',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 14,
                              color: AppColors.subText,
                            ),
                          ),
                          const SizedBox(height: 32),
                          AppInput(
                            hint: 'رقم الهاتف أو اسم المستخدم',
                            label: 'المعرّف',
                            controller: _phoneController,
                            prefixIcon: Icons.person_outline,
                            keyboardType: TextInputType.phone,
                            validator: (v) => (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
                          ),
                          const SizedBox(height: 16),
                          AppInput(
                            hint: 'كلمة المرور',
                            label: 'كلمة المرور',
                            controller: _passwordController,
                            isPassword: true,
                            prefixIcon: Icons.lock_outline,
                            validator: (v) => (v == null || v.length < 6) ? 'كلمة المرور قصيرة جداً' : null,
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'نسيت كلمة المرور؟',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 13,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),
                          AppButton(
                            label: 'تسجيل الدخول',
                            onPressed: _submit,
                            isLoading: _isLoading,
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () => context.go('/register'),
                                child: const Text(
                                  'إنشاء حساب جديد',
                                  style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                              const Text(
                                'ليس لديك حساب؟',
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 14,
                                  color: AppColors.subText,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(36)),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Center(
              child: Text(
                'ع',
                style: TextStyle(
                  fontFamily: 'Cairo',
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'عون',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
