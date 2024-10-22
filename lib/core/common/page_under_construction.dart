import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:school_app/core/res/media_res.dart';

class UnderConstruction extends StatelessWidget {
  const UnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(MediaRes.onBoardingBackground),
              fit: BoxFit.fill),
        ),
        child: SafeArea(
          child: Center(
            child: Lottie.asset(MediaRes.pageUnderConstruction),
          ),
        ),
      ),
    );
  }
}
