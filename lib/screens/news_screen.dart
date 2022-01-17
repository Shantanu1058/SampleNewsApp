import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samplenewsapp/controller/news_controller.dart';
import 'package:samplenewsapp/screens/favorite_screen.dart';

class NewsScreen extends StatelessWidget {
  NewsScreen({Key? key}) : super(key: key);

  NewsController newsController = Get.put(NewsController());
  bool isLoading = false;
  int index = 0;
  bool isFavorite = false;

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
              onTap: () {},
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                decoration: BoxDecoration(
                    color: index == 0 ? Colors.blue : Colors.white,
                    border: Border.all(color: Colors.black)),
                margin: const EdgeInsets.symmetric(horizontal: 1),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.menu,
                      color: index == 0 ? Colors.white : Colors.black,
                      size: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      "News",
                      style: TextStyle(
                          color: index == 0 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                newsController.increment(true);
                Get.offAll(() => FavoriteScreen());
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                decoration: BoxDecoration(
                    color: index == 0 ? Colors.white : Colors.blue,
                    border: Border.all(color: Colors.black)),
                margin: const EdgeInsets.symmetric(horizontal: 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.favorite,
                      color: index == 0 ? Colors.red : Colors.white,
                      size: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text("Favs",
                        style: TextStyle(
                            color: index == 0 ? Colors.black : Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: newsController.fetchAllNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Container(
                  child: newsController.newsList.isEmpty
                      ? const Center(
                          child: Text("No News Available"),
                        )
                      : ListView.builder(
                          itemCount: newsController.newsList.length,
                          itemBuilder: (context, index) {
                            final news = newsController.newsList[index];
                            return Card(
                                shadowColor: Colors.black,
                                margin: const EdgeInsets.all(10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: IconButton(
                                            onPressed: () {
                                              newsController.toogle(news["id"]);
                                              print(newsController.isFavorite
                                                  .contains(news["id"]));
                                            },
                                            icon: Obx(
                                              () => Icon(
                                                newsController.isFavorite
                                                        .contains(news["id"])
                                                    ? Icons.favorite
                                                    : Icons
                                                        .favorite_border_sharp,
                                                color: newsController.isFavorite
                                                        .contains(news["id"])
                                                    ? Colors.red
                                                    : Colors.black,
                                              ),
                                            )),
                                      ),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              news["title"] ?? "No Title",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              news["summary"] ?? "No Summary",
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              news["published"] ??
                                                  "No Published Date ",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          }));
            }
          },
        ),
      ),
    );
  }
}
