import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';

class CourtSpecialtyScreen extends StatefulWidget {
  const CourtSpecialtyScreen({super.key});

  @override
  State<CourtSpecialtyScreen> createState() => _CourtSpecialtyScreenState();
}

class _CourtSpecialtyScreenState extends State<CourtSpecialtyScreen> {
  String? _selectedCourt;
  String? _selectedSpecialty;

  final _courts = [
    'المحكمة العامة',
    'المحكمة الجزائية',
    'محكمة الأحوال الشخصية',
    'المحكمة التجارية',
    'المحكمة العمالية',
    'محكمة الاستئناف',
    'ديوان المظالم',
  ];

  final _specialties = [
    'قانون مدني',
    'قانون جنائي',
    'قانون تجاري',
    'قانون الأسرة',
    'قانون العمل',
    'قانون عقاري',
    'قانون الشركات',
    'تحكيم ووساطة',
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 700;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 20),
          onPressed: () => context.pop(),
        ),
        title: const Text('المحكمة والتخصص'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWide ? 540 : double.infinity),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'حدد نوع القضية',
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
                        'سيتم اقتراح المحامين الأنسب بناءً على اختيارك',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: AppColors.subText),
                      ),
                      const SizedBox(height: 32),
                      const Text('المحكمة',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.darkText)),
                      const SizedBox(height: 8),
                      _SelectionDropdown(
                        hint: 'اختر المحكمة',
                        items: _courts,
                        selected: _selectedCourt,
                        icon: Icons.account_balance_outlined,
                        onChanged: (v) => setState(() => _selectedCourt = v),
                      ),
                      const SizedBox(height: 20),
                      const Text('التخصص القانوني',
                          textAlign: TextAlign.right,
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.darkText)),
                      const SizedBox(height: 8),
                      _SelectionDropdown(
                        hint: 'اختر التخصص',
                        items: _specialties,
                        selected: _selectedSpecialty,
                        icon: Icons.gavel_outlined,
                        onChanged: (v) => setState(() => _selectedSpecialty = v),
                      ),
                      const SizedBox(height: 32),
                      const Text(
                        'التخصصات الشائعة',
                        textAlign: TextAlign.right,
                        style: TextStyle(fontFamily: 'Cairo', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.darkText),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        alignment: WrapAlignment.end,
                        spacing: 8,
                        runSpacing: 8,
                        children: _specialties.take(6).map((s) {
                          final active = s == _selectedSpecialty;
                          return GestureDetector(
                            onTap: () => setState(() => _selectedSpecialty = s),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              decoration: BoxDecoration(
                                color: active ? AppColors.primary : AppColors.lightGray,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: active ? AppColors.primary : Colors.transparent,
                                ),
                              ),
                              child: Text(
                                s,
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontSize: 13,
                                  fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                                  color: active ? AppColors.white : AppColors.subText,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(24, 12, 24, MediaQuery.paddingOf(context).bottom + 16),
                child: AppButton(
                  label: 'عرض المحامين المناسبين',
                  onPressed: (_selectedCourt != null && _selectedSpecialty != null)
                      ? () => context.go('/home')
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionDropdown extends StatelessWidget {
  const _SelectionDropdown({
    required this.hint,
    required this.items,
    required this.selected,
    required this.icon,
    required this.onChanged,
  });
  final String hint;
  final List<String> items;
  final String? selected;
  final IconData icon;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected != null ? AppColors.primary.withValues(alpha: 0.4) : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: selected != null ? AppColors.primary : AppColors.mediumGray),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selected,
                isExpanded: true,
                hint: Text(hint,
                    style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, color: AppColors.mediumGray)),
                items: items
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item,
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, color: AppColors.darkText)),
                        ))
                    .toList(),
                onChanged: onChanged,
                icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.subText),
                style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, color: AppColors.darkText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
