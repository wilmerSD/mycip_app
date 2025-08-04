import 'package:cip_payment_app/app/ui/views/home/home_view.dart';
import 'package:cip_payment_app/app/ui/views/iepi/detail_course.dart';
import 'package:cip_payment_app/app/ui/views/iepi/iepi_view.dart';
import 'package:cip_payment_app/app/ui/views/login/login_view.dart';
import 'package:cip_payment_app/app/ui/views/manteiners/person/person_view.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/myprofile_view.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/recoverpass_view.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/recover_pass_code.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/recover_pass_email.dart';
import 'package:cip_payment_app/app/ui/views/splash/splash_view.dart';
import 'package:cip_payment_app/routes/app_routes_name.dart';
import 'package:go_router/go_router.dart';

/// 🌍 Configuración de go_router
final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),

    GoRoute(
      path: AppRoutesName.LOGIN,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      path: AppRoutesName.HOME,
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: AppRoutesName.PERSON,
      builder: (context, state) => const PersonView(),
    ),
    GoRoute(
      path: AppRoutesName.PROFILE,
      builder: (context, state) => const MyprofileView(),
    ),
    GoRoute(
      path: AppRoutesName.IEPI,
      builder: (context, state) => const IepiView(),
    ),

    GoRoute(
      path: AppRoutesName.DETAILCOURSE,
      builder: (context, state) => const DetailCourse(),
    ),

    GoRoute(
      path: AppRoutesName.RECOVERPASS,
      builder: (context, state) =>
          const RecoverPasswordEmail(), // la pantalla inicial
      routes: [
        GoRoute(
          path: AppRoutesName.RECOVERPASSEMAIL,
          builder: (context, state) => const RecoverPassCode(),
        ),
        GoRoute(
          path: AppRoutesName.RECOVERPASSNEW,
          builder: (context, state) => const RecoverpassView(),
        ),
      ],
    ),

    // GoRoute(
    //   path: '/profile/:id',
    //   builder: (context, state) {
    //     final id = state.pathParameters['id']!;
    //     return ProfileView(id: id);
    //   },
    // ),
  ],
);
