import 'package:diescam/config/shared_preferences.dart';
import 'package:diescam/feature/landingpage/presentation/widget/pageview1.dart';
import 'package:diescam/feature/landingpage/presentation/widget/pageview2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  late SharedPreferencesImpl sharedPreferencesImpl;

  @override
  void initState() {
    super.initState();
    sharedPreferencesImpl = SharedPreferencesImpl();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        done: const Text("Done"),
        next: const Text("Continue"),
        dotsFlex: 3,
        onDone: () {},
        overrideDone: TextButton(
          child: const Text("Done"),
          onPressed: () {
            sharedPreferencesImpl.setBool('isLandingPageViewed', true);
            context.go('/');
          },
        ),
        pages: [pageViewModel1(), pageViewModel2()],
      ),
    );
  }
}
