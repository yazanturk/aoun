import 'package:go_router/go_router.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/lawyers/presentation/screens/lawyers_list_screen.dart';
import '../features/lawyers/presentation/screens/lawyer_details_screen.dart';
import '../features/location/presentation/screens/location_selection_screen.dart';
import '../features/location/presentation/screens/court_specialty_screen.dart';
import '../features/home/presentation/screens/home_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (ctx, state) => const SplashScreen()),
    GoRoute(path: '/login', builder: (ctx, state) => const LoginScreen()),
    GoRoute(path: '/register', builder: (ctx, state) => const RegisterScreen()),
    GoRoute(path: '/location', builder: (ctx, state) => const LocationSelectionScreen()),
    GoRoute(path: '/court-specialty', builder: (ctx, state) => const CourtSpecialtyScreen()),
    GoRoute(
      path: '/lawyers/:id',
      builder: (ctx, state) => LawyerDetailsScreen(lawyerId: state.pathParameters['id']!),
    ),
    ShellRoute(
      builder: (ctx, state, child) => HomeScreen(child: child),
      routes: [
        GoRoute(path: '/home', builder: (ctx, state) => const HomeTabContent()),
        GoRoute(path: '/home/lawyers', builder: (ctx, state) => const LawyersListScreen()),
        GoRoute(path: '/home/bookmarks', builder: (ctx, state) => const BookmarksTabContent()),
        GoRoute(path: '/home/profile', builder: (ctx, state) => const ProfileTabContent()),
      ],
    ),
  ],
);
