import 'package:get/get.dart';

import '../Model/news.dart';

class ApiData extends GetConnect implements GetxService{

  Future<List<News>> getHeadLines() async {
    Response response = await get("https://newsapi.org/v2/top-headlines?country=us&apiKey=416c38ccc7444b2d9041778a957e808e");
    List data = response.body['articles'];
    List<News> news = data.map((e) => News.fromJson(e)).toList();
    return news;
  }


  Future<List<News>> getSearchNews({required String searchText}) async {
    Response response = await get("https://newsapi.org/v2/everything?q=$searchText&apiKey=416c38ccc7444b2d9041778a957e808e");
    List data = response.body['articles'];
    List<News> news = data.map((e) => News.fromJson(e)).toList();
    return news;
  }


  Future<List<News>> getCategoryNews({required String category}) async {
    category = category.toLowerCase();
    Response response = await get("https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=416c38ccc7444b2d9041778a957e808e");
    List data = response.body['articles'];
    List<News> news = data.map((e) => News.fromJson(e)).toList();
    return news;
  }
}