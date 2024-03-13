import 'package:diescam/feature/home/presentation/provider/homepage_provider.dart';
import 'package:diescam/feature/landingpage/presentation/provider/landingpage_provider.dart';
import 'package:flutter/material.dart';
import 'package:diescam/config/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LandingPageProvider()),
      ChangeNotifierProvider(create: (_) => HomePageProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRoutes appRoutes = AppRoutes();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRoutes.routes(),
    );
  }
}
