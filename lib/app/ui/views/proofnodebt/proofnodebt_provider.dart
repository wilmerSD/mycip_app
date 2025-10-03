import 'package:cip_payment_app/app/infrastructure/datasources/quotadb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/repositories/quota_repository_impl.dart';
import 'package:cip_payment_app/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_app/app/ui/components/payment/warning_pay.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/helpers/custom_snackbar.dart';
import 'package:cip_payment_app/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ProofnodebtProvider with ChangeNotifier {
  final QuotaRepositoryImpl quotaRepositoryImpl = QuotaRepositoryImpl(QuotadbDatasource());
  bool isGetQuotasPending = false;
  bool haveQuotasPending = true;

  Future<void> onInit(BuildContext context) async {
    await getPendingQuotas(context);
  }

  Future<void> getPendingQuotas(BuildContext context) async {
    final personId = PreferencesUser.personId;
    try {
      final response = await quotaRepositoryImpl.hasPendingQuotas(personId);
      haveQuotasPending = response;
      if (haveQuotasPending) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return PopupGeneral(
              title: '',
              onTapButton: () {},
              scrollable: true,
              content: const WarningPay(
                'Para poder generar su constancia de no adeudo debe pagar su deuda pendiente.',
              ),
            );
          },
        );
      }
    } catch (e) {
        CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Error',
        message: kmessageErrorGeneral,
        type: 2,
        time: 2,
      );
    } finally {
      // haveQuotasPending = false;
    }
  }
}
