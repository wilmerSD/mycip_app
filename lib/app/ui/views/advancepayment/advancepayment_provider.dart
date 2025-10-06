import 'package:cip_payment_app/app/infrastructure/datasources/quotadb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/repositories/quota_repository_impl.dart';
import 'package:cip_payment_app/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_app/app/ui/components/payment/warning_pay.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/helpers/custom_snackbar.dart';
import 'package:cip_payment_app/preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class AdvancepaymentProvider with ChangeNotifier{

  final QuotaRepositoryImpl quotaRepositoryImpl = QuotaRepositoryImpl(QuotadbDatasource());
  bool isGetQuotasPending = false;
  bool haveQuotasPending = true;
  final String symbolMoney = 'S/. ';

  String ctrlValueOfQuota =  'S/. 30.0';
  String ctrlPercentDiscount = '5%';
  String ctrlEnabledUntil = 'Noviembre del 2024';
  String ctrlSubTotal = 'S/. 270';
  String ctrlDiscount = 'S/. 30';
  
  TextEditingController ctrlLastPay = TextEditingController(text:'Agosto de 2024');
  TextEditingController ctrlQuantityCuotas = TextEditingController(text:'12');
  
  TextEditingController ctrlTotal = TextEditingController(text:'S/. 240');


  double totalToPay = 0;
  double valueOfQuota = 30.0;

  Future<void> onInit(BuildContext context) async {
    final personId = PreferencesUser.personId;
    try {
      final response = await quotaRepositoryImpl.hasPendingQuotas(personId);
      haveQuotasPending = response;
      print(haveQuotasPending);
      if (haveQuotasPending) {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return PopupGeneral(
              title: '',
              onTapButton: () {},
              scrollable: true,
              content: const WarningPay('Para poder adelantar cuotas debe pagar su deuda pendiente.'),
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
  int quantityCuotas = 0;
  double discount = 0.0;
  double subTotal = 0.0;
  void calculateToPay(){
    
    quantityCuotas = int.tryParse(ctrlQuantityCuotas.text) ?? 0;
    subTotal = (valueOfQuota * quantityCuotas);
    discount = subTotal * 0.05;
    totalToPay = subTotal - discount;

    ctrlDiscount = symbolMoney+discount.toString();
    ctrlSubTotal = symbolMoney+subTotal.toString();
    notifyListeners();
    }
}