import 'package:auto_route/auto_route.dart';
import 'auth_guard.dart';
import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: OnboardingRoute.page,
      path: '/onboarding',
    ),

    AutoRoute(
      page: HomeRoute.page,
      path: '/',
      initial: true,
      guards: [OnboardingGuard()],
    ),
  ];
}
