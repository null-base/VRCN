import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const engageCardBackgroundImageKey = 'business_card_background_image';

class EngageCardService {
  EngageCardService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();
  final ImagePicker _picker;

  Future<File?> loadBackgroundImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString(engageCardBackgroundImageKey);
    if (path == null || path.isEmpty) return null;

    final file = File(path);
    return await file.exists() ? file : null;
  }

  Future<File?> pickAndPersistBackgroundImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return null;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = p.basename(pickedFile.path);
    final savedImage = await File(
      pickedFile.path,
    ).copy('${appDir.path}/$fileName');

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(engageCardBackgroundImageKey, savedImage.path);
    return savedImage;
  }

  Future<void> removeBackgroundImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(engageCardBackgroundImageKey);
  }
}
