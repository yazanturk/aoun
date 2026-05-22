import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_button.dart';

class LawyerDetailsScreen extends StatelessWidget {
  const LawyerDetailsScreen({super.key, required this.lawyerId});
  final String lawyerId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 700;

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: isWide ? 600 : double.infinity),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _ProfileHeader(context: context)),
              SliverToBoxAdapter(child: _StatsRow()),
              SliverToBoxAdapter(child: _InfoSection()),
              SliverToBoxAdapter(child: _AvailabilitySection()),
              SliverToBoxAdapter(child: _ReviewsSection()),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BottomActions(),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.context});
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    return Stack(
      children: [
        Container(
          height: 280,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, Color(0xFF1A9EE0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_back_ios, color: AppColors.white, size: 18),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.bookmark_border, color: AppColors.white, size: 22),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 3),
                ),
                child: const Center(
                  child: Text('أح',
                      style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppColors.white)),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'أحمد محمد الشريف',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white),
              ),
              const SizedBox(height: 4),
              const Text(
                'قانون مدني وتجاري',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 14, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (i) => Icon(
                    i < 4 ? Icons.star_rounded : Icons.star_half_rounded,
                    color: AppColors.secondary,
                    size: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: AppColors.cardShadow, blurRadius: 16, offset: Offset(0, 4)),
          ],
        ),
        child: const Row(
          children: [
            Expanded(child: _StatItem(value: '٤.٩', label: 'التقييم', icon: Icons.star_rounded, iconColor: AppColors.secondary)),
            _Divider(),
            Expanded(child: _StatItem(value: '١٢٠', label: 'جلسة', icon: Icons.chat_bubble_outline, iconColor: AppColors.primary)),
            _Divider(),
            Expanded(child: _StatItem(value: '١٠', label: 'سنوات خبرة', icon: Icons.workspace_premium_outlined, iconColor: Color(0xFF9B59B6))),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 40, color: AppColors.divider);
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label, required this.icon, required this.iconColor});
  final String value;
  final String label;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(height: 6),
        Text(value,
            style: const TextStyle(
                fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.darkText)),
        Text(label,
            style: const TextStyle(fontFamily: 'Cairo', fontSize: 11, color: AppColors.subText)),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 12, offset: Offset(0, 3))],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('نبذة عن المحامي',
              style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          SizedBox(height: 10),
          Text(
            'محامٍ متخصص في القانون المدني والتجاري مع خبرة تتجاوز ١٠ سنوات في مجال تسوية النزاعات والتحكيم التجاري وعقود الشركات. حاصل على الإجازة الجامعية في القانون من جامعة الملك عبدالعزيز.',
            textAlign: TextAlign.right,
            style: TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.subText, height: 1.7),
          ),
          SizedBox(height: 16),
          _InfoRow(icon: Icons.phone_outlined, label: '+966 50 XXX XXXX'),
          SizedBox(height: 8),
          _InfoRow(icon: Icons.location_on_outlined, label: 'الرياض، المملكة العربية السعودية'),
          SizedBox(height: 8),
          _InfoRow(icon: Icons.access_time_outlined, label: 'الأحد – الخميس: ٩ص – ٦م'),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(label,
            style: const TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.darkText)),
        const SizedBox(width: 8),
        Icon(icon, size: 18, color: AppColors.primary),
      ],
    );
  }
}

class _AvailabilitySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final days = ['الأحد', 'الإثنين', 'الثلاثاء', 'الأربعاء', 'الخميس'];
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 12, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('أوقات العمل',
              style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: days
                .map((d) => Container(
                      margin: const EdgeInsets.only(right: 6),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(d,
                          style: const TextStyle(
                              fontFamily: 'Cairo', fontSize: 11, color: AppColors.primary, fontWeight: FontWeight.w600)),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ReviewsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 12, offset: Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('آراء العملاء',
              style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          const SizedBox(height: 12),
          _ReviewItem(name: 'محمد الغامدي', comment: 'محامٍ محترف وملتزم بالمواعيد، حل قضيتي بسرعة كبيرة.', rating: 5),
          const SizedBox(height: 10),
          _ReviewItem(name: 'سارة العتيبي', comment: 'خدمة ممتازة وتواصل واضح طوال مراحل القضية.', rating: 5),
        ],
      ),
    );
  }
}

class _ReviewItem extends StatelessWidget {
  const _ReviewItem({required this.name, required this.comment, required this.rating});
  final String name;
  final String comment;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: List.generate(rating, (_) => const Icon(Icons.star_rounded, color: AppColors.secondary, size: 14)),
              ),
              const SizedBox(width: 8),
              Text(name,
                  style: const TextStyle(
                      fontFamily: 'Cairo', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.darkText)),
            ],
          ),
          const SizedBox(height: 6),
          Text(comment,
              textAlign: TextAlign.right,
              style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: AppColors.subText, height: 1.5)),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, MediaQuery.paddingOf(context).bottom + 12),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 16, offset: Offset(0, -4))],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 1.5),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.location_on_outlined, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppButton(
              label: 'اتصل بالمحامي الآن',
              onPressed: () {},
              icon: Icons.phone_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
