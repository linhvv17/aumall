import 'package:aumall/features/shop_profile/data/models/shop_profile_model.dart';
import 'package:aumall/features/shop_profile/domain/repositories/shop_profile_repository.dart';

import '../../../../core/local/shared_preference.dart';
import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';

abstract class ShopProfileDatasource {
  Future<ShopProfileModel> getShopProfile(GetShopProfileParams getShopProfileParams);
}

class ShopProfileDatasourceImpl implements ShopProfileDatasource {
  final APIProvider apiProvider;
  ShopProfileDatasourceImpl(this.apiProvider);

  @override
  Future<ShopProfileModel> getShopProfile(GetShopProfileParams getShopProfileParams)async {
    final response = await apiProvider.get(
        endPoint: shopInfoAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
        query: <String, dynamic>{
          'user_id': getShopProfileParams.shopId,
        });
    print("getShopProfile ${response.data['data']}");
    return ShopProfileModel.fromJson(response.data['data']['shop']);
  }


}
