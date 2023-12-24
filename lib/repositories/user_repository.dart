import 'dart:io';

import 'package:app_sv/model/user.dart';
import 'package:app_sv/services/api_services.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';

class UserRepository {
  Future<User> getUserInfo() async {
    User user = User();
    final response = await ApiServices().getUserInfo();
    if (response != null) {
      var data = response.data['data'];
      user = User.fromJson(data);
    }
    return user;
  }

  Future<bool> updateProfile() async {
    bool result = false;
    final response = await ApiServices().updateProfile();
    if (response != null) {
      result = true;
    }
    return result;
  }

  Future<void> updateNewAvatar(XFile image) async {
    ApiServices api = ApiServices();
    final img.Image originalImage =
        img.decodeImage(File(image.path).readAsBytesSync())!;
    final img.Image resizedImage = img.copyResize(originalImage, width: 200);

    final File resizedFile = File(image.path.replaceAll('.jpg', 'resized.jpg'))
      ..writeAsBytesSync(img.encodeJpg(resizedImage));
    await api.updateNewAvatar(File(resizedFile.path));
  }
}
