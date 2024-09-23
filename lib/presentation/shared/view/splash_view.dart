import 'package:catbreeds/presentation/shared/images/splash_image.dart';
import 'package:flutter/material.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 350.0,
          width: 350.0,
          child: SplashImage(
            width: 350.0,
            height: 350.0,
          ),
        ),
      ),
    );
  }

}
