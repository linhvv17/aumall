import 'package:aumall/core/local/cecure_storage.dart';
import 'package:aumall/core/local/shared_preference.dart';
import 'package:aumall/features/auction/presentation/bloc/auction_bloc.dart';
import 'package:aumall/features/cart/data/datasource/cart_datasource.dart';
import 'package:aumall/features/cart/data/repositories_impls/cart_repository_impl.dart';
import 'package:aumall/features/cart/domain/repositories/cart_repository.dart';
import 'package:aumall/features/cart/domain/usecases/remove_product_in_cart_usecase.dart';
import 'package:aumall/features/favorite/data/repositories_impls/favorite_product_repository_impl.dart';
import 'package:aumall/features/favorite/domain/repositories/favorite_product_repository.dart';
import 'package:aumall/features/home/data/datasources/home_datasources.dart';
import 'package:aumall/features/home/data/repositories/home_repository_impl.dart';
import 'package:aumall/features/home/domain/repositories/home_repository.dart';
import 'package:aumall/features/home/domain/usecases/get_banner_usecase.dart';
import 'package:aumall/features/home/domain/usecases/get_product_detail_usecase.dart';
import 'package:aumall/features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'package:aumall/features/home/presentation/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'package:aumall/features/notification/data/datasources/notification_datasource.dart';
import 'package:aumall/features/notification/data/repositories_impls/notification_repository_impl.dart';
import 'package:aumall/features/notification/domain/repositories/notification_repository.dart';
import 'package:aumall/features/notification/domain/usecases/get_list_notification_usecase.dart';
import 'package:aumall/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:aumall/features/profile/domain/usecases/add_address_usecase.dart';
import 'package:aumall/features/profile/domain/usecases/logout_usecase.dart';
import 'package:aumall/features/shopping/domain/usecases/change_category_usecase.dart';
import 'package:aumall/features/shopping/domain/usecases/get_categories_usecase.dart';
import 'package:aumall/features/shopping/domain/usecases/get_products_shop_usecase.dart';
import 'package:aumall/features/shopping/domain/usecases/search_products_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:aumall/core/network/payment_api_provider_impl.dart';
import 'package:aumall/core/theme/bloc/theme_bloc.dart';
import 'package:aumall/features/cart/data/datasource/placesAPI.dart';
import 'package:aumall/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:aumall/features/cart/presentation/bloc/cubit/address_cubit.dart';
import 'package:aumall/features/cart/presentation/bloc/location_bloc.dart';
import 'package:aumall/features/favorite/presentation/bloc/favourite_bloc.dart';
import 'package:aumall/features/payment/data/datasources/payment_datasource.dart';
import 'package:aumall/features/payment/data/repositrories/payment_repository_impl.dart';
import 'package:aumall/features/payment/domain/repositories/payment_repository.dart';
import 'package:aumall/features/payment/domain/usecases/createNewOrder_Usecase.dart';
import 'package:aumall/features/payment/domain/usecases/getAllOrders.dart';
import 'package:aumall/features/payment/domain/usecases/requestAuth_Usecase.dart';
import 'package:aumall/features/payment/presentation/bloc/order_bloc.dart';
import 'package:aumall/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:aumall/features/shopping/domain/usecases/get_all_reviews.dart';
import 'core/network/api_provider.dart';
import 'core/network/api_provider_impl.dart';
import 'core/network/network_info.dart';
import 'core/network/paymentApiProvider.dart';
import 'features/auction/data/datasources/auction_datasource.dart';
import 'features/auction/data/repositories_impls/auction_product_repository_impl.dart';
import 'features/auction/domain/repositories/auction_product_repository.dart';
import 'features/auction/domain/usecases/action_auction_usecase.dart';
import 'features/auction/domain/usecases/add_auction_product_usecase.dart';
import 'features/auction/domain/usecases/get_auction_product_usecase.dart';
import 'features/auction/domain/usecases/get_auction_session_info_usecase.dart';
import 'features/auction/domain/usecases/remove_auction_product_usecase.dart';
import 'features/cart/domain/usecases/add_product_to_cart_usecase.dart';
import 'features/cart/domain/usecases/get_product_in_cart_usecase.dart';
import 'features/cart/domain/usecases/update_product_in_cart_usecase.dart';
import 'features/favorite/data/datasources/favorite_datasource.dart';
import 'features/favorite/domain/usecases/add_favorite_product_usecase.dart';
import 'features/favorite/domain/usecases/get_favorite_product_usecase.dart';
import 'features/favorite/domain/usecases/remove_favorite_product_usecase.dart';
import 'features/forgotpass&verifyemail/data/datasources/forgotpassword_datasource.dart';
import 'features/forgotpass&verifyemail/data/repositories/forgotpassword_repositoryimpl.dart';
import 'features/forgotpass&verifyemail/domain/repositories/forgotpassword_repository.dart';
import 'features/forgotpass&verifyemail/domain/usecases/forgotpassword_usecase.dart';
import 'features/forgotpass&verifyemail/presentation/forgotpass&verifyemail_bloc/forgotpass&verifyemail_bloc.dart';
import 'features/home/domain/usecases/get_home_data_usecase.dart';
import 'features/home/domain/usecases/get_list_product_home_usecase.dart';
import 'features/home/presentation/bloc/bottom_nav/bottomNavigationBar_bloc.dart';
import 'features/login/data/datasources/login_datasource.dart';
import 'features/login/data/repositories/login_repostory_impl.dart';
import 'features/login/domain/repositories/login_repository.dart';
import 'features/login/domain/usecases/login_usecase.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/notification/domain/usecases/get_detail_notification_usecase.dart';
import 'features/payment/domain/usecases/requestOrder_Usecase.dart';
import 'features/payment/domain/usecases/requestPayment_Usecase.dart';
import 'features/profile/data/datasources/profile_remote_datasource.dart';
import 'features/profile/data/repositories/profile_repository_impl.dart';
import 'features/profile/domain/repositories/profile_repository.dart';
import 'features/profile/domain/usecases/getUserDetail.dart';
import 'features/profile/domain/usecases/get_address_list_usecase.dart';
import 'features/profile/domain/usecases/update_password_usecase.dart';
import 'features/profile/domain/usecases/updateProfile.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/profile/presentation/bloc/update_password_bloc.dart';
import 'features/register/data/datasources/register_datasource.dart';
import 'features/register/data/repositories/register_repository_impl.dart';
import 'features/register/domain/repositories/register_repository.dart';
import 'features/register/domain/usecases/register_usecase.dart';
import 'features/register/presentation/bloc/register_bloc.dart';
import 'features/setpassword/data/datasources/Resetpassword_datasource.dart';
import 'features/setpassword/data/repositories/resetpassword_repositoryimpl.dart';
import 'features/setpassword/domain/repositories/resetPassword_repository.dart';
import 'features/setpassword/domain/usecases/resetpassword_usecase.dart';
import 'features/setpassword/presentation/bloc/reset_password_bloc.dart';
import 'features/shopping/data/datasources/products_datasource.dart';
import 'features/shopping/data/repositories/products_repositoryimpl.dart';
import 'features/shopping/domain/repositories/product_repository.dart';
import 'features/shopping/domain/usecases/get_all_products_usecase.dart';
import 'features/shopping/domain/usecases/get_products_by_type_usecase.dart';
import 'features/shopping/domain/usecases/get_products_of_category_usecase.dart';
import 'features/shopping/domain/usecases/get_shop_data_default_usecase.dart';
import 'features/shopping/domain/usecases/get_specific_product.dart';
import 'features/shopping/domain/usecases/send_review_usecase.dart';
import 'features/shopping/presentation/bloc/categories/categories_bloc.dart';
import 'features/shopping/presentation/bloc/products_bloc.dart';
import 'features/shopping/presentation/bloc/send_review_bloc.dart';

