import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/Controller/news_controller.dart';
import 'package:newsapp/View/widgets/list_items.dart';

class HomeWidget extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      init: NewsController(),
      builder: (controller) {
        return ListItems(list: controller.news);
      },
    );
  }
}
