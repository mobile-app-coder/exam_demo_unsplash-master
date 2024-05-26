import 'package:exam_demo_unsplash/getx/home_controller.dart';
import 'package:exam_demo_unsplash/pages/collections_page.dart';
import 'package:exam_demo_unsplash/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController _homeController = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    _homeController.controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (context) {
      return Scaffold(
        body: PageView(
          controller: _homeController.controller,
          onPageChanged: (int index) {
            _homeController.onPageChange(index);
          },
          children: [SearchPage(), CollectionPage()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          currentIndex: _homeController.selectedIndex,
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(color: Colors.white),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                label: "Search"),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections, color: Colors.white),
              label: "Collection",
            )
          ],
          onTap: (int index) {
            _homeController.onTap(index);
          },
        ),
      );
    });
  }
}
