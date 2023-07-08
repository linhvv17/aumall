
import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:equatable/equatable.dart';

class BannerModel extends BannerEntity{
  const BannerModel(super.images);
  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      List<ImageModel>.from(
          json['data'].map((x) => ImageModel.fromJson(x))),
    );
  }



  // factory BannerModel.fromJson(Map<String, dynamic> json) {
  //   print('BannerModel ${json}');
  //   print('BannerModel ${json['data'].length}');
  //   print('BannerModel ${json['data']}');
  //   print('BannerModel ${json['data'][0]['id']}');
  //   print('BannerModel ${json['data'][0]['src']}');
  //   print('BannerModel ${json['data'][1]['id']}');
  //   print('BannerModel ${json['data'][1]['src']}');
  //
  //   List<ImageModel> listImage = [];
  //
  //   for(int i = 0; i <json['data'].length; i ++){
  //     ImageModel imageModel = ImageModel(json['data'][i]['id'].toString(), json['data'][i]['src'].toString());
  //     listImage.add(imageModel);
  //   }
  //
  //   print('BannerModel listImage ${listImage.length}');
  //
  //
  //
  //   return BannerModel(
  //       listImage
  //   );
  // }


}

class ImageModel extends ImageEntity {
  const ImageModel(super.publicid, super.url);
  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      ImageModel(
          json["id"].toString(),
          json["image_url"].toString()
      );
}


class ImageEntity extends Equatable {
  final String id;
  final String src;

  const ImageEntity(this.id, this.src);

  @override
  List<Object> get props => [id, src];
}