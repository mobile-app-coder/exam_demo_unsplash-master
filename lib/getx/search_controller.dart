import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../models/collection_model.dart';
import '../models/search_response_model.dart';
import '../pages/photo_detail_page.dart';
import '../services/http_service.dart';

class SearchPController extends GetxController {
  int currentPage = 1;
  int currentSPage = 1;
  bool isLoading = true;
  String query = "";
  List<Result> results = [];

  searchPhotos(String text) async {

    var response = await Network.GET(
        Network.SEARCH_API, Network.paramsSearch(text, currentSPage));
    if (response != null) {
      if (currentSPage == 1) {
        results = searchPhotosModelFromJson(response).results;
      } else {
        results.addAll(searchPhotosModelFromJson(response).results);
      }
      update();
    }
    isLoading = false;
  }

  loadPhotos() async {

    var response =
        await Network.GET(Network.PHOTOS_API, Network.paramsEmpty(currentPage));
    if (response != null) {
      var list = List<Result>.from(
          jsonDecode(response).map((x) => Result.fromJson(x)));

      results.addAll(list);
      update();
    }
    isLoading = false;
  }

  openPhotoDetails(PreviewPhoto photo, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return PhotoDetailPage(
        photo: photo,
      );
    }));
  }


}
