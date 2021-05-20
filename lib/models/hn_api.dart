import 'dart:convert';

import 'package:http/http.dart' as http;

class HackerNewsAPI {
  static const API_BASE_URL = "www.hacker-news.firebaseio.com";

  fetchTopStoryIds() async {
    // var url = Uri.https(API_BASE_URL, 'v0/topstories.json', {'q': '{http}'});
    // print(url);
    var url =
        Uri.parse("https://hacker-news.firebaseio.com/v0/topstories.json");
    print(url);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;
      var itemCount = jsonResponse.length;
      return jsonResponse;
      print('Total number of top stories: $itemCount');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  fetchStoryById(id) async {
    var url = Uri.parse("https://hacker-news.firebaseio.com/v0/item/$id.json");
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var storyTitle = jsonResponse["title"];
      print('story title: $storyTitle');
      return jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  getAllStories() async {
    var storyIds = await fetchTopStoryIds();
    var allStories = storyIds.map((storyId) => fetchStoryById(storyId));

    print(storyIds);
    print(allStories);
  }
}
