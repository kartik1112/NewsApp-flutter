import 'package:news_app/secrets.dart';
import 'package:http/http.dart' as http;

class NewsDataProvider {
  Future<String> fetchNews(String country) async {
    try {
      final res = await http.get(Uri.parse(
          'https://newsapi.org/v2/top-headlines?country=$country&apiKey=$newsAPIKey'));
      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
