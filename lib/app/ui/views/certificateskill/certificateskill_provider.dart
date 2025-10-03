import 'package:cip_payment_app/app/infrastructure/datasources/quotadb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/repositories/quota_repository_impl.dart';
import 'package:cip_payment_app/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_app/app/ui/components/payment/warning_pay.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/helpers/custom_snackbar.dart';
import 'package:cip_payment_app/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class CertificateSkillProvider with ChangeNotifier{
  
  TextEditingController ctrlNumberCip = TextEditingController(text: '972 243 232');
  TextEditingController ctrlColegiado = TextEditingController(text: 'José Guevara Martinez');
  TextEditingController ctrlState = TextEditingController(text: 'Activo');
  TextEditingController ctrlEnabledUntil = TextEditingController(text: '31 de Agosto del 2025');
  TextEditingController ctrlNumberCertf = TextEditingController(text: '01');
  TextEditingController ctrlSpecialty = TextEditingController(text: 'Ing. De Sistemas e informática');

  bool haveQuotasPending = true;
  final QuotaRepositoryImpl quotaRepositoryImpl = QuotaRepositoryImpl(QuotadbDatasource());

  Future<void> onInit(BuildContext context) async {
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
              content: WarningPay('Para poder generar tu certificado de habilidad debe pagar su deuda pendiente.'),
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
      notifyListeners();
      // haveQuotasPending = false;
    }
  }
}