import 'package:image_picker/image_picker.dart';

class MediaPicker {
  ImagePicker picker = ImagePicker();
  Future<List<XFile>> selectImages({bool isSingle = false}) async {
    List<XFile> files = [];
    try {
      if (isSingle){
        XFile? file = await picker.pickImage(imageQuality: 60, requestFullMetadata: false, source: ImageSource.gallery);
        if (file != null){
          files.add(file);
        }
      }
      else {
        files = await picker.pickMultiImage(imageQuality: 60, requestFullMetadata: false);
      }
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
