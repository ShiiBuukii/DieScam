import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel pageViewModel1() {
  return PageViewModel(
      image: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Image.asset('assets/images/icon/android/icon.png', width: 150),
      ),
      title: "DieScam",
      body:
          "Die Scam Merupakan aplikasi untuk membanjiri atau spam endpoint api bot telegram");
}
