class CategoryModel {
  int? id;
  String? title;
  String? image;

  CategoryModel({
    required this.id,
    required this.title,
    required this.image,
  });

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['department_id'];
    title = json['department_name'];
    image = json['image'];
  }
}
