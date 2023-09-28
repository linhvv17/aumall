import 'package:aumall/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/local/shared_preference.dart';
import 'core/theme/bloc/theme_bloc.dart';
import 'core/utilities/endpoints.dart';
import 'core/utilities/router.dart';
import 'core/utilities/routes.dart';
import 'app/di/dependancy_injection.dart';
import 'features/auction/presentation/bloc/auction_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/cart/presentation/bloc/cubit/address_cubit.dart';
import 'features/cart/presentation/bloc/location_bloc.dart';
import 'features/favorite/presentation/bloc/favourite_bloc.dart';
import 'features/forgotpass&verifyemail/presentation/forgotpass&verifyemail_bloc/forgotpass&verifyemail_bloc.dart';
import 'features/home/presentation/bloc/bottom_nav/bottomNavigationBar_bloc.dart';
import 'features/home/presentation/bloc/home_bloc/home_bloc.dart';
import 'features/home/presentation/bloc/product_detail_bloc/product_detail_bloc.dart';
import 'features/login/presentation/bloc/login_bloc.dart';
import 'features/payment/presentation/bloc/order_bloc.dart';
import 'features/payment/presentation/bloc/payment_bloc.dart';
import 'features/profile/presentation/bloc/profile_bloc.dart';
import 'features/profile/presentation/bloc/update_password_bloc.dart';
import 'features/register/presentation/bloc/register_bloc.dart';
import 'features/setpassword/presentation/bloc/reset_password_bloc.dart';
import 'features/shop_profile/presentation/bloc/shop_profile_bloc.dart';
import 'features/shopping/presentation/bloc/products_bloc.dart';
import 'features/shopping/presentation/bloc/send_review_bloc.dart';
import 'generated/l10n.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<void> setupInteractedMessage() async {

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (kDebugMode) {
      print('User granted permission: ${settings.authorizationStatus}');
    }
    final fcmToken = await FirebaseMessaging.instance.getToken();
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    if (kDebugMode) {
      print("FCMToken $fcmToken");
    }

    _handleAndroidFCMWhenOpenApp();

  }

  void _handleAndroidFCMWhenOpenApp() async {
    //Create a new AndroidNotificationChannel instance:
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.', // description
      importance: Importance.max,
    );

    //Create the channel on the device (if a channel with an id already exists, it will be updated):
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // If `onMessage` is triggered with a notification, construct our own
      // local notification to show to users using the created channel.
      if (notification != null && android != null) {
        // Navigator.pushNamed(context, AppRoutes.register);
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                icon: android.smallIcon,
                // other properties...
              ),
            ));
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  }


  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector<LoginBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<ProductDetailBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<RegisterBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<ForgetpasswordAndeVerifyEmailBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<ResetPasswordBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<BottomNavigationBarBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<ProductsBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<ShopProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<ProfileBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<UpdatePasswordBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<SendReviewBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<AuctionBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<FavouriteBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<CartBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<LocationBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<AddressCubit>(),
        ),
        BlocProvider(
          create: (context) => injector<PaymentBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<OrderBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<ThemeBloc>(),
        ),
        BlocProvider(
          create: (context) => injector<NotificationBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          isSkipedOnBoarding = PreferenceHelper.getDataFromSharedPreference(
              key: 'IsSkippedOnBoarding');
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: state.themeData,
            onGenerateRoute: onGenerate,
            initialRoute: isSkipedOnBoarding != null
                ? AppRoutes.splash
                : AppRoutes.onBoarding,

            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        },
      ),
    );
  }
}