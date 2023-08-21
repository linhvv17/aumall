import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../core/local/shared_preference.dart';
import '../core/theme/theme_service.dart';
import '../dependancy_injection.dart';
import '../features/cart/data/datasource/local_datasource.dart';
import '../features/profile/data/datasources/profile_local_datasource.dart';
import '../local_notification_service.dart';
import 'app_flavor.dart';

// final _lastInteractionTime = DateTime.now().obs;

Future<void> configMain(Flavor flavor) async {
  WidgetsFlutterBinding.ensureInitialized();


  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await PreferenceHelper.init();
  await Hive.initFlutter();
  await CacheManager().init();
  await CartLocalDataSourceManager().init();
  await ThemeDatabaseService.checkDatabaseExists();
  // await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  await LocalNotificationService().setup();

  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await FlavorConfig.setup(flavor);

  /// init firebase notification background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  ///add firebase crashlytics
  _firebaseCrashlytics();

  ///
  /// check time log out
  Timer.periodic(const Duration(seconds: 10), (timer) {

  });
}

Future<void> _firebaseMessagingBackgroundHandler(
  RemoteMessage message,
) async {
  _handleOnTapNotification(message.data);
}

void _handleOnTapNotification(Map<String, dynamic> data) {
}


/// config firebase crashlytics
void _firebaseCrashlytics() {
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
