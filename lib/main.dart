import 'package:catbreeds/app/services/network_service.dart';
import 'package:catbreeds/app/services/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/configuration/app_configuration.dart';
import 'presentation/providers/providers.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await SecureStorageService.init();
  await AppConfiguration.init();
  await NetworkService.initializeNetwork();

  runApp(
      const ProviderScope(child: MyApp())
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appRouter = ref.watch(appRouterProvider);
    final isDarkMode = ref.watch(darkModeProvider);

    return MaterialApp.router(
      title: 'CatBreeds',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme(
          isDarkMode: isDarkMode
      ).getTheme(),
    );
  }
}