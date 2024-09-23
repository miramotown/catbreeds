import 'package:catbreeds/presentation/screens/detail/detail_screen.dart';
import 'package:catbreeds/presentation/screens/home/home_screen.dart';
import 'package:catbreeds/presentation/screens/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(AppRouterRef ref) {

  return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => CustomTransitionPage(
              transitionDuration: const Duration(milliseconds: 1500),
              key: state.pageKey,
              child: const HomeScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) => FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              )
          ),
        ),
        GoRoute(
          path: '/detail',
          builder: (context, state) => const DetailScreen(),
        )
      ]
  );
}