import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:school_app/core/common/widgets/gradient_background.dart';
import 'package:school_app/core/res/media_res.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        image: MediaRes.onBoardingBackground,
        child: Center(child: Lottie.asset(MediaRes.pageUnderConstruction)),
      ),
    );
  }
}
