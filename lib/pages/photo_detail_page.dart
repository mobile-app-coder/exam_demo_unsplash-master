import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam_demo_unsplash/getx/photo_detail_controller.dart';
import 'package:exam_demo_unsplash/models/collection_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoDetailPage extends StatefulWidget {
  final PreviewPhoto? photo;

  const PhotoDetailPage({super.key, this.photo});

  @override
  State<PhotoDetailPage> createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  PhotoDetailController _controller = Get.find<PhotoDetailController>();

  @override
  void initState() {
    super.initState();
    _controller.photo = widget.photo!;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhotoDetailController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 10,
        ),
        backgroundColor: Colors.black54,
        body: GestureDetector(
          onTap: () {
            _controller.showBrush();
          },
          child: Stack(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //alignment: Alignment.center,
              child: CachedNetworkImage(
                fit: BoxFit.fitWidth,
                imageUrl: _controller.photo.urls.regular,
                cacheKey: _controller.photo.id,
              ),
            ),
            _controller.isImage
                ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.3)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios,
                                  color: Colors.white),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            IconButton(
                              icon: const Icon(Icons.ios_share_outlined,
                                  color: Colors.white),
                              onPressed: () {
                                _controller.share();
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.info_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                bottomShit();
                              },
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.arrow_downward_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Container()
          ]),
        ),
      );
    });
  }

  bottomShit() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 600,
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.transparent.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Username: ${_controller.photo.user}",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text("description: ${_controller.photo.descriptions}",
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
                Text(
                  "created at : ${_controller.photo.createdAt}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          );
        });
  }
}
