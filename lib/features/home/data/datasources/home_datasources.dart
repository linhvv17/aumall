
import 'package:aumall/core/network/api_provider.dart';
import 'package:aumall/core/utilities/endpoints.dart';
import 'package:aumall/features/home/data/models/banner_model.dart';

import '../../../../core/local/shared_preference.dart';
import '../models/list_product_home_model.dart';

abstract class HomeDatasource {
  Future<BannerModel> getBannerAds();
  Future<ListProductHomeModel> getListProductHome();
}

class HomeDatasourceImpl implements HomeDatasource {
  final APIProvider apiProvider;
  HomeDatasourceImpl(this.apiProvider);
  @override
  Future<BannerModel> getBannerAds() async {

    final response = await apiProvider.get(
        endPoint: bannerAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');
    return BannerModel.fromJson(
       response.data['data']
    );
  }

  @override
  Future<ListProductHomeModel> getListProductHome() async {
    final response = await apiProvider.get(
        endPoint: homeAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');
    print('getListProductHome ${response.data}');
    return ListProductHomeModel.fromJson(
        response.data
    );
  }
}
