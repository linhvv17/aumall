import '../../domain/entities/categories_entity.dart';
import '../../domain/entities/products_entity.dart';

class CategoriesModel extends CategoriesEntity {
  const CategoriesModel(super.categories);

  factory CategoriesModel.fromJson(Map<String, dynamic> json) =>
      CategoriesModel(
        List<CategoryModel>.from(
            json['data'].map((x) => CategoryModel.fromJson(x))),
      );
}

class CategoryModel extends CategoryEntity {
  const CategoryModel({
    required super.id,
    required super.name,
    required super.alias,
    required super.description,
    super.priority,
    // required super.childes,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      id: json['id'],
      name: json['name'],
      alias: json['alias'],
      description: json['description'] ?? '',
      priority: json['priority'] ?? 0);

  // {
  //   id = json['id'];
  //   name = json['name'];
  //   alias = json['alias'];
  //   description = json['description'] ??'';
  //   priority = json['priority'] ?? 0;
  //   childes = List.from(json['childes']).map((e)=>Childes.fromJson(e)).toList();
  // }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['alias'] = alias;
    data['description'] = description;
    data['priority'] = priority;
    // data['childes'] = childes.map((e) => e.toJson()).toList();
    return data;
  }
}
