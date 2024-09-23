import 'package:catbreeds/presentation/shared/images/splash_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startSplashTiming();
  }

  void startSplashTiming() async{
    await Future.delayed(const Duration(seconds: 2));
    if(mounted){
      context.push('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: SplashImage()
      ),
    );
  }
}
