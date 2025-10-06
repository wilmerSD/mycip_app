import 'package:cip_payment_app/app/providers/auth_provider.dart';
import 'package:cip_payment_app/app/providers/infodevice_provider.dart';
import 'package:cip_payment_app/app/providers/reciept_provider.dart';
import 'package:cip_payment_app/app/routes/go_router_app.dart';
import 'package:cip_payment_app/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_app/app/ui/views/certificateskill/certificateskill_provider.dart';
import 'package:cip_payment_app/app/ui/views/iepi/iepi_provider.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/myprofile_provider.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/recoverpass_provider.dart';
import 'package:cip_payment_app/core/config/theme_app.dart';
import 'package:cip_payment_app/preferences/shared_preferences.dart';
import 'package:cip_payment_app/preferences/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Necesario para inicializar dependencias antes de runApp()
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 
  await PreferencesUser.init();
  await initializeDateFormatting("ES", null);
  await dotenv.load(fileName: '.env');
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyprofileProvider()),
        ChangeNotifierProvider(create: (_) => MonthlyfeesProvider()),
        ChangeNotifierProvider(create: (_) => CertificateSkillProvider()),
        ChangeNotifierProvider(create: (_) => RecoverPassProvider()),
        ChangeNotifierProvider(create: (_) => IepiProvider()),
        ChangeNotifierProvider(create: (_) => AdvancepaymentProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => RecieptProvider()),
        ChangeNotifierProvider(create: (_) => InfodeviceProvider()),
        // ChangeNotifierProvider(create: (_) => BillProvider()),
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
        builder: (context, child) => MaterialApp.router(
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
              routerConfig: appRouter, 
            ));
  }
}