GetIt injector = GetIt.instance;

Future<void> init() async {
  //BLoC
  injector.registerFactory(() => LoginBloc(injector()));
  injector.registerFactory(() => HomeBloc(injector(), injector(), injector()));
  injector.registerFactory(() => RegisterBloc(injector()));
  injector.registerFactory(() => ForgetpasswordAndeVerifyEmailBloc(injector()));
  injector.registerFactory(() => ResetPasswordBloc(injector()));
  injector.registerFactory(() => BottomNavigationBarBloc());
  injector.registerFactory(() => ProductsBloc(
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector(),
      injector()));
  injector.registerFactory(() => CategoriesBloc(injector()));
  injector.registerFactory(() => ProductDetailBloc(injector()));
  injector.registerFactory(() =>
      ProfileBloc(injector(), injector(), injector(), injector(), injector()));
  injector.registerFactory(() => UpdatePasswordBloc(injector()));
  injector.registerFactory(() => SendReviewBloc(injector(), injector()));
  injector
      .registerFactory(() => FavouriteBloc(injector(), injector(), injector()));
  injector.registerFactory(
      () => CartBloc(injector(), injector(), injector(), injector()));
  injector
      .registerFactory(() => AuctionBloc(injector(), injector(), injector()));
  injector.registerFactory(() => ThemeBloc());
  injector.registerFactory(() => AddressCubit(injector(), injector()));
  injector.registerFactory(() => LocationBloc(injector(), injector()));
  injector
      .registerFactory(() => PaymentBloc(injector(), injector(), injector()));
  injector.registerFactory(() => OrderBloc(injector(), injector()));
  injector.registerFactory(() => NotificationBloc(injector(), injector()));
  //Usecase
  injector.registerLazySingleton(() => LoginUseCase(injector()));
  injector.registerLazySingleton(() => GetBannerUseCase(injector()));
  injector.registerLazySingleton(() => GetProductDetailUseCase(injector()));
  injector.registerLazySingleton(() => GetHomeDataUseCase(injector()));
  injector.registerLazySingleton(() => GetShopDataDefaultUseCase(injector()));
  injector.registerLazySingleton(() => GetCategoriesUseCase(injector()));
  injector
      .registerLazySingleton(() => GetProductsOfCategoryUseCase(injector()));
  injector.registerLazySingleton(() => ChangeCategoryUseCase(injector()));
  injector.registerLazySingleton(() => SearchProductsUseCase(injector()));
  injector.registerLazySingleton(() => GetListProductHomeUseCase(injector()));
  injector.registerLazySingleton(() => GetProductsShopUseCase(injector()));
  injector.registerLazySingleton(() => GetProductsByTypeUseCase(injector()));
  injector.registerLazySingleton(() => GetFavoriteProductUseCase(injector()));
  injector.registerLazySingleton(() => GetProductInCartUseCase(injector()));
  injector.registerLazySingleton(() => GetAuctionProductUseCase(injector()));
  injector.registerLazySingleton(() => ActionAuctionUseCase(injector()));
  injector
      .registerLazySingleton(() => GetAuctionSessionInfoUseCase(injector()));
  injector.registerLazySingleton(() => AddAuctionProductUseCase(injector()));
  injector.registerLazySingleton(() => RemoveAuctionProductUseCase(injector()));
  injector
      .registerLazySingleton(() => RemoveFavoriteProductUseCase(injector()));
  injector.registerLazySingleton(() => AddFavoriteProductUseCase(injector()));
  injector.registerLazySingleton(() => AddProductToCartUseCase(injector()));
  injector.registerLazySingleton(() => UpdateProductInCartUseCase(injector()));
  injector.registerLazySingleton(() => RemoveProductInCartUseCase(injector()));
  injector.registerLazySingleton(() => RegisterUseCase(injector()));
  injector.registerLazySingleton(() => ForgotPassUsecase(injector()));
  injector.registerLazySingleton(() => ResetPasswordUseCase(injector()));
  injector.registerLazySingleton(() => GetAllProductsUseCase(injector()));
  injector.registerLazySingleton(() => GetProductByFilterUseCase(injector()));
  injector.registerLazySingleton(() => GetUserDetails(injector()));
  injector.registerLazySingleton(() => GetAddressListUseCase(injector()));
  injector.registerLazySingleton(() => AddAddressUseCase(injector()));
  injector.registerLazySingleton(() => UpdateUserDetailUsecase(injector()));
  injector.registerLazySingleton(() => LogOutUseCase(injector()));
  injector.registerLazySingleton(() => UpdatePasswordUseCase(injector()));
  injector.registerLazySingleton(() => GetReviewsUseCase(injector()));
  injector.registerLazySingleton(() => SendReviewUseCase(injector()));
  injector.registerLazySingleton(() => RequestAuthUsecase(injector()));
  injector.registerLazySingleton(() => RequestOrderUsecase(injector()));
  injector.registerLazySingleton(() => RequestPaymentUsecase(injector()));
  injector.registerLazySingleton(() => CreateNewOrderUsecase(injector()));
  injector.registerLazySingleton(() => GetAllOrderesUsecase(injector()));
  //notification
  injector.registerLazySingleton(() => GetListNotificationUseCase(injector()));
  injector.registerLazySingleton(() => GetDetailNotificationUseCase(injector()));



  //Repository
  injector.registerLazySingleton<LoginBaseRepository>(
      () => LoginRepositoryImpl(injector(), injector()));
  injector.registerLazySingleton<HomeBaseRepository>(
      () => HomeRepositoryImpl(injector(), injector()));
  injector.registerLazySingleton<FavoriteBaseRepository>(
      () => FavoriteRepositoryImpl(injector(), injector()));
  injector.registerLazySingleton<CartBaseRepository>(
      () => CartRepositoryImpl(injector(), injector()));
  injector.registerLazySingleton<AuctionBaseRepository>(
      () => AuctionRepositoryImpl(injector(), injector()));
  injector.registerLazySingleton<RegisterBaseRepository>(
      () => RegisterRepositoryImpl(injector(), injector()));
  injector.registerLazySingleton<ForgotPasswordRepo>(
      () => ForgotPasswordRepoImpl(injector(), injector()));
  injector.registerLazySingleton<ResetPasswordRepository>(
      () => ResetPasswordRepositoryImpl(injector(), injector()));
  injector.registerLazySingleton<ProductRepository>(
      () => ProductsRepositoryImpl(injector(), injector()));
  injector.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(injector(), injector()));
  injector.registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(injector(), injector()));
  injector.registerLazySingleton<NotificationBaseRepository>(
          () => NotificationRepositoryImpl(injector(), injector()));

  //DataSource
  injector.registerLazySingleton<LoginDatasource>(
      () => LoginDatasourceImpl(injector()));
  injector.registerLazySingleton<HomeDatasource>(
      () => HomeDatasourceImpl(injector()));
  injector.registerLazySingleton<FavoriteDatasource>(
      () => FavoriteDatasourceImpl(injector()));
  injector.registerLazySingleton<CartDatasource>(
      () => CartDatasourceImpl(injector()));
  injector.registerLazySingleton<AuctionDatasource>(
      () => AuctionDatasourceImpl(injector()));
  injector.registerLazySingleton<RegisterBaseDatasource>(
      () => RegisterDataSourceImpl(injector()));
  injector.registerLazySingleton<ForgetPasswordDataSource>(
      () => ForgetPasswordDataSourceImpl(injector()));
  injector.registerLazySingleton<ResetPasswordDatasource>(
      () => ResetPasswordDataSourceImpl(injector()));
  injector.registerLazySingleton<ProductsDatasource>(
      () => ProductsDatasourceImpl(injector()));
  injector.registerLazySingleton<ProfileDatasource>(
      () => ProfileDataSourceImpl(injector()));
  injector
      .registerLazySingleton<PlacesDataSource>(() => PlacesDatasourceImpl());
  injector.registerLazySingleton<PaymentDataSource>(
      () => PaymentDataSourceImpl(injector(), injector()));
  injector.registerLazySingleton<NotificationDatasource>(
          () => NotificationDatasourceImpl(injector()));

  //---Core---//
  //API Provider
  injector.registerLazySingleton<APIProvider>(() => APIProviderImpl());
  injector.registerLazySingleton<PaymentAPIProvider>(
      () => PaymentAPIProviderImpl());
  //Network Info
  injector
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(injector()));
  //InternetConnectionChecker
  injector.registerLazySingleton(() => InternetConnectionChecker());

  //SharedPreference
  injector.registerLazySingleton<PreferenceHelper>(() => PreferenceHelper());
  injector.registerLazySingleton<SecureStorage>(() => SecureStorage());
}
