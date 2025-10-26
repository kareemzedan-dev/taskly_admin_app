import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:taskly_admin/core/di/di.dart';
import 'package:taskly_admin/core/helper/my_bloc_observer.dart';
import 'package:taskly_admin/core/cache/shared_preferences.dart';
import 'package:taskly_admin/config/theme/app_theme.dart';
import 'package:taskly_admin/config/routes/routes_manager.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import 'core/cache/language_notifier.dart';
import 'core/services/firebase_notification_service.dart';
import 'core/utils/constants_manager.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Supabase initialization
  await Supabase.initialize(
    url: ConstantsManager.supabaseUrl,
    anonKey: ConstantsManager.anonKey,
  );

  // SharedPreferences
  await SharedPrefHelper.init();

  // Dependency Injection
  configureDependencies();

  // Bloc Observer
  Bloc.observer = MyBlocObserver();

  // FCM setup
  FirebaseMessaging messaging = FirebaseMessaging.instance;

// طلب صلاحيات الإشعارات
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

// تسجيل listener للإشعارات وهي في foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("📩 Foreground notification received: ${message.notification?.title}");
    // هنا ممكن تعرض alert أو dialog
  });

// listener عند الضغط على الإشعار (app background/terminated)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("📩 Notification clicked: ${message.data}");
    // ممكن توجه المستخدم لصفحة معينة
  });
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseNotificationService.initializeLocalNotifications();
  await FirebaseNotificationService.initializeFCM();



  // Language setup
  final savedLanguageCode = SharedPrefHelper.getString('language_code') ?? 'en';
  final languageNotifier = LanguageNotifier(Locale(savedLanguageCode));

  runApp(
    ChangeNotifierProvider<LanguageNotifier>.value(
      value: languageNotifier,
      child: const AdminAppWrapper(),
    ),
  );
}

class AdminAppWrapper extends StatelessWidget {
  const AdminAppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageNotifier>(
      builder: (context, languageNotifier, child) {
        return AdminApp(initialLocale: languageNotifier.value);
      },
    );
  }
}

class AdminApp extends StatelessWidget {
  final Locale initialLocale;
  const AdminApp({super.key, required this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 851),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: initialLocale,
          theme: AppTheme.lightTheme,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('ar'), Locale('en')],
          onGenerateRoute: RoutesManager.onGenerateRoute,
          initialRoute: RoutesManager.splash,
        );
      },
    );
  }
}
