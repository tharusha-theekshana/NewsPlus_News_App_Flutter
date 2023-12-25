import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/Controller/news_controller.dart';
import 'package:newsapp/View/widgets/home_widget.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/category_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _deviceWidth, _deviceHeight;

  late TextEditingController controller;
  String searchText = '';

  final box = GetStorage();

  final newsController = Get.put(NewsController());

  final pageController = PageController();
  int indexPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        return await Get.dialog(AlertDialog(
          title: const Text("Exit"),
          content: const Text("Are you sure to close the app ?"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  exit(0);
                },
                child: const Text("Ok")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
          ],
        ));
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "NewsPlus",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: indexPage == 0
              ? IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                              icon: Icon(Icons.search),
                            ),
                            onSubmitted: (value) {
                              newsController.getSearchNews(searchText: value);
                              Navigator.pop(context);
                              controller.clear();
                            },
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.search))
              : Container(),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    newsController.changeThemeMode();
                  });
                },
                icon: Icon(newsController.iconTheme())),
          ],
        ),
        bottomNavigationBar: GetBuilder<NewsController>(builder: (controller) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: controller.index,
            onTap: (index) {
              controller.changeBottomNavigation(currentIndex: index);
              pageController.jumpToPage(index);
            },
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home , color: box.read("theme") == "null" || box.read("theme") == "dark" ? Colors.white : Colors.black),
                  label: 'Home',
                  tooltip: 'Home',
              ),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.category_outlined),
                  activeIcon: Icon(Icons.category,color: box.read("theme") == "null" || box.read("theme") == "dark" ? Colors.white : Colors.black),
                  label: 'Category',
                  tooltip: 'Category')
            ],
          );
        }),
        body: PageView(
          controller: pageController,
          onPageChanged: (index) {
            newsController.changeBottomNavigation(currentIndex: index);
            setState(() {
              indexPage = index;
            });
          },
          children: [HomeWidget(), CategoryWidget()],
        ),
      ),
    );
  }
}
