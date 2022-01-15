import 'package:get/get.dart';

class News {
  int id;
  String title;
  String summary;
  String url;
  String published;
  RxBool isFavorite;
  News(
      {this.id = 1,
      this.published = "Not available",
      this.summary = "No Summary Available",
      this.title = "No Title Available",
      this.url = "No Url Available",
      required this.isFavorite});
}
