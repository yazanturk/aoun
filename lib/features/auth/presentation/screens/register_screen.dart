import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_input.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;
  String _userType = 'user'; // 'user' | 'lawyer'
  bool _isLoading = false;

  // User fields
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passCtrl = TextEditingController();

  // Lawyer extra fields
  final _specialtyCtrl = TextEditingController();
  final _aboutCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _passCtrl.dispose();
    _specialtyCtrl.dispose();
    _aboutCtrl.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 0) {
      setState(() => _currentStep = 1);
      return;
    }
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
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.darkText, size: 20),
          onPressed: () {
            if (_currentStep > 0) {
              setState(() => _currentStep--);
            } else {
              context.go('/login');
            }
          },
        ),
        title: const Text('إنشاء حساب جديد'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWide ? 500 : double.infinity),
          child: Column(
            children: [
              _StepIndicator(currentStep: _currentStep, totalSteps: 2),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: isWide ? 40 : 24),
                  child: Form(
                    key: _formKey,
                    child: _currentStep == 0 ? _buildStep1() : _buildStep2(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        const Text(
          'نوع الحساب',
          textAlign: TextAlign.right,
          style: TextStyle(
            fontFamily: 'Cairo',
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'اختر نوع حسابك للمتابعة',
          textAlign: TextAlign.right,
          style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: AppColors.subText),
        ),
        const SizedBox(height: 32),
        _TypeCard(
          title: 'مستخدم',
          subtitle: 'أبحث عن محامٍ أو خدمة قانونية',
          icon: Icons.person_outline,
          isSelected: _userType == 'user',
          onTap: () => setState(() => _userType = 'user'),
        ),
        const SizedBox(height: 16),
        _TypeCard(
          title: 'محامٍ',
          subtitle: 'أقدم خدمات قانونية للعملاء',
          icon: Icons.gavel_outlined,
          isSelected: _userType == 'lawyer',
          onTap: () => setState(() => _userType = 'lawyer'),
        ),
        const SizedBox(height: 40),
        AppButton(label: 'متابعة', onPressed: _nextStep),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildStep2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 24),
        Text(
          _userType == 'lawyer' ? 'بيانات المحامي' : 'بياناتك الشخصية',
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontFamily: 'Cairo',
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: AppColors.darkText,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'يرجى تعبئة جميع الحقول المطلوبة',
          textAlign: TextAlign.right,
          style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: AppColors.subText),
        ),
        const SizedBox(height: 28),
        if (_userType == 'lawyer') ...[
          _AvatarUpload(),
          const SizedBox(height: 20),
        ],
        AppInput(
          hint: _userType == 'lawyer' ? 'اسم المحامي الكامل' : 'الاسم الكامل',
          label: 'الاسم',
          controller: _nameCtrl,
          prefixIcon: Icons.person_outline,
          validator: (v) => (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
        ),
        const SizedBox(height: 16),
        AppInput(
          hint: 'رقم الهاتف',
          label: 'رقم الهاتف',
          controller: _phoneCtrl,
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (v) => (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
        ),
        if (_userType == 'lawyer') ...[
          const SizedBox(height: 16),
          AppInput(
            hint: 'مثال: قانون مدني، قانون تجاري',
            label: 'التخصص',
            controller: _specialtyCtrl,
            prefixIcon: Icons.workspace_premium_outlined,
            validator: (v) => (v == null || v.isEmpty) ? 'هذا الحقل مطلوب' : null,
          ),
          const SizedBox(height: 16),
          AppInput(
            hint: 'نبذة مختصرة عن خبرتك ومجالات عملك',
            label: 'نبذة عن المحامي',
            controller: _aboutCtrl,
            maxLines: 3,
          ),
        ],
        const SizedBox(height: 16),
        AppInput(
          hint: 'كلمة المرور (٦ أحرف على الأقل)',
          label: 'كلمة المرور',
          controller: _passCtrl,
          isPassword: true,
          prefixIcon: Icons.lock_outline,
          validator: (v) => (v == null || v.length < 6) ? 'كلمة المرور قصيرة جداً' : null,
        ),
        const SizedBox(height: 32),
        AppButton(label: 'إنشاء الحساب', onPressed: _nextStep, isLoading: _isLoading),
        const SizedBox(height: 32),
      ],
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.currentStep, required this.totalSteps});
  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        children: List.generate(totalSteps, (i) {
          final active = i <= currentStep;
          return Expanded(
            child: Container(
              margin: EdgeInsets.only(right: i < totalSteps - 1 ? 6 : 0),
              height: 4,
              decoration: BoxDecoration(
                color: active ? AppColors.primary : AppColors.lightGray,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  const _TypeCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.06) : AppColors.lightGray,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: isSelected ? AppColors.white : AppColors.subText, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(title,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? AppColors.primary : AppColors.darkText,
                      )),
                  const SizedBox(height: 2),
                  Text(subtitle,
                      style: const TextStyle(
                          fontFamily: 'Cairo', fontSize: 12, color: AppColors.subText)),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 22),
          ],
        ),
      ),
    );
  }
}

class _AvatarUpload extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.divider, width: 2),
            ),
            child: const Icon(Icons.person_outline, size: 44, color: AppColors.mediumGray),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.camera_alt_outlined, size: 15, color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
