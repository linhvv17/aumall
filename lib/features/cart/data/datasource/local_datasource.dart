
import 'package:aumall/core/local/shared_preference.dart';
import 'package:aumall/features/cart/data/models/cart_product_model.dart';
import 'package:hive/hive.dart';
import '../../../../core/local/cache_manager.dart';
import '../models/cart_model.dart';

class CartLocalDataSourceManager implements CacheManagerBase<CartProduct> {

  @override
  Future<void> init() async {

    // await Hive.openBox<CartProduct>("product-cahce");
    // await Hive.openBox<CartProductModel>("product-cache");
    String? nameProductCache = PreferenceHelper.getDataFromSharedPreference(key: "keyUser");
    if(nameProductCache != null){
      registerAdapter();
      await Hive.openBox<CartProductModel>(nameProductCache);
    }

  }

  @override
  Future<void> addItem(CartProduct item) async {
    await Hive.box("product-cahce").add(item);
  }

  @override
  CartProduct? getItem(String key) {
    return Hive.box("product-cahce").get(
      key,
    );
  }

  @override
  Future<void> putItem(CartProduct item) async {
    await Hive.box("product-cahce").put("product-cahce", item);
  }

  @override
  Future<void> clearAll() async {
    await Hive.box("product-cahce").clear();
  }

  @override
  void registerAdapter() {
    if (!Hive.isAdapterRegistered(4)) {
      // Hive.registerAdapter(CartProductAdapter());
      Hive.registerAdapter(CartProductModelAdapter());
    }

  }

  @override
  Future<void> clearAt(int id) async {
    await Hive.box("product-cahce").deleteAt(id);
  }
}
