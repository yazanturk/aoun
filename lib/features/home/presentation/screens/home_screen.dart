import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.child});
  final Widget child;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _tabs = [
    (label: 'الرئيسية', icon: Icons.home_outlined, activeIcon: Icons.home_rounded, route: '/home'),
    (label: 'المحامون', icon: Icons.people_outline, activeIcon: Icons.people_rounded, route: '/home/lawyers'),
    (label: 'المحفوظات', icon: Icons.bookmark_outline, activeIcon: Icons.bookmark_rounded, route: '/home/bookmarks'),
    (label: 'حسابي', icon: Icons.person_outline, activeIcon: Icons.person_rounded, route: '/home/profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDesktop = size.width > 900;

    if (isDesktop) {
      return Scaffold(
        body: Row(
          children: [
            _SideNav(
              currentIndex: _currentIndex,
              tabs: _tabs,
              onTap: (i) {
                setState(() => _currentIndex = i);
                context.go(_tabs[i].route);
              },
            ),
            Expanded(child: widget.child),
          ],
        ),
      );
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentIndex,
        tabs: _tabs,
        onTap: (i) {
          setState(() => _currentIndex = i);
          context.go(_tabs[i].route);
        },
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.currentIndex, required this.tabs, required this.onTap});
  final int currentIndex;
  final List<({String label, IconData icon, IconData activeIcon, String route})> tabs;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 20, offset: Offset(0, -4))],
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(tabs.length, (i) {
              final active = i == currentIndex;
              final tab = tabs[i];
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: active ? AppColors.primary.withValues(alpha: 0.1) : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        active ? tab.activeIcon : tab.icon,
                        color: active ? AppColors.primary : AppColors.mediumGray,
                        size: 24,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        tab.label,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 11,
                          fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                          color: active ? AppColors.primary : AppColors.mediumGray,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _SideNav extends StatelessWidget {
  const _SideNav({required this.currentIndex, required this.tabs, required this.onTap});
  final int currentIndex;
  final List<({String label, IconData icon, IconData activeIcon, String route})> tabs;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [BoxShadow(color: AppColors.cardShadow, blurRadius: 20, offset: Offset(4, 0))],
      ),
      child: Column(
        children: [
          const SizedBox(height: 48),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text('ع',
                  style: TextStyle(
                      fontFamily: 'Cairo', fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.white)),
            ),
          ),
          const SizedBox(height: 6),
          const Text('عون',
              style: TextStyle(
                  fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          const SizedBox(height: 32),
          ...List.generate(tabs.length, (i) {
            final active = i == currentIndex;
            final tab = tabs[i];
            return GestureDetector(
              onTap: () => onTap(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: active ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(active ? tab.activeIcon : tab.icon,
                        color: active ? AppColors.white : AppColors.subText, size: 22),
                    const SizedBox(width: 12),
                    Text(tab.label,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 14,
                          fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                          color: active ? AppColors.white : AppColors.subText,
                        )),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Home Tab Content ────────────────────────────────────────────────────────

class HomeTabContent extends StatelessWidget {
  const HomeTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isWide = size.width > 700;

    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _HomeHeader()),
            SliverToBoxAdapter(child: _QuickActions(isWide: isWide)),
            SliverToBoxAdapter(child: _FeaturedLawyers(isWide: isWide)),
            SliverToBoxAdapter(child: _ServicesSection()),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _HomeHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.notifications_outlined, color: AppColors.white, size: 22),
              ),
              const Spacer(),
              Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('مرحباً، أحمد',
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.white)),
                      Text('كيف يمكننا مساعدتك اليوم؟',
                          style: TextStyle(fontFamily: 'Cairo', fontSize: 12, color: Colors.white70)),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text('أح',
                          style: TextStyle(
                              fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => context.go('/home/lawyers'),
                  child: const Icon(Icons.search, color: AppColors.mediumGray, size: 22),
                ),
                Expanded(
                  child: TextField(
                    textAlign: TextAlign.right,
                    onTap: () => context.go('/home/lawyers'),
                    readOnly: true,
                    decoration: const InputDecoration(
                      hintText: 'ابحث عن محامٍ أو تخصص...',
                      hintStyle: TextStyle(fontFamily: 'Cairo', color: AppColors.mediumGray, fontSize: 13),
                      border: InputBorder.none,
                      fillColor: Colors.transparent,
                      filled: false,
                      contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  const _QuickActions({required this.isWide});
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final actions = [
      (icon: Icons.people_outline, label: 'المحامون', color: AppColors.primary, route: '/home/lawyers'),
      (icon: Icons.location_on_outlined, label: 'الموقع', color: const Color(0xFF27AE60), route: '/location'),
      (icon: Icons.account_balance_outlined, label: 'المحاكم', color: const Color(0xFFE67E22), route: '/court-specialty'),
      (icon: Icons.bookmark_outline, label: 'المحفوظات', color: const Color(0xFF9B59B6), route: '/home/bookmarks'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('الخدمات السريعة',
              style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: actions.map((a) {
              return GestureDetector(
                onTap: () => context.go(a.route),
                child: Column(
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: a.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(a.icon, color: a.color, size: 26),
                    ),
                    const SizedBox(height: 6),
                    Text(a.label,
                        style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: AppColors.darkText)),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _FeaturedLawyers extends StatelessWidget {
  const _FeaturedLawyers({required this.isWide});
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final lawyers = [
      ('أحمد الشريف', 'مدني وتجاري', '٤.٩', 'أح', AppColors.primary),
      ('فاطمة الزهراني', 'أحوال شخصية', '٤.٨', 'فا', const Color(0xFF9B59B6)),
      ('خالد المطيري', 'قانون جنائي', '٤.٧', 'خا', const Color(0xFFE67E22)),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => context.go('/home/lawyers'),
                child: const Text('عرض الكل',
                    style: TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.primary)),
              ),
              const Text('محامون مميزون',
                  style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.darkText)),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              reverse: true,
              itemCount: lawyers.length,
              itemBuilder: (ctx, i) {
                final l = lawyers[i];
                return GestureDetector(
                  onTap: () => context.go('/lawyers/${i + 1}'),
                  child: Container(
                    width: 130,
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 12, offset: Offset(0, 3))],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: l.$5.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(l.$4,
                                style: TextStyle(
                                    fontFamily: 'Cairo', fontSize: 18, fontWeight: FontWeight.w800, color: l.$5)),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(l.$1.split(' ').first,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Cairo', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.darkText)),
                        const SizedBox(height: 2),
                        Text(l.$2,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontFamily: 'Cairo', fontSize: 10, color: AppColors.subText)),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star_rounded, size: 12, color: AppColors.secondary),
                            Text(l.$3,
                                style: const TextStyle(
                                    fontFamily: 'Cairo', fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.secondary)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ServicesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final services = [
      (icon: Icons.description_outlined, title: 'صياغة العقود', desc: 'مراجعة وإعداد جميع أنواع العقود القانونية'),
      (icon: Icons.gavel_outlined, title: 'التمثيل القضائي', desc: 'الدفاع عنك أمام جميع المحاكم والهيئات'),
      (icon: Icons.handshake_outlined, title: 'التحكيم والوساطة', desc: 'حل النزاعات بطرق ودية وسريعة'),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text('خدماتنا القانونية',
              style: TextStyle(fontFamily: 'Cairo', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.darkText)),
          const SizedBox(height: 12),
          ...services.map((s) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [BoxShadow(color: AppColors.cardShadow, blurRadius: 10, offset: Offset(0, 2))],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(s.title,
                              style: const TextStyle(
                                  fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.darkText)),
                          const SizedBox(height: 3),
                          Text(s.desc,
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontFamily: 'Cairo', fontSize: 12, color: AppColors.subText)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(s.icon, color: AppColors.primary, size: 24),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

// ─── Bookmarks Tab ────────────────────────────────────────────────────────────

class BookmarksTabContent extends StatelessWidget {
  const BookmarksTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      appBar: AppBar(
        title: const Text('المحفوظات'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_outline, size: 72, color: AppColors.mediumGray.withValues(alpha: 0.4)),
            const SizedBox(height: 16),
            const Text('لا توجد محفوظات بعد',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 16, color: AppColors.subText)),
            const SizedBox(height: 8),
            const Text('احفظ محاميك المفضلين للوصول السريع',
                style: TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.mediumGray)),
          ],
        ),
      ),
    );
  }
}

// ─── Profile Tab ──────────────────────────────────────────────────────────────

class ProfileTabContent extends StatelessWidget {
  const ProfileTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 32),
              color: AppColors.white,
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text('أح',
                          style: TextStyle(
                              fontFamily: 'Cairo', fontSize: 30, fontWeight: FontWeight.w800, color: AppColors.primary)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('أحمد محمد',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.darkText)),
                  const Text('+966 50 XXX XXXX',
                      style: TextStyle(fontFamily: 'Cairo', fontSize: 13, color: AppColors.subText)),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _ProfileItem(icon: Icons.person_outline, label: 'تعديل الملف الشخصي'),
                  _ProfileItem(icon: Icons.location_on_outlined, label: 'إدارة العناوين'),
                  _ProfileItem(icon: Icons.notifications_outlined, label: 'الإشعارات'),
                  _ProfileItem(icon: Icons.language, label: 'اللغة'),
                  _ProfileItem(icon: Icons.help_outline, label: 'المساعدة والدعم'),
                  _ProfileItem(icon: Icons.logout, label: 'تسجيل الخروج', isDestructive: true, onTap: () => context.go('/login')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({required this.icon, required this.label, this.isDestructive = false, this.onTap});
  final IconData icon;
  final String label;
  final bool isDestructive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppColors.error : AppColors.darkText;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.arrow_back_ios, size: 16, color: AppColors.mediumGray),
            const Spacer(),
            Text(label,
                style: TextStyle(fontFamily: 'Cairo', fontSize: 14, fontWeight: FontWeight.w500, color: color)),
            const SizedBox(width: 12),
            Icon(icon, size: 22, color: isDestructive ? AppColors.error : AppColors.primary),
          ],
        ),
      ),
    );
  }
}
