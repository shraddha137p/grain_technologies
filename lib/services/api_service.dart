import 'package:dio/dio.dart';
import 'package:grain_machine_test/core/widgets/app_logger.dart';

class ApiService {
  late final Dio dio;

  ApiService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://reqres.in',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {'x-api-key': 'reqres_32e47dacd4744f009b24358d68f0272d'},
      ),
    );
  }

  Future<Response<dynamic>> getUsers({
    required int page,
    required int perPage,
  }) async {
    AppLogger.separator();

    AppLogger.info('GET USERS REQUEST');

    AppLogger.debug('Method: GET');

    AppLogger.debug('URL: ${dio.options.baseUrl}/api/users');

    AppLogger.debug('Query Parameters: page=$page, per_page=$perPage');

    try {
      final Response<dynamic> response = await dio.get(
        '/api/users',
        queryParameters: {'page': page, 'per_page': perPage},
      );

      AppLogger.info('GET USERS RESPONSE');

      AppLogger.debug('Status Code: ${response.statusCode}');

      AppLogger.debug('Response Data: ${response.data}');

      AppLogger.separator();

      return response;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('GET USERS FAILED', e, stackTrace);

      AppLogger.debug('Dio Error Type: ${e.type}');

      AppLogger.debug('Status Code: ${e.response?.statusCode}');

      AppLogger.debug('Error Response: ${e.response?.data}');

      AppLogger.separator();

      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('GET USERS ERROR', e, stackTrace);

      AppLogger.separator();

      rethrow;
    }
  }
}
