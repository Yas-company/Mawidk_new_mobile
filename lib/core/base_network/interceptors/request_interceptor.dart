import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mawidak/core/base_network/client/dio_client.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import '../../services/local_storage/secure_storage/secure_storage_service.dart';


class RequestInterceptor extends Interceptor {
  RequestInterceptor();
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    await DioClient().updateHeader();
    // options.extra['startTime'] = DateTime.now();
    String token = await SecureStorageService().read(key: SharPrefConstants.accessToken,) ?? '';
    if(token.isNotEmpty && !options.uri.toString().contains('verify-otp')){
      options.headers['Authorization'] = 'Bearer $token';
      options.headers['Accept-Language'] = 'ar';
    }
    options.headers['API-REQUEST-FROM'] = Platform.isIOS ? "IOS" : "Android";
    super.onRequest(options, handler);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  //   super.onResponse(response, handler);
  // }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if ((err.response?.statusCode ?? 0) != 200 ||
        (err.response?.statusCode ?? 0) != 201) {
    }
    super.onError(err, handler);
  }
}
