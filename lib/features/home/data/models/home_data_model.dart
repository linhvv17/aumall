import 'package:aumall/features/home/domain/entities/banner_entity.dart';
import 'package:aumall/features/home/domain/entities/home_data_entity.dart';
import 'package:equatable/equatable.dart';

class HomeDataModel extends HomeDataEntity {
  const HomeDataModel(super.images, super.listProductHomeData);

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
