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
import 'package:taskly_admin/core/services/notification_service.dart';
import 'package:taskly_admin/core/utils/constants_manager.dart';
import 'package:taskly_admin/core/utils/strings_manager.dart';
import 'package:taskly_admin/l10n/app_localizations.dart';
import 'core/cache/language_notifier.dart';
import 'core/services/firebase_notification_service.dart';

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

  // Local notifications + FCM setup
  await FirebaseNotificationService.initializeLocalNotifications();
  await FirebaseNotificationService.initializeFCM();

  // SharedPreferences
  await SharedPrefHelper.init();

  // Dependency Injection
  configureDependencies();

  // Bloc Observer
  Bloc.observer = MyBlocObserver();

  // FCM Token
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.requestPermission();
  final fcmToken = await messaging.getToken();
  print("FCM Token: $fcmToken");
  NotificationService().sendNotification(receiverId: "649db31e-c0d0-4aaa-83b4-a3431192a2ac", title: "ادمن2", body: "مرحبا انا ادمن ");


  final supabase = Supabase.instance.client;
  final adminId = SharedPrefHelper.getString(StringsManager.idKey); // تأكد انك مخزن الـ admin id
  if (adminId != null && fcmToken != null) {
    await supabase.from('admins').upsert(
      {
        'id': adminId,
        'fcm_token': fcmToken,
      },
      onConflict: 'id',
    );
  }


  // Language setup
  final savedLanguageCode =
      SharedPrefHelper.getString('language_code') ?? 'en';
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
