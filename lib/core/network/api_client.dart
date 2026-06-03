import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiClient {
  const ApiClient(this._dio);

  final Dio _dio;

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.get(path, queryParameters: queryParameters, options: options);

  Future<Response<dynamic>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

  Future<Response<dynamic>> put(String path, {Object? data, Options? options}) =>
      _dio.put(path, data: data, options: options);

  Future<Response<dynamic>> patch(
    String path, {
    Object? data,
    Options? options,
  }) =>
      _dio.patch(path, data: data, options: options);

  Future<Response<dynamic>> delete(
    String path, {
    Object? data,
    Options? options,
  }) =>
      _dio.delete(path, data: data, options: options);

  Future<Response<dynamic>> uploadFile(
    String path, {
    required File file,
    required String fieldName,
    Map<String, dynamic>? data,
  }) async {
    final formData = FormData.fromMap({
      ...?data,
      fieldName: await MultipartFile.fromFile(file.path),
    });
    return _dio.post(path, data: formData);
  }
}
