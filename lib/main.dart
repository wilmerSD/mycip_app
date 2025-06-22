import 'package:cip_payment_app/app/ui/views/certificateskill/certificateskill_controller.dart';
import 'package:cip_payment_app/app/ui/views/home/home_controller.dart';
import 'package:cip_payment_app/app/ui/views/login/login_controller.dart';
import 'package:cip_payment_app/app/ui/views/login/login_view.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/monthlyfees_controller.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/myprofile_controller.dart';
import 'package:cip_payment_app/app/ui/views/splash/splash_controller.dart';
import 'package:cip_payment_app/app/ui/views/splash/splash_view.dart';
import 'package:cip_payment_app/core/config/theme_app.dart';
import 'package:cip_payment_app/preferences/shared_preferences.dart';
import 'package:cip_payment_app/preferences/theme_provider.dart';
import 'package:cip_payment_app/routes/app_routes_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding
      .ensureInitialized(); // Necesario para inicializar dependencias antes de runApp()
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PreferencesUser.init();
  await initializeDateFormatting("ES", null);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SplashController()),
        ChangeNotifierProvider(create: (_) => LoginController()),
        ChangeNotifierProvider(create: (_) => HomeController()),
        ChangeNotifierProvider(create: (_) => MyprofileController()),
        ChangeNotifierProvider(create: (_) => MonthlyfeesController()),
        ChangeNotifierProvider(create: (_) => CertificateSkillController()),
        
        ChangeNotifierProvider(
            create: (_) =>
                ThemeProvider(darkMode: PreferencesUser().themeBool)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application. MaterialApp
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844) /* ScreenUtil.defaultSize */,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) => MaterialApp(
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  DefaultWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('es', 'ES'), // Español
                  Locale('en', 'US'), // Inglés
                ],
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeApp(
                        darkMode:
                            Provider.of<ThemeProvider>(context, listen: true)
                                .themeDark)
                    .getTheme(),
                routes: AppRoutes.routes,
                home: const LoginView()));
  }
}
