import 'package:diescam/config/shared_preferences.dart';
import 'package:diescam/core/constants/constants.dart';
import 'package:diescam/feature/home/presentation/page/homepage.dart';
import 'package:diescam/feature/landingpage/presentation/page/landing.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  final SharedPreferencesImpl sharedPreferencesImpl = SharedPreferencesImpl();

  GoRouter routes() {
    final GoRouter router = GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const HomePage();
          },
        ),
        GoRoute(
            path: '/landingpage',
            builder: (context, state) {
              return const LandingPage();
            })
      ],
      redirect: (context, state) async {
        if (await sharedPreferencesImpl.getBool(KisLandingPageViewed)) {
          return "/";
        }
        print("KNTOL");
        return "/landingpage";
      },
    );
    return router;
  }
}
