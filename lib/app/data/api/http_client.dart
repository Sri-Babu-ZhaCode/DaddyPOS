// ignore_for_file: unused_element

import 'package:dio/dio.dart';
import 'package:dio/native_imp.dart';
import 'package:flutter/foundation.dart';
import '../../../secrets.dart';
import '../../core/exceptions.dart';
import 'local_storage.dart';

class DioClient extends DioForNative {
  DioClient._privateConstructor([super.baseOptions]) {
    options.baseUrl = _baseUrl;
    //  options.contentType = ContentType.json.toString();
    interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['Authorization'] = 'Token ${LocalStorage.authToken}';
      options.data ??= {};
      //  if (options.data is Map) options.data["UserRegistrationId"] = "13";
      // print(">>>${options.data}");
      if (options.data is Map) {
        // print(LocalStorage.registeredUserId);
        options.data["userregistrationid"] = getUserRegisterId();
        // '13';'127';

        //getUserRegisterId();

        //'5';

        //getUserRegisterId();
        //'179';

        //  print('current-user ${LocalStorage.readString('create-user')}');
      }
      debugPrint(">>>${options.data}");
      return handler.next(options);
    }, onError: (error, handler) {
      throw (EbException(error));
    }));
  }
  static final DioClient _instance = DioClient._privateConstructor();
  factory DioClient() {
    return _instance;
  }
  String? appVersion;
  String get _baseUrl {
    String iP = kReleaseMode ? PRODUCTION_IP : DEBUG_IP;
    return iP;
  }

  Response _handleResponse(Response response) {
    if (response.statusCode! >= 200 && response.statusCode! <= 299) {
      return response;
    } else {
      throw (EbException(response));
    }
  }

  @override
  Future<Response<T>> post<T>(String path,
      {dynamic data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      return await super.post<T>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
    } catch (e) {
      throw (EbException(e));
    }
  }

  @override
  Future<Response<T>> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      return await super.get<T>(path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress);
    } catch (e) {
      throw (EbException(e));
    }
  }

  @override
  Future<Response<T>> patch<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      return await super.patch<T>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
    } catch (e) {
      throw (EbException(e));
    }
  }

  @override
  Future<Response<T>> put<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      return await super.put<T>(path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
    } catch (e) {
      throw (EbException(e));
    }
  }

  @override
  Future<Response<T>> delete<T>(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken}) async {
    try {
      return await super.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } catch (e) {
      throw (EbException(e));
    }
  }

  String? getUserRegisterId() {
    if (LocalStorage.registeredUserId == null) {
      LocalStorage.init();
    }
    return LocalStorage.registeredUserId;
  }
}
