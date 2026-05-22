import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class LawyersListScreen extends StatefulWidget {
  const LawyersListScreen({super.key});

  @override
  State<LawyersListScreen> createState() => _LawyersListScreenState();
}

class _LawyersListScreenState extends State<LawyersListScreen> {
  String _searchQuery = '';
  String _selectedSpecialty = 'الكل';

  final _specialties = ['الكل', 'مدني', 'تجاري', 'جنائي', 'أحوال شخصية', 'عقاري'];

  final _lawyers = [
    {
      'name': 'أحمد محمد الشريف',
      'specialty': 'قانون مدني وتجاري',
      'rating': '4.9',
      'sessions': '١٢٠',
      'available': true,
      'initials': 'أح',
      'color': AppColors.primary,
    },
    {
      'name': 'فاطمة علي الزهراني',
      'specialty': 'قانون الأسرة والأحوال الشخصية',
      'rating': '4.8',
      'sessions': '٨٥',
      'available': true,
      'initials': 'فا',
      'color': Color(0xFF9B59B6),
    },
    {
      'name': 'خالد عبدالله المطيري',
      'specialty': 'قانون جنائي',
      'rating': '4.7',
      'sessions': '٢٠٠',
      'available': false,
      'initials': 'خا',
      'color': Color(0xFFE67E22),
    },
    {
      'name': 'نورا سعد القحطاني',
      'specialty': 'قانون عقاري وتجاري',
      'rating': '4.9',
      'sessions': '٦٠',
      'available': true,
      'initials': 'نو',
      'color': Color(0xFF27AE60),
    },
    {
      'name': 'عمر يوسف الحربي',
      'specialty': 'قانون العمل والشركات',
      'rating': '4.6',
      'sessions': '١٤٥',
      'available': true,
      'initials': 'عم',
      'color': Color(0xFFC0392B),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 700;
    final isDesktop = size.width > 1100;

    final filtered = _lawyers.where((l) {
      final nameMatch = l['name'].toString().contains(_searchQuery);
      final specMatch = _selectedSpecialty == 'الكل' || l['specialty'].toString().contains(_selectedSpecialty);
      return nameMatch && specMatch;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: isDesktop ? 1000 : double.infinity),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(child: _buildHeader(isWide)),
                SliverToBoxAdapter(child: _buildSearch()),
                SliverToBoxAdapter(child: _buildFilters()),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      'اختر المحامي الخاص بك',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.darkText,
                      ),
                    ),
                  ),
                ),
                isDesktop
                    ? SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (ctx, i) => _LawyerCard(
                              lawyer: filtered[i],
                              onTap: () => context.go('/lawyers/${i + 1}'),
                            ),
                            childCount: filtered.length,
                          ),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.8,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                          ),
                        ),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, i) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                            child: _LawyerCard(
                              lawyer: filtered[i],
                              onTap: () => context.go('/lawyers/${i + 1}'),
                            ),
                          ),
                          childCount: filtered.length,
                        ),
                      ),
                const SliverToBoxAdapter(child: SizedBox(height: 20)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isWide) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      color: AppColors.white,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.lightGray,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.notifications_outlined, color: AppColors.subText, size: 22),
          ),
          const Spacer(),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('المحامون',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkText)),
              Text('ابحث عن محامٍ متخصص',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: AppColors.subText)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextField(
          textAlign: TextAlign.right,
          onChanged: (v) => setState(() => _searchQuery = v),
          decoration: const InputDecoration(
            hintText: 'ابحث عن محامٍ...',
            hintStyle: TextStyle(fontFamily: 'Cairo', color: AppColors.mediumGray, fontSize: 14),
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 14),
            prefixIcon: Icon(Icons.search, color: AppColors.mediumGray, size: 22),
          ),
          style: const TextStyle(fontFamily: 'Cairo', fontSize: 14, color: AppColors.darkText),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return Container(
      color: AppColors.white,
      padding: const EdgeInsets.only(bottom: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: _specialties.map((s) {
            final active = s == _selectedSpecialty;
            return GestureDetector(
              onTap: () => setState(() => _selectedSpecialty = s),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.only(left: 8),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: active ? AppColors.primary : AppColors.lightGray,
                  borderRadius: BorderRadius.circular(20),
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
      ),
    );
  }
}

class _LawyerCard extends StatelessWidget {
  const _LawyerCard({required this.lawyer, required this.onTap});
  final Map<String, dynamic> lawyer;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final available = lawyer['available'] as bool;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: AppColors.cardShadow, blurRadius: 12, offset: Offset(0, 3)),
          ],
        ),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: available
                        ? AppColors.success.withValues(alpha: 0.12)
                        : AppColors.mediumGray.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    available ? 'متاح' : 'مشغول',
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: available ? AppColors.success : AppColors.mediumGray,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: AppColors.secondary, size: 14),
                    const SizedBox(width: 2),
                    Text(
                      lawyer['rating'].toString(),
                      style: const TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    lawyer['name'].toString(),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkText,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    lawyer['specialty'].toString(),
                    style: const TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 12,
                      color: AppColors.subText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${lawyer['sessions']} جلسة',
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          color: AppColors.mediumGray,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.chat_bubble_outline, size: 13, color: AppColors.mediumGray),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: (lawyer['color'] as Color).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  lawyer['initials'].toString(),
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: lawyer['color'] as Color,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
