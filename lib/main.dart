import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mawidak/core/services/localization/app_localization.dart';
import 'package:mawidak/di.dart';
import 'package:mawidak/core/services/route_manager/router_manager.dart';
import 'package:sizer/sizer.dart';

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
