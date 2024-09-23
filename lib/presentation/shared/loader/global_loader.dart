import 'package:catbreeds/app/configuration/theme/app_text_styles.dart';
import 'package:catbreeds/app/utils/image_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GlobalLoader extends StatelessWidget {

  final double width;
  final double height;
  final String? text;

  const GlobalLoader({
    super.key,
    this.width = 100.0,
    this.height = 100.0,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Lottie.asset(
              ImageUtil.getLottiePath('cat_loading'),
            ),
          ),
          Visibility(
            visible: text != null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20.0,
                ),
                Material(
                    color: Colors.transparent,
                    child: Text('$text',
                      style: AppTextStyles.poppins12regularSecondaryWhite1,
                      textAlign: TextAlign.center,
                    )
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}