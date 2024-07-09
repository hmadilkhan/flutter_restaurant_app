import 'dart:convert';

import 'package:get/get.dart';
import 'package:grocery_app/utils/api_list.dart';
import 'package:http/http.dart' as http;
import '../../../../config/theme/my_theme.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/dummy_helper.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../data/models/category_model.dart';
import '../../../data/models/product_model.dart';

class HomeController extends GetxController {
  // to hold categories & products
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];

  // for app theme
  var isLightTheme = MySharedPref.getThemeIsLight();

  // for home screen cards
  var cards = [
    Constants.card1,
    Constants.card2,
    Constants.card3,
    Constants.card4
  ];

  @override
  void onInit() {
    downloadAllData();
    super.onInit();
  }

  String getGreeting() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else if (hour < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  /// get categories from dummy helper
  getCategories() {
    categories = DummyHelper.categories;
  }

  /// get products from dummy helper
  getProducts() {
    products = DummyHelper.products;
  }

  /// when the user press on change theme icon
  onChangeThemePressed() {
    MyTheme.changeTheme();
    isLightTheme = MySharedPref.getThemeIsLight();
    update(['Theme']);
  }

  Future<Object?>? downloadAllData() async {
    try {
      final uri = Uri.parse(ApiList.getAllData);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        categories = [];
        cards = [];
        products = [];
        var result = jsonDecode(response.body);
        var departments = result['website']['getDeparts'];
        var sliders = result['website']['sliders'];

        for (var depart in departments) {
          categories.add(CategoryModel.fromJson(depart));
        }
        for (var slide in sliders) {
          cards.add(slide['slide']);
        }

        return categories;
      } else {
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      return e;
    }
  }
}
