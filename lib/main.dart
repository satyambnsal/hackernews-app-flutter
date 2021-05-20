import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'models/article.dart';
import 'theme.dart';
import 'models/hn_api.dart';
import 'utils/https-ssl-fix.dart';

class HackerNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hackernews App',
      theme: appTheme,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hackernews App'),
        ),
        body: ArticlesList(),
      ),
    );
  }
}

class ArticlesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
          children: List.generate(
        articles.length,
        (index) => HNArticle(
          title: articles[index].title,
          url: articles[index].url,
        ),
      ).toList()),
    );
  }
}

class HNArticle extends StatefulWidget {
  final String title;
  final String url;
  const HNArticle({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  _HNArticleState createState() => _HNArticleState();
}

class _HNArticleState extends State<HNArticle> {
  Future<void>? _launched;

  Future<void>? _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      launch(
        url,
      );
    } else {
      throw 'Can not launch url $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.black,
      elevation: 3.0,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 16),
              ),
              TextButton(
                onPressed: () => setState(() {
                  _launched = _launchInBrowser(widget.url);
                }),
                child: Icon(Icons.launch),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  runApp(HackerNewsApp());
  HackerNewsAPI().getAllStories();
}
