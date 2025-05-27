import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mawidak/core/base_network/interceptors/request_interceptor.dart';
import 'package:mawidak/core/component/button/p_button.dart';
import 'package:mawidak/core/component/button/p_floating_action_button.dart';
import 'package:mawidak/core/data/constants/app_colors.dart';
import 'package:mawidak/core/data/constants/global_obj.dart';
import 'package:mawidak/core/data/constants/shared_preferences_constants.dart';
import 'package:mawidak/core/extensions/navigator_extensions.dart';
import 'package:mawidak/core/global/enums/global_enum.dart';
import 'package:mawidak/core/global/global_func.dart';
import 'package:mawidak/core/services/local_storage/shared_preference/shared_preference_service.dart';
import 'package:mawidak/core/services/localization/app_localization.dart';
import 'package:mawidak/core/theme/theme.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/core/services/route_manager/router_manager.dart';
import 'package:sizer/sizer.dart';
import 'core/services/notifications/notifications_services.dart';

bool isPickFile = false;

void main() async {
  await AppDependencies().initialize();
  // Init firebase
  // await Firebase.initializeApp();
  // Handle firebase background notifications
  // FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

  // await NotificationsServices.instance.requestPermission();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(
        MaterialApp(title: 'موعدك',
          theme: ThemeData(
            useMaterial3: true,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          darkTheme: ThemeData.dark().copyWith(
            useMaterial3: true,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          themeMode: ThemeMode.system,
          useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          // builder: DevicePreview.appBuilder,
          debugShowCheckedModeBanner: false,
          home: Sizer(
            builder: (p0, p1, p2) {
              return EasyLocalization(
                supportedLocales: AppLocalization.getSupportedLocales,
                fallbackLocale: AppLocalization.fallbackLocale,
                path: AppLocalization.getPath,
                startLocale: AppLocalization.startLocale,
                child: const MyApp(),
              );
            },
          ),
        )
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // setSystemNavigationBarColor();
    return MaterialApp.router(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'IPA',
      // theme: theme,
      // darkTheme:theme, // Dark theme
      // themeMode: ThemeMode.system,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
      // restorationScopeId: 'root',
      // routerDelegate: RouterManager().router.routerDelegate,
      // routeInformationProvider:
      //     RouterManager().router.routeInformationProvider,
      // routeInformationParser:
      //     RouterManager().router.routeInformationParser,
      routerConfig: RouterManager().router,
    );
  }
}
