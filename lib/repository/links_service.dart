import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:pocket_health/models/links_model.dart';
import 'package:pocket_health/services/api_service.dart';

final linkServiceProvider = Provider<LinksService>((ref) {
  return LinksService();
});

class LinksService {
  Future<List<LinkModel>> getLinks() async {
    try {
      final _token = await getStringValuesSF();

      final response = await http.get(
        "https://ssential.herokuapp.com/api/Links/",
        headers: {
          'Authorization': 'Bearer ' + _token,
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print('--------|json|--------|value -> ${response.body.toString()}');
        return linksFromJson(response.body);
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
