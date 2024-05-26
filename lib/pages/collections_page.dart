import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam_demo_unsplash/getx/collection_controller.dart';
import 'package:exam_demo_unsplash/models/collection_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({super.key});

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  CollectionController _collectionController = Get.find<CollectionController>();

  @override
  void initState() {
    super.initState();
    _collectionController.loadCollection();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CollectionController>(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text(
            "Collections",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: ListView.builder(
            itemCount: _collectionController.collections.length,
            itemBuilder: (context, index) {
              return _collectionItem(_collectionController.collections[index]);
            }),
      );
    });
  }

  Widget _collectionItem(CollectionModel collectionModel) {
    return GestureDetector(
      onTap: () {
        _collectionController.openCollectionDetails(collectionModel, context);
      },
      child: Container(
        child: Stack(
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: CachedNetworkImage(
                memCacheWidth: collectionModel.coverPhoto.width ~/ 10,
                memCacheHeight: collectionModel.coverPhoto.height ~/ 10,
                placeholder: (context, url) {
                  return Container(
                    height: 250,
                    color: Colors.black12,
                  );
                },
                imageUrl: collectionModel.coverPhoto.urls.regular,
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              height: 250,
              padding: EdgeInsets.all(10),
              alignment: Alignment.bottomLeft,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment(-0.5, -0.5),
                    colors: <Color>[
                      Colors.black,
                      Colors.transparent,
                    ]),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collectionModel.title,
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                  Text(
                    "${collectionModel.totalPhotos} photos",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
