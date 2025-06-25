import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/base_network/api_endpoints_constants.dart';
import 'package:mawidak/core/base_network/error/handler/error_model.dart';
import 'package:mawidak/core/base_network/error/handler/exception_enum.dart';
import 'package:mawidak/core/base_network/interceptors/request_interceptor.dart';
import 'package:mawidak/core/base_network/interceptors/token_interceptor.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/services/local_storage/secure_storage/secure_storage_service.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/core/services/log/app_log.dart';
import 'package:mawidak/features/survey/data/model/survey_doctor_request_model.dart';
import 'package:path/path.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const _defaultConnectTimeout = Duration(seconds: 15);
const _defaultReceiveTimeout = Duration(seconds: 60);
const _defaultSendTimeout = Duration(seconds: 60);

class DioClient {
  String baseUrl() => ApiEndpointsConstants.baseUrl;

  // late final dio = Dio();
  late Dio dio;

  final List<Interceptor> interceptors = [];
  String? accessToken;
  dynamic headers;

  DioClient() {
    dio = Dio();
    dio
      ..options.baseUrl = baseUrl()
      ..options.connectTimeout = _defaultConnectTimeout
      ..options.sendTimeout = _defaultSendTimeout
      ..options.receiveTimeout = _defaultReceiveTimeout
      ..httpClientAdapter
      ..options.headers = headers;
    dio.interceptors.add(PrettyDioLogger(
      compact: false,
      logPrint: (object) => log(object.toString(), name: 'Test'),
    ));
    dio.interceptors.add(RequestInterceptor());
    dio.interceptors.add(TokenInterceptor(dio));
    // dio.interceptors.add(RetryInterceptor(dio: dio, retries: 40, retryDelay: 0));

    dio.interceptors.addAll(interceptors);
  }


  Future<dynamic> fetch({
    required String path,
    Map<String, String>? headers,
    Object? body = const {},
    Map<String, dynamic>? queryParameters = const {},
    required dynamic model,
  }) async {
    final dio = Dio();
    headers ??= await addHeader();

    try {
      final response = await dio.get(
        '${baseUrl()}$path',
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          return Right(_jsonBodyParser(requestModel: model, responseBody: response.data));
        case HttpStatus.unauthorized:
          return Left(ErrorExceptionModel(
            exceptionEnum: ExceptionEnum.unAuthorized,
            message: 'Unauthorized',
          ));
        default:
          throw response.data;
      }
    } catch (e) {
      print('❌ Error: $e');
      return Left(ErrorExceptionModel.fromJson(e));
    }
  }



