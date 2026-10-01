import '../models/user_response_model.dart';
import '../services/api_service.dart';

class UserRepository {
  final ApiService apiService;

  UserRepository({
    required this.apiService,
  });

  Future<UserResponseModel> getUsers({
    required int page,
    required int perPage,
  }) async {
    final response = await apiService.getUsers(
      page: page,
      perPage: perPage,
    );

    return UserResponseModel.fromJson(
      response.data as Map<String, dynamic>,
    );
  }
}