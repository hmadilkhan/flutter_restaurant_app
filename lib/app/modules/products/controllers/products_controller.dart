import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';
import 'package:grocery_app/app/routes/app_pages.dart';
import 'package:grocery_app/utils/api_list.dart';

import '../../../../utils/dummy_helper.dart';
import '../../../data/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsController extends GetxController {
  // to hold the products
  List<ProductModel> products = [];
  List<ProductModel> filterProducts = [];
  int categoryId = 0;
  String categoryName = "";

  @override
  void onInit() {
    // getProducts();
    super.onInit();
  }

  /// get products from dummy helper
  getProducts() {
    // downloadAllData();
    // products.addAll(DummyHelper.products);
    // products.removeWhere((p) => p.id == 2);
  }

  showCategoryWiseProduct(id, name) {
    categoryId = id;
    categoryName = name;
    filterProducts = [];
    filterProducts = products.where((p) => p.categoryId == id).toList();
    Get.toNamed(Routes.PRODUCTS);
  }

  Future<Object?>? downloadAllData() async {
    try {
      final uri = Uri.parse(ApiList.getAllData);
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        products = [];
        var result = jsonDecode(response.body);
        var jsonproducts = result['website']['products'];
        for (var product in jsonproducts) {
          // print(ProductModel.fromJson(product));
          products.add(ProductModel.fromJson(product));
        }
        return products;
      } else {
        throw Exception('Failed to load departments');
      }
    } catch (e) {
      return e;
    }
  }
}
