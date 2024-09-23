import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:catbreeds/app/configuration/app_configuration.dart';
import 'package:catbreeds/app/extensions/string_extension.dart';
import 'package:catbreeds/app/services/secure_storage_service.dart';
import 'package:catbreeds/app/types/enum_type.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';

class NetworkService{

  static Dio dio = Dio();

  static Future<void> initializeNetwork() async{
    dio = Dio(
        BaseOptions(
          baseUrl: AppConfiguration.instance.baseUrl,
          connectTimeout: Duration(milliseconds: AppConfiguration.instance.connectTimeout),
          receiveTimeout: Duration(milliseconds: AppConfiguration.instance.receiveTimeout),
        )
    );
    dio.interceptors.add(TalkerDioLogger(
        settings: const TalkerDioLoggerSettings(
          printRequestHeaders: true,
        )
    ));
  }

  Future<dynamic> fetch({
    String url = '',
    String? baseUrl,
    bool fingerprint = true,
    Map<String, String>? headers,
    bool bearerToken = false,
    Map<String, dynamic>? formData,
    Map<String, dynamic>? bodyRaw,
    Encoding? encoding,
    Map<String, dynamic>? queryParameters,
    DioRequest requestMethod = DioRequest.get,
  }) async {

    if (!await checkInternetConnection()) throw Exception(['NOT_INTERNET_EXCEPTION']);

    if (bearerToken) {
      String currentToken = await SecureStorageService.readSecureData('apiKey');

      if(currentToken.isEmpty){
        dio.options.headers.remove("x-api-key");
      }else{
        dio.options.headers.addAll({'x-api-key': currentToken});
      }
    } else {
      dio.options.headers.remove("x-api-key");
    }

    if (headers != null) {
      dio.options.headers.addAll(headers);
    }

    dio.options.contentType = Headers.jsonContentType;
    dio.options.baseUrl = baseUrl ?? AppConfiguration.instance.baseUrl;

    String? methodName;
    switch (requestMethod) {
      case DioRequest.get:
        methodName = 'GET';
        break;
      case DioRequest.post:
        methodName = 'POST';
        break;
      case DioRequest.put:
        methodName = 'PUT';
        break;
      case DioRequest.patch:
        methodName = 'PATCH';
        break;
      case DioRequest.delete:
        methodName = 'DELETE';
        break;
    }

    late Response response;

    try {
      switch (requestMethod) {
        case DioRequest.get:
          response = await dio.get(url,
              options: Options(
                method: methodName,
                responseType: ResponseType.json,
              ),
              queryParameters: queryParameters);
          break;
        case DioRequest.post:
          response = await dio.post(url,
              data: bodyRaw ?? FormData.fromMap(formData!),
              options: Options(
                method: methodName,
                responseType: ResponseType.json,
              ),
              queryParameters: queryParameters);
          break;
        case DioRequest.put:
          response = await dio.put(url,
              data: bodyRaw ?? FormData.fromMap(formData!),
              options: Options(
                method: methodName,
                responseType: ResponseType.json,
              ),
              queryParameters: queryParameters);
          break;
        case DioRequest.patch:
          response = await dio.patch(url,
              data: bodyRaw ?? FormData.fromMap(formData!),
              options: Options(
                method: methodName,
                responseType: ResponseType.json,
              ),
              queryParameters: queryParameters);
          break;
        case DioRequest.delete:
          response = await dio.delete(url,
              data: bodyRaw ?? FormData.fromMap(formData!),
              options: Options(
                method: methodName,
                responseType: ResponseType.json,
              ),
              queryParameters: queryParameters);
          break;
      }

      return response.data;
    } catch (exception) {
      bool exceptionIsNotSaved = true;
      DioException? dioException = exception as DioException?;
      if (dioException != null) {
        if (dioException.type == DioExceptionType.unknown) {
          if (dioException.message != null) {
            if ((dioException.message!).contains("Software caused connection abort")) {
              throw Exception(['abort_connection']);
            }
            if ((dioException.message!).contains("Connection refused")) {
              throw Exception(['refused_connection']);
            }

            throw Exception(['unknown_exception']);

          }

          if (dioException.error != null) {
            if (dioException.error is TlsException) {
              final tlsException = dioException.error as TlsException;
              if ((tlsException.message).contains("Failure trusting builtin roots")) {
                throw Exception(['bad_certificate']);
              }
            }

            if (dioException.error is HandshakeException) {
              final handshakeException = dioException.error as HandshakeException;
              if ((handshakeException.message).contains("Handshake error in client")) {
                throw Exception(['handshake_exception']);
              }
            }

            if (dioException.error is SocketException) {
              final socketException = dioException.error as SocketException;
              if ((socketException.message).contains("Failed host lookup")) {
                throw Exception(['socket_exception']);
              }
              if ((socketException.message).contains("Software caused connection abort")) {
                throw Exception(['abort_connection']);
              }
            }
          }
        }else if(dioException.type == DioExceptionType.connectionError){
          throw Exception(['NOT_INTERNET_EXCEPTION']);
        }

        if ([500, 503, 504].contains(dioException.response?.statusCode)) {

          log('network_service - statusCode.runtimeType - runtimeType - ${dioException.response?.statusCode.runtimeType}');
          log('network_service - dioException - ${dioException.response?.statusCode}');

          if (dioException.response?.statusCode == 500) {
            log('server - error 0');
            throw Exception(['SERVER_ERROR']);
          }

          // TODO: Provisional para manejo de errores 500
          if ([504].contains(dioException.response?.statusCode)) {
            throw Exception(
                [
                  "${dioException.response?.data}"
                      .removeHtmlTags()
                      .replaceAll("[", "")
                      .replaceAll("]", "")
                      .trim()
                ]
            );
          }

          if (dioException.response?.statusCode == 500 && dioException.response?.data["error"] == "unexpected_exception") {
            log('server - error 1');
            throw Exception(['unexpected_exception']);
          } else if(dioException.response?.statusCode == 500 && dioException.response?.data["code"] == 500) {
            log('server - error 2');
            return dioException.response?.data;
          } else{
            log('server - error 3');
            throw Exception(['SERVER_ERROR']);
          }
        }

        if ([502].contains(dioException.response?.statusCode)) {
          throw Exception(['PROXY_ERROR']);
        }

        if (dioException.response?.statusCode == 405) {
          if (dioException.response?.statusMessage == "Not Allowed") {
            throw Exception(['not_allowed']);
          }
        }

        if ((dioException.response?.statusCode == 412 || dioException.response?.statusCode == 424) && dioException.response?.data is Map<String, dynamic>) {
          return dioException.response?.data;
        }

        if (dioException.response?.statusCode == 404) {
          if (dioException.response?.data["error"] == "Not found") {
            throw Exception(['denied_access']);
          }
        }

        if (dioException.response?.statusCode == 401) {
          if (dioException.response?.data["error"] == "invalid_grant") {
            throw Exception(['account_blocked']);
          }
          if (dioException.response?.data["error"] == "invalid_token") {
            throw Exception(['invalid_token']);
          }
          if (dioException.response?.data["message"] == "Acceso denegado") {
            throw Exception(['denied_access']);
          }
          if (dioException.response?.data["message"] == "unauthorized") {
            throw Exception(['unauthorized']);
          }
        }

        if (dioException.response?.statusCode == 400) {
          if (dioException.response?.data["error"] == "invalid_grant") {
            throw Exception(['account_invalid']);
          }

          if (['Response was of unexpected', 'Internal Server Error', 'JAXB unmarshalling'].contains(dioException.response?.data["message"])) {
            throw Exception(['SERVER_ERROR']);
          }

          if(dioException.response?.data['message'] != null && dioException.response?.data['message'] != "") {
            return dioException.response?.data;
          }
        }

        if (dioException.response?.data != null && dioException.response?.data is Map<String, dynamic>) {
          return dioException.response?.data;
        } else {

          throw Exception('unidentified_dioError');
        }
      }

      throw Exception('generic_error');

    }finally{

    }

  }

  Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return !(connectivityResult.contains(ConnectivityResult.none));
  }

}