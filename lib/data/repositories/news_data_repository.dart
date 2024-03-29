import 'dart:convert';

import 'package:get/get.dart';
import 'package:news_app/data/models/news_data_model.dart';
import 'package:news_app/data/repositories/news_data_provider.dart';

class NewsDataRepository {
  final NewsDataProvider newsDataProvider;
  NewsDataRepository(this.newsDataProvider);

  Future<List<NewsDataModel>> fetchNews(String country) async {
    // String country = 'in';
      final newsData = await newsDataProvider.fetchNews(country);
      final data = jsonDecode(newsData);

      if (data['status'] != "ok") {
        throw "status not okay error occoured";
      }

      List<NewsDataModel> resultList = [];
      for (var article in data['articles']) {
        resultList.add(NewsDataModel.fromMap(article));
      }
      return resultList;
  }
}
