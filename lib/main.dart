import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/Constants/constants.dart';
import 'package:untitled/widgets/news_tile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'NEWS APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;

  List news = [];
  String? pageId;
  @override
  void initState() {
    getNewsData();

    super.initState();
  }

  getNewsData() async {
    isLoading = true;
    List newNews = news;
    try {
      var res = await http.get(Uri.parse(
          "${Constants.newsApiUrl}1${Constants.newsApiendpoint}${pageId != null ? "&page=$pageId" : ""}"));
      var newsData = json.decode(res.body);
      

      newNews += newsData["results"];
      setState(() {
        isLoading = false;
        news = newNews;
        pageId = newsData["nextPage"];
      });
    } catch (e) {
      setState(() {
        isLoading = false;

        pageId = null;
        news = news +
            [
              {
                "title": Constants.errorMessage,
                "image_url": Constants.errorImage,
                "description": Constants.errorDes
              }
            ];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      
      body: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.extentAfter == 0) {
            
            getNewsData();
          }
          return false;
        },
        child: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: news.length + 1, 
          itemBuilder: (context, index) {
            if (index < news.length) {
              return NewsTile(
                size: size,
                title: news[index]["title"] ?? "No News",
                imgUrl: news[index]["image_url"] ?? Constants.errorImage,
                description: news[index]["description"] ?? "No News Available",
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
