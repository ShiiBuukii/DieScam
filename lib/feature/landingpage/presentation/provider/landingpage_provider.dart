import 'package:diescam/config/shared_preferences.dart';
import 'package:diescam/core/constants/constants.dart';
import 'package:flutter/material.dart';

class LandingPageProvider with ChangeNotifier {
  late SharedPreferencesImpl sharedPreferencesImpl;
  bool get islandingPageViewed =>
      sharedPreferencesImpl.getData(KisLandingPageViewed);
  LandingPageProvider() {
    sharedPreferencesImpl = SharedPreferencesImpl();
  }
}
