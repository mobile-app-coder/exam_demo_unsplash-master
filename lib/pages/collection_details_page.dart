import 'package:cached_network_image/cached_network_image.dart';
import 'package:exam_demo_unsplash/getx/collection_detail_controller.dart';
import 'package:exam_demo_unsplash/models/collection_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class CollectionDetailsPage extends StatefulWidget {
  final CollectionModel? model;

  const CollectionDetailsPage({super.key, this.model});

  @override
  State<CollectionDetailsPage> createState() => _CollectionDetailsPageState();
}

class _CollectionDetailsPageState extends State<CollectionDetailsPage> {
  CollectionDetailController _controller =
      Get.find<CollectionDetailController>();

  @override
  void initState() {
    super.initState();
    _controller.model = widget.model!;
    _controller.photos = widget.model!.previewPhotos;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CollectionDetailController>(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.black45,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            _controller.model.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: GridView.custom(
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
            childCount: _controller.photos.length,
            (context, index) => Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: index < _controller.photos.length - 1
                    ? _photoItem(_controller.photos[index])
                    : Container()),
          ),
        ),
      );
    });
  }

  Widget _photoItem(PreviewPhoto photo) {
    return GestureDetector(
      onTap: () {
        _controller.openPhotoDetails(photo, context);
      },
      child: Container(
        width: double.infinity,
        child: CachedNetworkImage(
          imageUrl: photo.urls.regular,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
