import 'package:flutter_dotenv/flutter_dotenv.dart';

// String baseUrlPath =  dotenv.env['BASE_URL']!;
// String baseUrlPath =  "https://api.cloudinary.com/v1_1/dqxrv6oct";
String baseUrlPath =  "https://newshopack.onrender.com/api/v1";
const String paymentbaseUrlPath = 'https://accept.paymob.com/api';
const String placesAutocompeleteUrlPath ="https://maps.googleapis.com/maps/api/place/autocomplete/json";
const String placesUrlPath = "https://maps.googleapis.com/maps/api/place/details/json";
const String loginEndPoint = '/users/login';
const String registerEndPoint = '/users/register';
const String forgotPasswordEndPoint = '/users/password/forgot';
const String resetPasswordEndPoint = "/users/password/reset/";
const String profileEndPoint = '/users/me';
const String updateProfileEndPoint = '/users/profile/update';
const String updatePasswordEndPoint = '/users/password/update';
const String productsEndPoint = '/products';
const String reviewEndPoint ='/reviews';
const String getAllReviewsEndPoint ='/product/review';
const String newOrderEndPoint ='/order/new';
const String requestAuthEndPoint ='/auth/tokens';
const String requestOrderEndPoint ='/ecommerce/orders';
const String getAllOrdersEndPoint ='/orders/me';
const String requestPaymentEndPoint ='/acceptance/payment_keys';

String? code;
bool? isSkipedOnBoarding;
bool? isLoggedIN;


const String baseURLAuMall  = "http://45.77.171.218:8080/api";
const String loginAuMall  = "/auth/login";
const String registerAuMall  = "/auth/register";
const String profileAuMall  = "/user";
const String bannerAuMall  = "/banner";
const String homeAuMall  = "/home";
const String categoryAuMall  = "/category";
const String productDetailAuMall  = "/product";
const String allProductsAuMall  = "/products";
const String favoriteProductsAuMall  = "/product-wish-list";
const String searchProductsAuMall  = "/search";
const String shippingAddressAuMall  = "/shipping-address";