  Future<dynamic> get({
    String? path,
    Map<String, String>? headers,
    Object? body = const {},
    Map<String, String>? queryParameters = const {},
    required dynamic model,
  }) async {
    if (headers != null && headers.isNotEmpty) {
    } else {
      headers = await addHeader();
    }
    try {
      final response = await dio.get(
        "${baseUrl()}$path",data: body,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            return Right(
              _jsonBodyParser(requestModel: model, responseBody: response.data),
            );
          }
        case HttpStatus.unauthorized:
          return Left(ErrorExceptionModel(
              exceptionEnum: ExceptionEnum.unAuthorized,
              message: 'un authorized'));
        default:
          throw response.data;
      }
    } catch (e) {
      print('eeeeee>'+e.toString());
      // AppLog.printValue('errrrr>>$e');
      return Left(ErrorExceptionModel.fromJson(e));
    }
  }

  Future<dynamic> post({
    String? path,
    Map<String, String>? headers,
    Object? body = const {},
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      final response = await dio.post(
        "${baseUrl()}$path",
        queryParameters: queryParameters,
        options: Options(headers: headers),
        data: body,
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            return Right(
              _jsonBodyParser(requestModel: model, responseBody: response.data),
            );
          }
        default:
          throw response.data;
      }
    } catch (e) {
      print("eeeee>>"+e.toString());
      // showErrorToast(ErrorModel.fromJson(e).message ?? '');
      return Left(ErrorExceptionModel.fromJson(e));
    }
  }

  Future<dynamic> postPhoto({
    required File file,
    String? path,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      Map<String, String>? modfiedHeader = headers;
      modfiedHeader!['Content-type'] = 'multipart/form-data';
      // Prepare the form data
      FormData formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(file.path)
      });
      final response = await dio.post(
        "${baseUrl()}$path",
        queryParameters: queryParameters,
        options: Options(
          contentType: "multipart/form-data",
          headers: modfiedHeader,
        ),
        data: formData,
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            return Right(
              _jsonBodyParser(requestModel: model, responseBody: response.data),
            );
          }
        default:
          throw response.data;
      }
    } catch (e) {
      print("eeeee>> ${e}");
      return Left(ErrorExceptionModel.fromJson(e));
    }
  }
  
  Future<dynamic> postMultiPartDataNew({
    required dynamic body,
    String? path,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      Map<String, String>? modfiedHeader = headers;
      modfiedHeader!['Content-type'] = 'multipart/form-data';
      // Prepare the form data
      print('body.certificateNames>>'+body.certificateNames.toString());
      FormData formData = FormData.fromMap({
        'specialization_id': (body as SurveyDoctorRequestModel).specializationId.toString(),
        'gender': body.gender.toString(),
        // 'experience': body.experience.toString(),
        'license_number': body.licenseNumber.toString(),
        'type_of_doctor': body.type_of_doctor.toString(),
        'about_doctor': body.about_doctor.toString(),
        // Add certificate names as text
        'subspecialties[]':body.subspecialties,
        'certificate_names[]': body.certificateNames,
        // Add certificates as File objects
        'certificates[]': await Future.wait(body.certificates!.map((file) async {
          return await MultipartFile.fromFile(file.path);
        }))
      });
      final response = await dio.post(
        "${baseUrl()}$path",
        queryParameters: queryParameters,
        options: Options(
          contentType: "multipart/form-data",
          headers: modfiedHeader,
        ),
        data: formData,
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            return Right(
              _jsonBodyParser(requestModel: model, responseBody: response.data),
            );
          }
        default:
          throw response.data;
      }

      // Handle response
      // if (response.statusCode == 200) {
      //   print("Upload successful: ${response.data}");
      // } else {
      //   print("Upload failed: ${response.statusMessage}");
      // }
    } catch (e) {
      print("eeeee>> ${e}");
      return Left(ErrorExceptionModel.fromJson(e));
    }
  }

  Future<dynamic> put({
    String? path,
    Map<String, String>? headers,
    Object? body = const {},
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      final response = await dio.put(
        "${baseUrl()}$path",
        queryParameters: queryParameters,
        options: Options(headers: headers),
        data: body,
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            return Right(
              _jsonBodyParser(requestModel: model, responseBody: response.data),
            );
          }
        default:
          throw response.data;
      }
    } catch (e) {
      print("eeeee>>"+e.toString());
      // showErrorToast(ErrorModel.fromJson(e).message ?? '');
      return Left(ErrorExceptionModel.fromJson(e));
    }
  }

  Future<dynamic> delete({
    String? path,
    Map<String, String>? headers,
    Object? body = const {},
    Map<String, dynamic>? queryParameters = const {},
    required model,
  }) async {
    try {
      final response = await dio.delete(
        "${baseUrl()}$path",
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      switch (response.statusCode) {
        case HttpStatus.ok:
        case HttpStatus.created:
          {
            return Right(_jsonBodyParser(
                requestModel: model, responseBody: response.data));
          }
        case HttpStatus.forbidden:
          return response.data;
        case HttpStatus.unprocessableEntity:
          return 'Check request key';
        case HttpStatus.unauthorized:
          return "401";
        case HttpStatus.notFound:
          return "404";
        default:
          throw response.data;
      }
    } catch (e) {
      // showErrorToast(ErrorModel.fromJson(e).message ?? '');
      return Left(ErrorExceptionModel.fromJson(e));
    }
  }


  dynamic _jsonBodyParser(
      {required dynamic requestModel, required dynamic responseBody}) {
    return requestModel.fromMap(responseBody);
  }

  // void showErrorToast(String msg){
  //   // PToast.showToast(
  //   //     context: navigatorKey.currentState!.context,
  //   //     message: msg,type: MessageType.error);
  // }

  Future<Map<String, String>> addHeader() async {
    String accessToken = await SecureStorageService()
            .read(key: SharPrefConstants.accessToken) ?? '';
    AppLog.logValue('accessToken>>$accessToken');
    headers = dio
      ..options.headers = {
        'Accept': 'text/plain',
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        HttpHeaders.acceptLanguageHeader: 'ar',
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      };
    return {
      'Accept': 'text/plain',
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
      HttpHeaders.acceptLanguageHeader: 'ar',
      HttpHeaders.authorizationHeader: 'Bearer $accessToken',
    };
  }

  Future<void> updateHeader() async {
    accessToken = await SecureStorageService()
        .read(key: SharPrefConstants.accessToken);
    AppLog.logValue('accessToken>>$accessToken');
    headers = dio
      ..options.headers = {
        'Accept': 'text/plain',
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        HttpHeaders.acceptLanguageHeader: 'ar',
        HttpHeaders.authorizationHeader: 'Bearer ${accessToken ?? ''}',
      };
  }

  Future<void> removeHeader() async {
    AppLog.logValue('accessToken>>$accessToken');
    headers = dio
      ..options.headers = {
        'Accept': 'text/plain',
        'Content-Type': 'application/json; charset=UTF-8',
        HttpHeaders.contentTypeHeader: ContentType.json.mimeType,
        HttpHeaders.acceptLanguageHeader: 'ar',
      };
  }

  Future<void> deleteToken() async {
    // await FirebaseMessaging.instance.deleteToken();
    // globalFcmToken = null;
    await SecureStorageService().write(key: SharPrefConstants.accessToken, value: '');
    await SharedPreferenceService().setBool(SharPrefConstants.isLoginKey, false);
    Get.context!.go(AppRouter.login);
  }
}
