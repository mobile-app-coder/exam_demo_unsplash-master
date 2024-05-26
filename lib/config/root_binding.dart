import 'package:exam_demo_unsplash/getx/collection_controller.dart';
import 'package:exam_demo_unsplash/getx/collection_detail_controller.dart';
import 'package:exam_demo_unsplash/getx/home_controller.dart';
import 'package:exam_demo_unsplash/getx/photo_detail_controller.dart';
import 'package:get/get.dart';

import '../getx/search_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => SearchPController());
    Get.lazyPut(() => CollectionController());
    Get.lazyPut(() => CollectionDetailController());
    Get.lazyPut(() => PhotoDetailController());
  }
}
