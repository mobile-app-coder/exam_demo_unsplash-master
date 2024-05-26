import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/collection_model.dart';
import '../pages/collection_details_page.dart';
import '../services/http_service.dart';

class CollectionController extends GetxController {
  List<CollectionModel> collections = [];

  loadCollection() async {
    var response = await Network.GET(
        Network.COLLECTIONS_API, Network.paramsGetCollection());
    if (response != null) {
      collections = collectionModelFromMap(response);
      update();
    }
  }

  openCollectionDetails(CollectionModel collectionModel, BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return CollectionDetailsPage(model: collectionModel);
    }));
  }
}
