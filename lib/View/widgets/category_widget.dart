import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:newsapp/Controller/news_controller.dart';
import 'package:newsapp/View/widgets/list_items.dart';
import 'package:newsapp/shared/category.dart';

import '../../Model/news.dart';

class CategoryWidget extends StatefulWidget {

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget>
    with SingleTickerProviderStateMixin {
  late double _height, _width;
  late TabController tabController;
  final newsController = Get.put(NewsController());

  @override
  void initState() {
    tabController =
        TabController(length: Category.categoryItems.length, vsync: this);
    super.initState();
  }
  
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        TabBar(
          isScrollable: true,
          controller: tabController,
          indicatorColor: box.read("theme") == "dark" ? Colors.white : Colors.black,
          tabs: Category.categoryItems.map((e) {
            return Container(
              child: Text(e , style: TextStyle(
                color: box.read("theme") == "dark" ? Colors.white : Colors.black,
              ),),
            );
          }).toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: Category.categoryItems.map((e) {
              return FutureBuilder(
                future: newsController.getCategoryNews(category: e),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListItems(list: snapshot.data as List<News>);
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    );
                  }
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
