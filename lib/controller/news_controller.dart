import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsController extends GetxController {
  List newsList = [].obs;
  List favoriteNewsList = [].obs;
  RxInt index = RxInt(0);

  void increment(bool isMoved) {
    if (isMoved) {
      index.value = 1;
    } else {
      index.value = 0;
    }
    update();
  }

  Future register(
      {String? userName,
      String? email,
      String? password,
      String? passwordConf}) async {
    final url = Uri.parse('https://chatty-api123.herokuapp.com/register');
    final response = await http.post(url,
        body: json.encode({
          "userName": userName,
          "email": email,
          "password": password,
          "passwordConf": passwordConf
        }),
        headers: {'Content-Type': 'application/json'});
    return json.decode(response.body) as Map;
  }

  Future login({String? userName, String? email, String? password}) async {
    final url = Uri.parse('https://chatty-api123.herokuapp.com/login');
    final response = await http.post(url,
        body: json.encode(
            {"userName": userName, "email": email, "password": password}),
        headers: {'Content-Type': 'application/json'});
    return json.decode(response.body) as Map;
  }

  Future fetchAllNews() async {
    final url = Uri.parse("https://api.first.org/data/v1/news");
    final resposne =
        await http.get(url, headers: {'Content-Type': 'application/json'});
    newsList = json.decode(resposne.body)["data"] as List;
    update();
  }

  Future favoriteNews(int id, bool isFavorite) async {
    final selectedNews = newsList.firstWhere((news) {
      return news["id"] == id;
    });
    print(selectedNews);
    if (isFavorite) {
      favoriteNewsList.add(selectedNews);
    } else {
      favoriteNewsList.remove(selectedNews);
    }
    update();
  }

  bool isFavorite(int id) {
    bool isPresent = false;
    try {
      dynamic item = favoriteNewsList.firstWhere(((news) => news["id"] == id));
      isPresent = item.isNotEmpty;
    } catch (e) {
      print(e);
    }
    return isPresent;
  }
}
