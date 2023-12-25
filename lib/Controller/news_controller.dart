import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../Model/news.dart';
import 'api_data.dart';

class NewsController extends GetxController{

  final box = GetStorage();
  int index = 0;
  ApiData apiData = ApiData();
  List<News> news = [];


  void changeThemeMode(){
    String? theme = box.read("theme");
    if(theme == null || theme == "dark"){
      box.write("theme", "light");
      Get.changeThemeMode(ThemeMode.light);
    }else{
      box.write("theme", "dark");
      Get.changeThemeMode(ThemeMode.dark);
    }
    update();
  }

  IconData iconTheme(){
    String? theme = box.read("theme");
    if(theme == "light"){
      return Icons.light_mode;
    }else{
      return Icons.dark_mode;
    }
  }

  void changeBottomNavigation({required int currentIndex}){
    index = currentIndex;
    update();
  }


  void getHeadlines() async {
    news = await apiData.getHeadLines();
    update();

  }

  Future<List<News>> getCategoryNews({required String category}) async {
    news = await apiData.getCategoryNews(category: category);
    update();
    return news;
  }

  Future<List<News>> getSearchNews({required String searchText}) async {
    news = await apiData.getSearchNews(searchText: searchText);
    update();
    return news;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getHeadlines();
    super.onInit();
  }


}