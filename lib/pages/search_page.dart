import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam_demo_unsplash/getx/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../models/search_response_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchPController _controller = Get.find<SearchPController>();
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.loadPhotos();
    controller.addListener(() {
      if (controller.position.maxScrollExtent <= controller.offset) {
        if (_controller.query.isEmpty) {
          _controller.currentPage++;
          _controller.loadPhotos();
        } else {
          _controller.searchPhotos(_controller.query);
          _controller.currentSPage++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchPController>(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Colors.black,
          title: Container(
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(),
            ),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white),
                  hintText: "Search photos, collections, users",
                  labelStyle: TextStyle(color: Colors.white),
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  )),
              onSubmitted: (text) {
                _controller.query = text;
                _controller.searchPhotos(text);
              },
            ),
          ),
        ),
        body: _controller.isLoading
            ? Center(child: Lottie.asset("assets/animations/loading.json"))
            : GridView.custom(
                controller: controller,
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 4,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: [
                    QuiltedGridTile(2, 2),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 1),
                    QuiltedGridTile(1, 2),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  childCount: _controller.results.length,
                  (context, index) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: index < _controller.results.length - 1
                          ? _resultItem(_controller.results[index])
                          : Container()),
                ),
              ),
      );
    });
  }

  Widget _resultItem(Result result) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: GestureDetector(
        onTap: () {
          _controller.openPhotoDetails((getPreviewPhoto(result)), context);
        },
        child: Stack(fit: StackFit.expand, children: [
          CachedNetworkImage(
            memCacheHeight: result.height ~/ 10,
            memCacheWidth: result.width ~/ 10,
            imageUrl: result.urls.regular,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.all(5),
            alignment: Alignment.bottomLeft,
            child: Text(
              result.user.name,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
