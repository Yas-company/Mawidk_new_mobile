import 'dart:async';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:mawidak/core/base_network/client/dio_client.dart';
import 'package:mawidak/core/base_network/error/handler/error_model.dart';
import 'package:mawidak/core/component/custom_toast/p_toast.dart';
import 'package:mawidak/core/data/constants/app_router.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/services/log/app_log.dart';

class TokenInterceptor extends Interceptor {
  final Dio dio;
  TokenInterceptor(this.dio);

  // String? _accessToken;
  // final bool _isRefreshing = false;
  // final List<RequestOptions> _failedRequestsQueue = [];

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Load token if not already loaded
    // if (_accessToken == null) {
    //   _accessToken = await SecureStorageService().read(key: SharPrefConstants.userLoginTokenKey);
    // }
    //
    // // Add Authorization header
    // if (_accessToken != null) {
    //   options.headers['Authorization'] = 'Bearer $_accessToken';
    // }

    handler.next(options);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    // hideLoadingDialog();
    AppLog.logValueAndTitle(
        'TokenInterceptor', "Reached ${err.type} ${err.response?.statusCode}");
    if (err.response?.statusCode != 401 && (ErrorExceptionModel.fromJson(err).message ?? '').isNotEmpty) {
      SafeToast.show(
        // context: navigatorKey.currentState!.context,
        message: ErrorExceptionModel.fromJson(err).message ?? '',
        type: MessageType.error,
      );
    }
    if (err.response?.statusCode == 401) {
      SafeToast.show(
        // context: navigatorKey.currentState!.context,
        message: '',
        type: MessageType.error,
      );
      hideLoadingDialog();
      navigateToLogin();
      // if (!_isRefreshing) {
      //   _isRefreshing = true;
      //   try {
      //     // Refresh the token
      //     _accessToken = await _refreshToken();
      //
      //     // Retry all failed requests in the queue
      //     for (var request in _failedRequestsQueue) {
      //       await _retryRequest(request);
      //     }
      //     _failedRequestsQueue.clear();
      //
      //     _isRefreshing = false;
      //
      //     // Retry the current request
      //     final retryResponse = await _retryRequest(err.requestOptions);
      //     handler.resolve(retryResponse);
      //   } catch (e) {
      //     _isRefreshing = false;
      //
      //     // Clear failed requests and navigate to login on token refresh failure
      //     _failedRequestsQueue.clear();
      //     // await navigateToLogin();
      //     handler.reject(err);
      //   }
      // } else {
      //   // Queue the current request for retry after the token refresh
      //   _failedRequestsQueue.add(err.requestOptions);
      // }
    } else {
      // Handle other errors
      // handler.reject(err);
    }
    handler.reject(err);
  }

// Future<Response> _retryRequest(RequestOptions requestOptions) async {
//   final newOptions = Options(
//     method: requestOptions.method,
//     headers: {
//       ...requestOptions.headers,
//       'Authorization': 'Bearer $_accessToken',
//     },
//   );
//
//   return await dio.request(
//     requestOptions.path,
//     data: requestOptions.data,
//     queryParameters: requestOptions.queryParameters,
//     options: newOptions,
//   );
// }
//
// Future<String> _refreshToken() async {
//   final response = await dio.post(
//     '${ApiEndpointsConstants.baseUrl}${ApiEndpointsConstants.login}',
//     data: {
//       'userName': 'omar',
//       'password': '123456',
//     },
//   );
//
//   if (response.statusCode == 200) {
//     final generalResponseModel =
//         GeneralResponseModel().fromMap(response.data);
//
//     // Save the new token
//     final token =
//         (generalResponseModel.model as LoginResponseModel?)?.model?.token ??
//             '';
//     _accessToken = token;
//     await SecureStorageService().write(
//       key: SharPrefConstants.userLoginTokenKey,
//       value: token,
//     );
//
//     // Update Dio client headers
//     DioClient().updateHeader();
//     return token;
//   } else {
//     throw Exception('Failed to refresh token');
//   }
// }
}


Future<void> navigateToLogin() async {
  // Clear token and navigate to login
  await DioClient().deleteToken();
  // if (Navigator.canPop(Get.context!)) {
  //   Navigator.of(Get.context!, rootNavigator: true).pop();
  // }
  navigatorKey.currentState?.context.go(AppRouter.login);
}
