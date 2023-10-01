import 'package:aumall/features/shop_profile/data/models/list_shop_product_model.dart';
import 'package:aumall/features/shop_profile/data/models/shop_profile_model.dart';
import 'package:aumall/features/shop_profile/domain/repositories/shop_profile_repository.dart';

import '../../../../core/local/shared_preference.dart';
import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';


abstract class ShopProfileDatasource {
  Future<ShopProfileModel> getShopProfile(GetShopProfileParams getShopProfileParams);
  Future<List<ListShopProductsModel>> getShopProduct(GetShopProductParams getShopProductParams);
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

  @override
  Future<List<ListShopProductsModel>> getShopProduct(GetShopProductParams getShopProductParams) async {
    final response = await apiProvider.get(
        endPoint: allProductsOderByShop,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
        query: <String, dynamic>{
          'user_id': getShopProductParams.shopId,
        });
    print("getShopProduct response.data['data'] ${response.data['data']}");
    print("getShopProduct response.data['data']['data'] ${response.data['data']['data']}");


    List<ListShopProductsModel> listProductsOrderByShopModel =
    List<ListShopProductsModel>.from(
        response.data['data']['data'].map((x) => ListShopProductsModel.fromJson(x)
        ));


    print("getShopProduct listProductsOrderByShopModel ${listProductsOrderByShopModel.length}");
    // List<ShopProductModel>.from(
    //     response.data['data']['data']['products'].map((x) => ShopProductModel.fromJson(x)));

    // List<ShopProductModel> listShopProductModel =
    // List<ShopProductModel>.from(
    //     response.data['data']['data'].map((x) => ShopProductModel.fromJson(x)));


    return listProductsOrderByShopModel;
  }


}
