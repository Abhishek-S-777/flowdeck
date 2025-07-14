import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flowdeck/core/config/app_config.dart';

class ApiClient {

  ApiClient(Dio dio) {
    _dio = dio;
    _setupInterceptors();
  }
  late final Dio _dio;

  void _setupInterceptors() {
    _dio.options.baseUrl =
        dotenv.env['API_BASE_URL'] ?? 'https://api.example.com';
    _dio.options.connectTimeout =
        const Duration(milliseconds: AppConfig.connectionTimeout);
    _dio.options.receiveTimeout =
        const Duration(milliseconds: AppConfig.receiveTimeout);
    _dio.options.sendTimeout = const Duration(milliseconds: AppConfig.sendTimeout);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Add authentication token if available
          // final token = getAuthToken();
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          options.headers['Content-Type'] = 'application/json';
          handler.next(options);
        },
        onResponse: (response, handler) {
          handler.next(response);
        },
        onError: (error, handler) {
          // Handle global errors
          if (error.response?.statusCode == 401) {
            // Handle unauthorized error
            // Maybe trigger logout
          }
          handler.next(error);
        },
      ),
    );
  }

  // Generic GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) => _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

  // Generic POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) => _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

  // Generic PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) => _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

  // Generic PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) => _dio.patch<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

  // Generic DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) => _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );

  // Board API endpoints
  Future<Response> getBoards({
    int page = 1,
    int limit = AppConfig.defaultPageSize,
    String? search,
  }) => get('/boards', queryParameters: {
      'page': page,
      'limit': limit,
      if (search != null) 'search': search,
    },);

  Future<Response> getBoardById(String id) => get('/boards/$id');

  Future<Response> createBoard(Map<String, dynamic> data) => post('/boards', data: data);

  Future<Response> updateBoard(String id, Map<String, dynamic> data) => put('/boards/$id', data: data);

  Future<Response> deleteBoard(String id) => delete('/boards/$id');

  // Task API endpoints
  Future<Response> getTasks({
    String? boardId,
    int page = 1,
    int limit = AppConfig.defaultPageSize,
    String? search,
    String? status,
    String? priority,
    String? assignedTo,
  }) => get('/tasks', queryParameters: {
      if (boardId != null) 'board_id': boardId,
      'page': page,
      'limit': limit,
      if (search != null) 'search': search,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (assignedTo != null) 'assigned_to': assignedTo,
    },);

  Future<Response> getTaskById(String id) => get('/tasks/$id');

  Future<Response> createTask(Map<String, dynamic> data) => post('/tasks', data: data);

  Future<Response> updateTask(String id, Map<String, dynamic> data) => put('/tasks/$id', data: data);

  Future<Response> deleteTask(String id) => delete('/tasks/$id');

  // User API endpoints
  Future<Response> getUsers({
    int page = 1,
    int limit = AppConfig.defaultPageSize,
    String? search,
  }) => get('/users', queryParameters: {
      'page': page,
      'limit': limit,
      if (search != null) 'search': search,
    },);

  Future<Response> getUserById(String id) => get('/users/$id');

  Future<Response> updateUser(String id, Map<String, dynamic> data) => put('/users/$id', data: data);

  // Search endpoints
  Future<Response> searchAll({
    required String query,
    int page = 1,
    int limit = AppConfig.defaultPageSize,
    List<String>? types, // ['boards', 'tasks', 'users']
  }) => get('/search', queryParameters: {
      'q': query,
      'page': page,
      'limit': limit,
      if (types != null) 'types': types.join(','),
    },);
}
