import 'package:cip_payment_app/app/ui/components/appbar/custom_appbar.dart';
import 'package:cip_payment_app/app/ui/views/proofnodebt/proofnodebt_provider.dart';
import 'package:cip_payment_app/app/ui/views/proofnodebt/views/proofnodebt_view_mobile.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProofnodebtView extends StatelessWidget {
  const ProofnodebtView({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final proofnodebtProvider = Provider.of<ProofnodebtProvider>(
        context,
        listen: false,
      );
      proofnodebtProvider.onInit(context);
    });

    return Scaffold(
        backgroundColor: AppColors.backgroundColor(context),
        appBar: const CustomAppBar(
          title: textProofnodebt,
        ),
        body: const SafeArea(child:  ProofnodebtViewMobile()));
  }
}
