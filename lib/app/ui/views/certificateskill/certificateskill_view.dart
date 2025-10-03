import 'package:cip_payment_app/app/ui/components/appbar/custom_appbar.dart';
import 'package:cip_payment_app/app/ui/views/certificateskill/views/certificateskill_view_mobile.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CertificateSkillView extends StatelessWidget {
  const CertificateSkillView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor(context),
        appBar: const CustomAppBar(title: textCertificateskill),
        body: const SafeArea(child: CertificateskillViewMobile()));
  }
}
