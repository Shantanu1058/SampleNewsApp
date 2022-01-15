import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samplenewsapp/controller/news_controller.dart';

import 'news_screen.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  NewsController newsController = NewsController();
  Widget Builder() {
    return GetBuilder<NewsController>(
        init: NewsController(),
        builder: (controller) {
          print(controller.favoriteNewsList);
          return controller.favoriteNewsList.isEmpty
              ? const Center(
                  child: Text("No Favorite News"),
                )
              : ListView.builder(
                  itemCount: controller.favoriteNewsList.length,
                  itemBuilder: (context, index) {
                    final news = controller.favoriteNewsList[index];
                    return Card(
                        shadowColor: Colors.black,
                        margin: const EdgeInsets.all(10),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )),
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      news["title"],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      news["summary"],
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      news["published"],
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
                  });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          height: MediaQuery.of(context).size.height * 0.08,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  newsController.increment(false);
                  Get.offAll(NewsScreen());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  decoration: BoxDecoration(
                      color: newsController.index.value == 1
                          ? Colors.blue
                          : Colors.white,
                      border: Border.all(color: Colors.black)),
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.menu,
                        color: newsController.index.value == 1
                            ? Colors.white
                            : Colors.black,
                        size: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text(
                        "News",
                        style: TextStyle(
                            color: newsController.index.value == 1
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.offAll(() => FavoriteScreen());
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                  decoration: BoxDecoration(
                      color: newsController.index.value == 1
                          ? Colors.white
                          : Colors.blue,
                      border: Border.all(color: Colors.black)),
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.favorite,
                        color: newsController.index.value == 1
                            ? Colors.red
                            : Colors.white,
                        size: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Text("Favs",
                          style: TextStyle(
                              color: newsController.index.value == 1
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        body: SafeArea(child: Container(child: Builder())));
  }
}
