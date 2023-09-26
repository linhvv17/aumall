import 'dart:convert';
import 'package:aumall/features/shopping/data/models/categories_model.dart';
import 'package:aumall/features/shopping/data/models/product/info_shopping_model.dart';
import 'package:aumall/features/shopping/data/models/product/products_order_by_shop_model.dart';
import 'package:aumall/features/shopping/data/models/reviews_model.dart';
import 'package:aumall/features/shopping/domain/entities/reviews_entity.dart';
import 'package:aumall/features/shopping/domain/usecases/get_specific_product.dart';
import 'package:flutter/services.dart';
import '../../../../core/local/shared_preference.dart';
import '../../../../core/network/api_provider.dart';
import '../../../../core/utilities/endpoints.dart';
import '../../domain/repositories/product_repository.dart';
import '../models/list_shop_products_model.dart';
import '../models/products_model.dart';
import '../models/response_model.dart';
import '../models/shop_data_default_model.dart';

abstract class ProductsDatasource {
  Future<ProductsModel> getAllProductsFromTxt();
  Future<ProductsModel> getSpecificProductFromTxt(GetProductParams params);
  Future<CategoriesModel> getShopDefaultData();
  Future<ListShopProductsModel> getListProductByCategory(
      GetShopDataDefaultParams getShopDataDefaultParams);
  Future<ProductsModel> getAllProducts();
  Future<ProductsModel> getAllProductsAuMall();
  Future<ResponseModel> sendReview(SendReviewParams params);
  Future<GetReviewsEntity> getReviews(GetReviewsParams params);
  Future<ShopDataDefaultModel> getShopDataDefault();
  Future<CategoriesModel> getCategories();
  Future<List<ProductsOrderByShopModel>> getProductsOfCategory(
      GetProductsOfCategoryUseCaseParams getProductsOfCategoryUseCaseParams);
  Future<ListShopProductsModel> changCategory(
      ChangeCategoryUseCaseParams changeCategoryUseCaseParams);
  Future<List<ProductsOrderByShopModel>> searchProducts(
      SearchProductsUseCaseParams searchProductsUseCaseParams);
  Future<ListShopProductsModel> getProductsByType(
      GetProductsByTypeUseCaseParams getProductsByTypeUseCaseParams);
  Future<List<ProductsOrderByShopModel>> getProductsByFilter(
      GetProductByFilterUseCaseParams params);
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
        query: <String, dynamic>{
          'status': '1',
        });

    print('getAllProductsAuMall ${response.data}');
    return ProductsModel.fromJson(response.data);
  }

  @override
  Future<ProductsModel> getAllProducts() async {
    final response = await apiProvider.get(endPoint: productsEndPoint);
    return ProductsModel.fromJson(response.data);
  }

  @override
  Future<ProductsModel> getSpecificProductFromTxt(
      GetProductParams params) async {
    print('getSpecificProductFromTxt:');
    print('getSpecificProductFromTxt: ${params.category}');
    final data = await rootBundle
        .loadString('assets/txt/${params.category.toLowerCase()}.txt');
    final body = json.decode(data);
    return ProductsModel.fromJson(body);
  }

  @override
  Future<ResponseModel> sendReview(SendReviewParams params) async {
    final response = await apiProvider.post(
        endPoint: sendReviewAuMall,
        data: {
          'product_id': int.parse(params.productId),
          'comment': params.comment,
          'rating': params.rating,
        },
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');
    return ResponseModel.fromJson(response.data);
  }

  @override
  Future<GetReviewsEntity> getReviews(GetReviewsParams params) async {
    final response = await apiProvider.get(
        // endPoint: "$productDetailAuMall/${params.productId}",
        endPoint: reviewAuMall,
        query: <String, dynamic>{
          'product_id': params.productId,
        },
        // endPoint: "$reviewEndPoint?id=${params.productId}",
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');

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

    CategoriesModel categoriesModel = CategoriesModel.fromJson(response.data);

    final params = <String, dynamic>{
      'status': "1",
      'category_id': categoriesModel.categories[0].id.toString(),
    };

    final responseProducts = await apiProvider.get(
        endPoint: allProductsAuMall,
        query: params,
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');

    ListShopProductsModel.fromJson(responseProducts.data);

    return CategoriesModel.fromJson(response.data);
  }

  @override
  Future<ListShopProductsModel> getListProductByCategory(
      GetShopDataDefaultParams getShopDataDefaultParams) async {
    print(
        'getListProductByCategory categoryId : ${getShopDataDefaultParams.categoryId}');

    final params = <String, dynamic>{
      'status': "1",
      'category_id': getShopDataDefaultParams.categoryId.toString(),
    };

    final responseProducts = await apiProvider.get(
        endPoint: allProductsAuMall,
        query: params,
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');

    print('final json : ${responseProducts.data}');

    return ListShopProductsModel.fromJson(responseProducts.data);
  }

  @override
  Future<ShopDataDefaultModel> getShopDataDefault() async {
    //get list categories
    final responseCategories = await apiProvider.get(
        endPoint: categoryAuMall,
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');
    CategoriesModel categoriesModel =
        CategoriesModel.fromJson(responseCategories.data);

    ////get list products by categories
    final params = <String, dynamic>{
      'status': "1",
      'category_id': categoriesModel.categories[0].id.toString(),
    };
    final responseProducts = await apiProvider.get(
        endPoint: allProductsAuMall,
        query: params,
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');

    ListShopProductsModel listShopProductsModel =
        ListShopProductsModel.fromJson(responseProducts.data);

    return ShopDataDefaultModel(categoriesModel, listShopProductsModel);
  }

  @override
  Future<ListShopProductsModel> changCategory(
      ChangeCategoryUseCaseParams changeCategoryUseCaseParams) async {
    final params = <String, dynamic>{
      'status': "1",
      'category_id': changeCategoryUseCaseParams.categoryId.toString(),
    };
    final responseProducts = await apiProvider.get(
        endPoint: allProductsAuMall,
        query: params,
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');
    return ListShopProductsModel.fromJson(responseProducts.data);
  }

  @override
  Future<List<ProductsOrderByShopModel>> searchProducts(
      SearchProductsUseCaseParams searchProductsUseCaseParams) async {
    final params = <String, dynamic>{
      'keyword': searchProductsUseCaseParams.keyWord,
      'category_id': searchProductsUseCaseParams.categoryId,
    };
    final responseProducts = await apiProvider.get(
        endPoint: searchProductsAuMall,
        query: params,
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');

    List<ProductsOrderByShopModel> listProductsOrderByShopModel =
    List<ProductsOrderByShopModel>.from(
        responseProducts.data['data']['data'].map((x) => ProductsOrderByShopModel.fromJson(x)));
    return listProductsOrderByShopModel;
  }

  @override
  Future<List<ProductsOrderByShopModel>> getProductsByFilter(
      GetProductByFilterUseCaseParams getProductByFilterUseCaseParams) async {
    final params = <String, dynamic>{
      'status': "1",
      'min_price': getProductByFilterUseCaseParams.minPrice,
      'max_price': getProductByFilterUseCaseParams.maxPrice,
      'category_id': getProductByFilterUseCaseParams.categoryId,
    };
    final responseProducts = await apiProvider.get(
        endPoint: allProductsAuMall,
        query: params,
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');

    List<ProductsOrderByShopModel> listProductsOrderByShopModel =
    List<ProductsOrderByShopModel>.from(
        responseProducts.data['data']['data'].map((x) => ProductsOrderByShopModel.fromJson(x)));
    return listProductsOrderByShopModel;
  }

  @override
  Future<ListShopProductsModel> getProductsByType(
      GetProductsByTypeUseCaseParams getProductsByTypeUseCaseParams) async {
    final params = <String, dynamic>{
      'status': 1,
      getProductsByTypeUseCaseParams.keyWord: 1,
    };
    final responseProducts = await apiProvider.get(
        endPoint: allProductsAuMall,
        query: params,
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');

    print("searchProducts ${responseProducts.data.toString()}");

    return ListShopProductsModel.fromJson(responseProducts.data);
  }

  @override
  Future<CategoriesModel> getCategories() async {
    //get list categories
    final responseCategories = await apiProvider.get(
        endPoint: categoryAuMall,
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');
    CategoriesModel categoriesModel =
        CategoriesModel.fromJson(responseCategories.data);
    return categoriesModel;
  }

  @override
  Future<List<ProductsOrderByShopModel>> getProductsOfCategory(
      GetProductsOfCategoryUseCaseParams
          getProductsOfCategoryUseCaseParams) async {
    ////get list products by categories
    final params = <String, dynamic>{
      'status': "1",
      'category_id': getProductsOfCategoryUseCaseParams.categoryId.toString(),
    };
    final responseProducts = await apiProvider.get(
        endPoint: allProductsOderByShop,
        query: params,
        token:
            PreferenceHelper.getDataFromSharedPreference(key: 'token') ?? '');


    List<ProductsOrderByShopModel> listProductsOrderByShopModel =
    List<ProductsOrderByShopModel>.from(
        responseProducts.data['data']['data'].map((x) => ProductsOrderByShopModel.fromJson(x)));

    return listProductsOrderByShopModel;
  }
}
