import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable {
  final List<CategoryEntity> categories;

  const CategoriesEntity(
    this.categories,
  );

  @override
  List<Object> get props => [categories];
}

class CategoryEntity extends Equatable {
  final int id;
  final String name;
  final String alias;
  final String description;
  final int? priority;
  // final List<Childes> childes;

  const CategoryEntity({
    required this.id,
    required this.name,
    required this.alias,
    required this.description,
    this.priority,
    // required this.childes,
  });

  @override
  List<Object?> get props {
    return [
      id,
      name,
      description,
    ];
  }
}
