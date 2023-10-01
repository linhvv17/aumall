import 'package:equatable/equatable.dart';


class ShopProductEntity extends Equatable {
  final int? id;
  final String? title;
  final String? description;
  final String? thumbnailUrl;
  final String? price;
  const ShopProductEntity(
      this.id,
      this.title,
      this.description,
      this.thumbnailUrl,
      this.price,
      );
  @override
  List<Object?> get props => [

  ];
}
