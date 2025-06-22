// ignore_for_file: dead_code
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle(this.context);
  final BuildContext context;

  TextStyle titleAppBar({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color, fontWeight: FontWeight.bold, fontFamily: 'Montserrat');

  TextStyle bold26(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 26.0,
          fontFamily: 'Montserrat');

  TextStyle bold24(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 24.0,
          fontFamily: 'Montserrat');
  TextStyle bold23(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 23.0,
          fontFamily: 'Montserrat');
  TextStyle bold22(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 22.0,
          fontFamily: 'Montserrat');
  TextStyle bold21(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 22.0,
          fontFamily: 'Montserrat');
  TextStyle bold20(
          {Color color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.titleLarge!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 22.0,
          fontFamily: 'Montserrat');
  TextStyle bold18(
          {Color? color = Colors.black,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 18.0,
          fontFamily: 'Montserrat');

  TextStyle bold17(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 17.0,
          fontFamily: 'Montserrat');

  TextStyle bold16(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 16.0,
          fontFamily: 'Montserrat');

  TextStyle bold15(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 15.0,
          fontFamily: 'Montserrat');

  TextStyle bold14(
          {Color? color = AppColors.grayDark,
          FontWeight fontWeight = FontWeight.w700}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: fontWeight,
          fontSize: 14.0,
          fontFamily: 'Montserrat');

  TextStyle semi14({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.w500,
          fontSize: 14.0,
          fontFamily: 'Montserrat');

  TextStyle medium14({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
          fontFamily: 'Montserrat');

  TextStyle medium12({
    Color color = AppColors.grayLight,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.w400,
          fontSize: 12.0,
          fontFamily: 'Montserrat');

  TextStyle extra20({Color? color = Colors.black}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          fontFamily: 'Montserrat');

  TextStyle extra22({Color? color = Colors.black}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color,
            fontWeight: FontWeight.w900,
            fontSize: 22.0,
          );

  TextStyle extra14({Color? color = Colors.black}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color,
            fontWeight: FontWeight.w300,
            fontSize: 14.0,
          );

  TextStyle extra16({Color? color = Colors.black}) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          fontFamily: 'Montserrat');

  TextStyle extra40({
    Color? color = Colors.black,
  }) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            fontFamily: 'Montserrat',
          );
}
