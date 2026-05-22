import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/theme/app_theme.dart';
import 'router/app_router.dart';

void main() {
  runApp(const AounApp());
}

class AounApp extends StatelessWidget {
  const AounApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'عون',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: appRouter,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 480, name: MOBILE),
          const Breakpoint(start: 481, end: 850, name: TABLET),
          const Breakpoint(start: 851, end: double.infinity, name: DESKTOP),
        ],
      ),
    );
  }
}
