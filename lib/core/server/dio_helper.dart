import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:fils/core/server/result.dart';
import 'package:fils/core/server/servise.dart';
import 'package:fils/utils/storage.dart';
import '../../route/app_routes.dart';
import '../../route/control_route.dart';
import 'header.dart';

class DioClient {
  late final Dio _dio;

  DioClient({bool seller = false}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: seller ? ApiServiceSeller.domain : ApiService.domain,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        headers: ApiHeaders.headers,
        responseType: ResponseType.json,
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    _dio.interceptors.add(
      LogInterceptor(request: true, requestBody: true, responseBody: true),
    );
  }

  /// =======================
  /// Generic Request
  /// =======================
  Future<ApiResult<T>> request<T>({
    required String path,
    required String method,
    T Function(dynamic json)? converter,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    Map<String, dynamic>? headers,
    bool isMultipart = false,
    File? file,
    String fileFieldName = 'file',
    CachePolicy? cachePolicy,
    CancelToken? cancelToken,
  }) async {
    try {
      final body = await _buildBody(
        data: data,
        isMultipart: isMultipart,
        file: file,
        fileFieldName: fileFieldName,
      );

      final response = await _dio.request(
        path,
        data: body,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
        options: Options(method: method, headers: headers),
      );

      if (response.statusCode == 401) {
        removeUser();
        ToRemoveAll(AppRoutes.login);
        return ApiResult.failed(message: response.data['message'], statusCode: 401);
      }

      if (response.statusCode != null && response.statusCode! == 200) {
        final result =
            converter != null ? converter(response.data) : response.data as T;

        return ApiResult.success(
          result,
          statusCode: response.statusCode,
          message: response.statusMessage,
        );
      }

      return ApiResult.failed(
        message: response.data?['message'],
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        return ApiResult.failed(message: 'Request canceled');
      }

      return ApiResult.failed(
        message: e.response?.data?['message'],
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      return ApiResult.failed(message: 'Unexpected error', statusCode: 501);
    }
  }

  /// =======================
  /// Multipart Helper
  /// =======================
  Future<dynamic> _buildBody({
    dynamic data,
    required bool isMultipart,
    File? file,
    required String fileFieldName,
  }) async {
    if (!isMultipart) return data;

    final map = <String, dynamic>{};

    if (data is Map<String, dynamic>) {
      map.addAll(data);
    }

    if (file != null) {
      map[fileFieldName] = await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
      );
    }

    return FormData.fromMap(map);
  }
}
