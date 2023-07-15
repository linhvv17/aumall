import 'package:aumall/features/profile/presentation/views/address.dart';
import 'package:aumall/features/profile/presentation/views/address_list.dart';
import 'package:aumall/features/shop/presentation/views/shop.dart';
import 'package:flutter/material.dart';
import 'package:aumall/features/cart/presentation/views/checkout.dart';
import 'package:aumall/features/payment/domain/entities/all_orders_entity.dart';
import 'package:aumall/features/payment/presentation/views/payment.dart';
import 'package:aumall/features/payment/presentation/views/success.dart';
import 'package:aumall/features/profile/presentation/views/order_details.dart';
import 'package:aumall/features/profile/presentation/views/orders.dart';
import 'package:aumall/features/splash&onboarding/presentation/views/onBoarding.dart';
import 'package:aumall/features/splash&onboarding/presentation/views/splash.dart';
import '../../features/cart/presentation/views/map_screen.dart';
import '../../features/forgotpass&verifyemail/presentation/views/forgotpassword.dart';
import '../../features/home/presentation/view/home.dart';
import '../../features/home/presentation/view/layout.dart';
import '../../features/home/presentation/view/product_details.dart';
import '../../features/login/presentation/view/login.dart';
import '../../features/profile/domain/entities/profile_entity.dart';
import '../../features/profile/presentation/views/updatePass.dart';
import '../../features/profile/presentation/views/updateprofile.dart';
import '../../features/register/presentation/views/register.dart';
import '../../features/setpassword/presentation/views/setpassword.dart';
import '../../features/shop/domain/entities/products_entity.dart';
import '../../features/shop/presentation/views/reviews.dart';
import 'routes.dart';

Route<dynamic> onGenerate(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.splash:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case AppRoutes.onBoarding:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case AppRoutes.login:
      return MaterialPageRoute(builder: (context) => const LoginView());
    case AppRoutes.register:
      return MaterialPageRoute(builder: (context) => const RegisterView());
    case AppRoutes.forgotPassword:
      return MaterialPageRoute(builder: (context) => const ForgotPassword());
    case AppRoutes.setPassword:
      return MaterialPageRoute(builder: (context) => const SetPassword());
    case AppRoutes.layout:
      return MaterialPageRoute(builder: (context) => const LayoutPage());
    case AppRoutes.home:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case AppRoutes.shop:
      return MaterialPageRoute(builder: (context) => const ShopView());
    case AppRoutes.productDetails:
      final product = settings.arguments as ProductAuMallEntity;
      final products = settings.arguments as List<ProductEntity>;
      final index = settings.arguments as int;
      return MaterialPageRoute(
          builder: (context) => ProductDetails(
                productSimpleEntity: product,
                // products: products,
                index: index,
              ));
    case AppRoutes.productReviews:
      final product = settings.arguments as ProductEntity;
      return MaterialPageRoute(
          builder: (context) => ReviewsView(product: product));
    case AppRoutes.updateProfile:
      final user = settings.arguments as UserEntity;
      return MaterialPageRoute(
          builder: (context) => UpdateProfileView(
                user: user,
              ));
    case AppRoutes.checkout:
      return MaterialPageRoute(builder: (context) => const AddNewAddressView());
    case AppRoutes.updatePassword:
      return MaterialPageRoute(
          builder: (context) => const UpdatePasswordView());
    case AppRoutes.mapview:
      return MaterialPageRoute(builder: (context) => const MapView());
    case AppRoutes.payment:
      return MaterialPageRoute(builder: (context) => const Payment());
    case AppRoutes.success:
      return MaterialPageRoute(builder: (context) => const SuccessView());
    case AppRoutes.orders:
      return MaterialPageRoute(builder: (context) => const OrdersView());
    case AppRoutes.addressList:
      return MaterialPageRoute(builder: (context) => const AddressListView());
    case AppRoutes.address:
      return MaterialPageRoute(builder: (context) => const AddressView());
    case AppRoutes.orderDetails:
      final order = settings.arguments as AllOrderEntity;
      return MaterialPageRoute(
          builder: (context) => OrderDetailsView(order: order));
    default:
      return MaterialPageRoute(builder: (context) => const LoginView());
  }
}
