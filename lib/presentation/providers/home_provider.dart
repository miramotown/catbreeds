import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_provider.g.dart';

@riverpod
Future<bool> splashAnimate(SplashAnimateRef ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return true;
}

