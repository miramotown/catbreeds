import 'dart:developer';

import 'package:catbreeds/app/services/secure_storage_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

/// Exports
export 'router/app_router.dart';
export 'theme/app_theme.dart';

class AppConfiguration{

  late String baseUrl;
  late String version;
  late String buildNumber;
  late String prefix;
  late int connectTimeout;
  late int receiveTimeout;
  late ByteData? cert;

  static AppConfiguration? _instance;
  static AppConfiguration get instance => _instance ?? AppConfiguration();

  static Future<void> init({
    String prefix = '',
    int connectTimeout = 60000,
    int receiveTimeout = 60000,
  }) async{

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    const String flavor = String.fromEnvironment('FLUTTER_APP_FLAVOR');

    const String apiKey = String.fromEnvironment('API_KEY', defaultValue: 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr');

    await SecureStorageService.writeSecureData('apiKey', apiKey);

    ByteData? cert;
    String baseUrl;

    if(flavor == 'prod'){
      // Production
      //cert = await rootBundle.load('assets/cert/cert_prod.cer');
      baseUrl = 'https://api.thecatapi.com/';
    }else if(flavor == 'qa'){
      // QA
      //cert = await rootBundle.load('assets/cert/cert_qa.cer');
      baseUrl = 'https://api.thecatapi.com/';
    }else if(flavor == 'dev'){
      // Development
      //cert = await rootBundle.load('assets/cert/cert_dev.cer');
      baseUrl = 'https://api.thecatapi.com/';
    }else{
      log('Flavor not defined, Development set default, example: --flavor dev');
      // Flavor Default
      //cert = await rootBundle.load('assets/cert/cert_dev.cer');
      baseUrl = 'https://api.thecatapi.com/';
    }

    _instance ??= AppConfiguration();
    _instance?.baseUrl = baseUrl;
    _instance?.version = packageInfo.version;
    _instance?.buildNumber = packageInfo.buildNumber;
    _instance?.prefix = prefix;
    _instance?.connectTimeout = connectTimeout;
    _instance?.receiveTimeout = receiveTimeout;
    _instance?.cert = cert;

    const String locale = String.fromEnvironment('LOCALE', defaultValue: 'es_PE');

    Intl.defaultLocale = locale;
    initializeDateFormatting();

  }

}