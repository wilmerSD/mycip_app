import 'package:cip_payment_app/app/ui/components/appbar/custom_appbar.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/views/monthlyfees_mobile.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/monthlyfees_provider.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyfeesView extends StatelessWidget {
  const MonthlyfeesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final monthlyfeesProvider =
            Provider.of<MonthlyfeesProvider>(context, listen: false);
        monthlyfeesProvider.onInit(context);
      });

      return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.backgroundColor(context),
        appBar: const CustomAppBar(
          title: textMonthlyfees,
        ),
        body: const SafeArea(child:  MonthlyfeesMobile())
      );
    });
  }
}

