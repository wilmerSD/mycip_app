import 'package:cip_payment_app/app/providers/auth_provider.dart';
import 'package:cip_payment_app/app/routes/app_routes_name.dart';
import 'package:cip_payment_app/app/ui/views/advancepayment/advancepayment_view.dart';
import 'package:cip_payment_app/app/ui/views/certificateskill/certificateskill_view.dart';
import 'package:cip_payment_app/app/ui/views/home/home_view.dart';
import 'package:cip_payment_app/app/ui/views/login/login_view.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/monthlyfees_view.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/myprofile_view.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/widgets/personal_college.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/widgets/personal_contact.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/widgets/personal_data.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/widgets/reset_pass.dart';
import 'package:cip_payment_app/app/ui/views/proofnodebt/proofnodebt_view.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/recover_pass_code.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/recover_pass_email.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/recover_pass_reset.dart';
import 'package:cip_payment_app/app/ui/views/splash/splash_view.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// 🌍 Configuración de go_router
final GoRouter appRouter = GoRouter(
  initialLocation: '/', // AppRoutesName.SPLASH, // tu pantalla inicial
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashView()),
    GoRoute(
      path: AppRoutesName.LOGIN,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: AppRoutesName.HOME,
      builder: (context, state) => const HomeView(),
    ),

    GoRoute(
      path: AppRoutesName.PROFILE,
      builder: (context, state) => const MyprofileView(),
    ),
    GoRoute(
      path: AppRoutesName.PERSONALDATA,
      builder: (context, state) => const PersonalData(),
    ),
    GoRoute(
      path: AppRoutesName.PERSONALCONTACT,
      builder: (context, state) => const PersonalContact(),
    ),
    GoRoute(
      path: AppRoutesName.PERSONALCOLLEGE,
      builder: (context, state) => const PersonalCollege(),
    ),

    GoRoute(
      path: AppRoutesName.RESETPASS,
      builder: (context, state) => const ResetPass(),
    ),
  
    GoRoute(
      path: AppRoutesName.RECOVERPASS,
      builder: (context, state) =>
          const RecoverPasswordEmail(), // la pantalla inicial
      routes: [
        GoRoute(
          path: AppRoutesName.RECOVERPASSCODE,
          builder: (context, state) => const RecoverPassCode(),
        ),
        GoRoute(
          path: AppRoutesName.RECOVERPASSNEW,
          builder: (context, state) => const RecoverPassReset(),
        ),
      ],
    ),

    //Pagos
    GoRoute(
      path: AppRoutesName.MONTHLYFEES,
      builder: (context, state) => const MonthlyfeesView(),
    ),
    GoRoute(
      path: AppRoutesName.CERTIFICATESKILL,
      builder: (context, state) => const CertificateSkillView(),
    ),
    GoRoute(
      path: AppRoutesName.PROOFNODEBT,
      builder: (context, state) => const ProofnodebtView(),
    ),
    GoRoute(
      path: AppRoutesName.ADVANCEPAYMENT,
      builder: (context, state) => const AdvancepaymentView(),
    ),
    //Vista de pago realizado
  /*   GoRoute(
      path: AppRoutesName.PAYMENTGOOD,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final double amount = extra?['amount'] as double? ?? 0;
        final String title = extra?['title'] as String? ?? '';
        final int operationId = extra?['operationId'] as int? ?? 0;
        final String dateTime = extra?['dateTime'] as String? ?? '';
        return PaymentGood(operationId, dateTime, amount, title);
      },
    ),
    GoRoute(
      path: AppRoutesName.PAYMENTBAD,
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        final int operationId = extra?['operationId'] as int? ?? 0;
        final String dateTime = extra?['dateTime'] as String? ?? '';
        final String detailError = extra?['detailError'] as String? ?? '';
        return PaymentBad(operationId, dateTime, detailError);
      },
    ), */

    // GoRoute(
    //   path: '/profile/:id',
    //   builder: (context, state) {
    //     final id = state.pathParameters['id']!;
    //     return ProfileView(id: id);
    //   },
    // ),
  ],
  redirect: (context, state) {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    // 🔹 Mientras carga, no redirijas nada
    if (auth.isLoading) return null;

    final loggedIn = auth.isLoggedIn;
    final loggingIn = state.uri.path == AppRoutesName.LOGIN; //'/login';

    // Si no está logueado y no está en /login -> redirigir a login
    if (!loggedIn && !loggingIn) return AppRoutesName.LOGIN; //'/login';

    // Si ya está logueado y está en /login -> mandarlo a home
    if (loggedIn && loggingIn) return AppRoutesName.HOME; //'/home';

    // Dejar pasar
    return null;
  },
);
