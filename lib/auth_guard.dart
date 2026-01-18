import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipe/app_router.gr.dart';

class OnboardingGuard extends AutoRouteGuard {
  @override
  void onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding =
        prefs.getBool('has_seen_onboarding') ?? false;

    if (hasSeenOnboarding) {
      resolver.next(true);
    } else {
      router.push(const OnboardingRoute());
      resolver.next(false);
    }
  }
}
