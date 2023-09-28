import 'package:equatable/equatable.dart';


class ShopProfileEntity extends Equatable {
  final int? id;
  final int? userId;
  final String? name;
  final String? address;
  final String? contact;
  final String? description;
  final String? banner;
  final String? image;
  final String? bannerUrl;
  final String? imageUrl;
  const ShopProfileEntity(
      this.id,
      this.userId,
      this.name,
      this.address,
      this.contact,
      this.description,
      this.banner,
      this.image,
      this.bannerUrl,
      this.imageUrl,
      );
  @override
  List<Object?> get props => [];
}
