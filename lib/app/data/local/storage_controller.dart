import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageController extends GetxController {
  final box = GetStorage();

  void saveData(String key, String value) {
    box.write(key, value);
  }

  String? readData(String key) {
    return box.read(key);
  }

  void removeData(String key) {
    box.remove(key);
  }
}
