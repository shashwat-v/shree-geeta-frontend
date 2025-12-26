import 'package:shree_geeta/core/network/api_client.dart';

class ChatRepository {
  final ApiClient _apiClient = ApiClient();

  Stream<String> askStream(String query) {
    return _apiClient.askStream(query);
  }
}
