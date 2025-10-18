import 'package:cip_payment_app/app/ui/components/appbar/custom_appbar.dart';
import 'package:cip_payment_app/app/ui/views/advancepayment/advancepayment_provider.dart';
import 'package:cip_payment_app/app/ui/views/advancepayment/views/advancepayment_mobile.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdvancepaymentView extends StatelessWidget {
  const AdvancepaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final certificateSkillProvider =
          Provider.of<AdvancepaymentProvider>(context, listen: false);
      certificateSkillProvider.onInit(context);
    });

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      appBar: const CustomAppBar(title: textAdvancepayment),
      body: const SafeArea(
        child: AdvancepaymentMobile(),
      ),
    );
  }
}
