import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../features/activity/screens/activity_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/screens/interest_setup_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/create/screens/create_screen.dart';
import '../../features/create/screens/upload_post_screen.dart';
import '../../features/all_features/routes/all_features_routes.dart';
import '../../features/all_features/screens/all_features_screen.dart';
import '../../features/explore/screens/explore_screen.dart';
import '../../features/explore/screens/location_detail_screen.dart';
import '../../features/explore/screens/weekend_recommendation_detail_screen.dart';
import '../../features/home/screens/community_story_detail_screen.dart';
import '../../features/home/screens/community_stories_list_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/main/screens/main_shell.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/profile/screens/adventure_passport_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/splash/screens/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authProvider);

  return GoRouter(
    initialLocation: AppConstants.requireAuth ? '/login' : '/main',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      if (!AppConstants.requireAuth) {
        const authOnlyRoutes = {
          '/',
          '/onboarding',
          '/login',
          '/register',
          '/interests',
        };
        if (authOnlyRoutes.contains(state.matchedLocation)) {
          return '/main';
        }
        return null;
      }

      final path = state.matchedLocation;
      final isAuth = authState.status == AuthStatus.authenticated;
      final isAuthRoute = path == '/login' || path == '/register';
      final isPublicRoute = path == '/' || path == '/onboarding' || isAuthRoute;

      if (authState.status == AuthStatus.unknown) {
        return isPublicRoute ? null : '/login';
      }

      if (!isAuth && !isPublicRoute) {
        return '/login';
      }

      if (isAuth && isAuthRoute) {
        return '/interests';
      }

      if (isAuth && (path == '/' || path == '/onboarding')) {
        return '/main';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      GoRoute(
          path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
      GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
      GoRoute(
          path: '/interests', builder: (_, __) => const InterestSetupScreen()),
      GoRoute(
        path: '/upload-post',
        builder: (_, __) => const UploadPostScreen(),
      ),
      GoRoute(
        path: '/location/:slug',
        builder: (_, state) => LocationDetailScreen(
          slug: state.pathParameters['slug']!,
        ),
      ),
      GoRoute(
        path: '/adventure-passport',
        builder: (_, __) => const AdventurePassportScreen(),
      ),
      GoRoute(
        path: AllFeaturesRoutes.allFeatures,
        builder: (_, __) => const AllFeaturesScreen(),
      ),
      GoRoute(
        path: WeekendRecommendationDetailScreen.routePath,
        builder: (_, __) => const WeekendRecommendationDetailScreen(),
      ),
      GoRoute(
        path: CommunityStoryDetailScreen.routePath,
        builder: (_, __) => const CommunityStoryDetailScreen(),
      ),
      GoRoute(
        path: CommunityStoriesListScreen.routePath,
        builder: (_, __) => const CommunityStoriesListScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) =>
            MainShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/main',
                builder: (_, __) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/main/explore',
                builder: (_, __) => const ExploreScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/main/create',
                builder: (_, __) => const CreateScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/main/activity',
                builder: (_, __) => const ActivityScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/main/profile',
                builder: (_, __) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
