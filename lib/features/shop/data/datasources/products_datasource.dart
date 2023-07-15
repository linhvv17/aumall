import 'dart:convert';
import 'package:aumall/features/shop/data/models/categories_model.dart';
import 'package:aumall/features/shop/data/models/reviews_model.dart';
import 'package:flutter/services.dart';
import '../../../../core/local/shared_preference.dart';
import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/list_shop_products_model.dart';
import '../models/products_model.dart';
import '../models/response_model.dart';

abstract class ProductsDatasource {
  Future<ProductsModel> getAllProductsFromTxt();
  Future<ProductsModel> getSpecificProductFromTxt(GetProductParams params);
  Future<CategoriesModel> getShopDefaultData();
  Future<ListShopProductsModel> getListProductByCategory(GetShopDataDefaultParams getShopDataDefaultParams);
  Future<ProductsModel> getAllProducts();
  Future<ProductsModel> getAllProductsAuMall();
  Future<ProductsModel> getSpecificProduct(GetProductParams params);
  Future<ResponseModel> sendReview(SendReviewParams params);
  Future<GetReviewsModel> getReviews(GetReviewsParams params);
}

class ProductsDatasourceImpl implements ProductsDatasource {
  final APIProvider apiProvider;

  ProductsDatasourceImpl(this.apiProvider);

  @override
  Future<ProductsModel> getAllProductsFromTxt() async {
    final data = await rootBundle.loadString('assets/txt/products.txt');
    final body = json.decode(data);
    return ProductsModel.fromJson(body);
  }
  //allProductsAuMall

  @override
  Future<ProductsModel> getAllProductsAuMall() async {
    final response = await apiProvider.get(
        endPoint: allProductsAuMall,
        token: PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '',
      query: <String, dynamic> {
    'status': '1',
    }
    );

    print('getAllProductsAuMall ${response.data}');
    return ProductsModel.fromJson(response.data);
  }

  @override
  Future<ProductsModel> getAllProducts() async {
    final response = await apiProvider.get(endPoint: productsEndPoint);
    return ProductsModel.fromJson(response.data);
  }


  @override
  Future<ProductsModel> getSpecificProductFromTxt(GetProductParams params) async {
    print('getSpecificProductFromTxt:');
    print('getSpecificProductFromTxt: ${params.category}');
    final data = await rootBundle.loadString('assets/txt/${params.category.toLowerCase()}.txt');
    final body = json.decode(data);
    return ProductsModel.fromJson(body);
  }
  @override
  Future<ProductsModel> getSpecificProduct(GetProductParams params) async {
    final response = await apiProvider.get(endPoint: productsEndPoint, query: {
      "category": params.category,
      "price[gt]": params.minPrice,
      "price[lt]": params.maxPrice,
      "ratings[gt]": params.rate,
      "keyword": params.keyword,
    });
    return ProductsModel.fromJson(response.data);
  }

  @override
  Future<ResponseModel> sendReview(SendReviewParams params) async {
    final response = await apiProvider.put(
        endPoint: getAllReviewsEndPoint,
        data: {
          'productId': params.productId,
          'comment': params.comment,
          'rating': params.rating,
        },
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');
    return ResponseModel.fromJson(response.data);
  }

  @override
  Future<GetReviewsModel> getReviews(GetReviewsParams params) async {
    final response = await apiProvider.get(
      endPoint: "$reviewEndPoint?id=${params.productId}",
    );
    return GetReviewsModel.fromJson(response.data);
  }

  @override
  Future<CategoriesModel> getShopDefaultData() async {
    final response = await apiProvider.get(
        endPoint: categoryAuMall,
        // data: {
        //   'status' : 1,
        //   'category_id': getShopDataDefaultParams.categoryId,
        //   // 'comment': params.comment,
        //   // 'rating': params.rating,
        // },
        token:
        PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');

    print('getShopDefaultData getShopDefaultData: ${response.data}');







    return CategoriesModel.fromJson(response.data);
  }

  @override
  Future<ListShopProductsModel> getListProductByCategory(GetShopDataDefaultParams getShopDataDefaultParams) async {

    print('getListProductByCategory categoryId : ${getShopDataDefaultParams.categoryId}');

    final params = <String, dynamic>{
      'status' : "1",
      'category_id': getShopDataDefaultParams.categoryId.toString(),
    };

    final responseProducts = await apiProvider.get(
        endPoint: allProductsAuMall,
        query: params,
        token:
        PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');



    print('final json : ${responseProducts.data}');



    return ListShopProductsModel.fromJson(
        responseProducts.data
    );



  }

  
}






