import 'package:catbreeds/app/utils/image_util.dart';
import 'package:flutter/material.dart';

class SplashImage extends StatelessWidget {

  final double height;
  final double width;

  const SplashImage({
    super.key,
    this.height = 350.0,
    this.width = 350.0
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'splash-tag',
      child: SizedBox(
        height: height,
        width: width,
        child: Image.asset(
          ImageUtil.getImagePath('splash'),
          height: height,
          width: width,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
