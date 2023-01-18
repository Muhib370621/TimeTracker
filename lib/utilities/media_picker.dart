import 'package:image_picker/image_picker.dart';

class MediaPicker {
  ImagePicker picker = ImagePicker();
  Future<List<XFile>> selectImages() async {
    List<XFile> files = [];
    try {
      files = await picker.pickMultiImage(
          imageQuality: 60, requestFullMetadata: false);
      return files;
    } catch (e) {
      return [];
    }
  }

  Future<List<XFile>> openCamera() async {
    List<XFile> files = [];
    var camera = await picker.pickImage(
        source: ImageSource.camera, requestFullMetadata: false);
    if (camera != null) {
      files.add(camera);
    }
    return files;
  }
}
