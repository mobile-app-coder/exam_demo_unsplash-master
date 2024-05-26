import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/collection_model.dart';
import '../pages/photo_detail_page.dart';

class CollectionDetailController extends GetxController {
  late CollectionModel model;
  List<PreviewPhoto> photos = [];

  openPhotoDetails(PreviewPhoto photo, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PhotoDetailPage(
        photo: photo,
      );
    }));
  }
}
