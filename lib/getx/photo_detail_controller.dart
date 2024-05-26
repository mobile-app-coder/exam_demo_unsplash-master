import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../models/collection_model.dart';

class PhotoDetailController extends GetxController {
  late PreviewPhoto photo;

  bool isImage = true;

  share() async {
    await Share.share(photo.links!.download);
  }

  showBrush() {
    isImage = !isImage;

    update();
  }
}
