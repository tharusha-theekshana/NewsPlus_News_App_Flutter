import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../Model/news.dart';

class NewsItemPage extends StatelessWidget {
  late double _deviceWidth, _deviceHeight;

  NewsItemPage({required this.news});

  final box = GetStorage();

  final News news;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.only(
          right: _deviceWidth * 0.05,
          left: _deviceWidth * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            _newsTitle(news.title.toString()),
            _newsImage(news.urlToImage.toString()),
            _newsAuthor(news.author.toString()),
            _newsPublishedAt(news.publishedAt.toString()),
            _newsContent(news.content.toString()),
            SizedBox(
              height: _deviceHeight * 0.03,
            ),
            _newsLink(news.url.toString())
          ],
        ),
      ),
    );
  }

  Widget _newsTitle(String title) {
    return Container(
        padding: EdgeInsets.only(
            bottom: _deviceHeight * 0.05),
        child: Text(
          title.toString(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
        ));
  }

  Widget _newsImage(String url) {
    return Container(
      height: _deviceHeight * 0.27,
      width: _deviceWidth * 0.95,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)),
    );
  }

  Widget _newsContent(String content) {
    if (content != "null") {
      return Container(
          padding: EdgeInsets.only(
              top: _deviceHeight * 0.02, bottom: _deviceHeight * 0.01),
          child:  Text(content , textAlign: TextAlign.center,style:const TextStyle(
            fontSize: 15.0
          ),));
    } else {
      return Container();
    }
  }

  Widget _newsAuthor(String name) {
    if (name != "null") {
      return Container(
          padding: EdgeInsets.only(
              top: _deviceHeight * 0.02, bottom: _deviceHeight * 0.01),
          child: Text("Write By : $name" , textAlign: TextAlign.center,));
    } else {
      return Container();
    }
  }

  Widget _newsPublishedAt(String date) {
    if (date != "null") {
      return Container(
          padding: EdgeInsets.only(
              top: _deviceHeight * 0.02, bottom: _deviceHeight * 0.02),
          child: Text("Published At : $date"));
    } else {
      return Container();
    }
  }

  Widget _newsLink(String url) {
    return InkWell(
      child: Container(
        height: _deviceHeight * 0.07,
        width: _deviceWidth * 0.4,
        decoration: BoxDecoration(
          color: box.read("theme") == null || box.read("theme") != "dark" ? Colors.black: Colors.white,
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Read More ... ',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: box.read("theme") == null || box.read("theme") != "dark" ? Colors.white: Colors.black,
              ),
            ),
          ],
        ),
      ),
      onTap: () => launchUrlString(url),
    );
  }
}


