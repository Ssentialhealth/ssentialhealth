import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/models/all_users_model.dart';

final allUsersServiceProvider = Provider<AllUsersService>((ref) {
  return AllUsersService();
});

class AllUsersService {
  Future<List<AllUsersModel>> fetchAllUsers() async {
    try {
      final response = await http.get("https://ssential.herokuapp.com/api/user/profile/");
      if (response.statusCode == 200) {
        print(response.body);
        return allUsersModelFromJson(response.body);
      } else {
        print('--------|failure reason|--------|value -> ${response.reasonPhrase.toString()}');
        return null;
      }
    } catch (e, s) {
      print('--------|failed to fetch|--------|value -> $s');
      return throw Exception(e);
    }
  }
}
