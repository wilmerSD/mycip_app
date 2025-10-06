import 'dart:convert';
import 'dart:io';
import 'package:cip_payment_app/app/domain/entities/deviceinfo.dart';
import 'package:cip_payment_app/app/domain/entities/enums.dart';
import 'package:cip_payment_app/app/domain/entities/quota.dart';
import 'package:cip_payment_app/app/domain/entities/storepay.dart'
    hide LocationPay;
import 'package:cip_payment_app/app/domain/entities/token.dart';
import 'package:cip_payment_app/app/infrastructure/datasources/paymentdb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/datasources/quotadb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/models/quota_model.dart';
import 'package:cip_payment_app/app/infrastructure/models/response/payment_quota_model.dart';
import 'package:cip_payment_app/app/infrastructure/repositories/payment_repository_impl.dart';
import 'package:cip_payment_app/app/infrastructure/repositories/quota_repository_impl.dart';
import 'package:cip_payment_app/app/providers/infodevice_provider.dart';
import 'package:cip_payment_app/app/ui/components/alert/popup_checkout.dart';
import 'package:cip_payment_app/app/ui/components/payment/payment_bad.dart';
import 'package:cip_payment_app/app/ui/components/payment/payment_good.dart';
import 'package:cip_payment_app/app/ui/components/toast/toast.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/widgets/culqi_checkout.dart';
import 'package:cip_payment_app/core/config/environment.dart';
import 'package:cip_payment_app/core/helpers/constant.dart';
import 'package:cip_payment_app/core/helpers/custom_snackbar.dart';
import 'package:cip_payment_app/core/helpers/generate_receipt.dart';
import 'package:cip_payment_app/core/helpers/helpers.dart';
import 'package:cip_payment_app/preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MonthlyfeesProvider with ChangeNotifier {
  final QuotaRepositoryImpl quotaRepositoryImpl = QuotaRepositoryImpl(
    QuotadbDatasource(),
  );
  final PaymentRepositoryImpl paymentRepositoryImpl = PaymentRepositoryImpl(
    PaymentdbDatasource(),
  );

  Future<void> onInit(BuildContext context) async {
    selectTab(0);
    getInfoDevice(context);
    await getDataPerson(context);
    fetchPendingPay(context);
    await getHistoryPayment(context);
  }

  Future<void> getDataPerson(BuildContext context) async {
    personId = PreferencesUser.personId;
    mainEmail = PreferencesUser.mainEmail;
    print(personId);
    print(mainEmail);
  }
  String rucId = '';
  String mainEmail = '';
  String personId = '';
  String variablePrueba = 'hola id';
  
  final PageController pageController = PageController();
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  double amoutToPay = 0;

  TextEditingController ctrlCardNumber = TextEditingController(
    text: '4111111111111111',
  );
  TextEditingController ctrlCvv = TextEditingController(text: '123');
  TextEditingController ctrlExpirationMonth = TextEditingController(text: '12');
  TextEditingController ctrlExpirationYear = TextEditingController(
    text: '2030',
  );
  TextEditingController ctrlEmail = TextEditingController(
    text: 'review@culqi.com',
  );
  List<Storepay> paymentHistoryQuotas = [];
  bool isGettinHistory = false;
  double amount = 1000.0;
  Token tokenCreate = Token();

  //Crea el token y envia solicitud de pago createToken
  Future<void> payMonthlyFees() async {
    final response = await paymentRepositoryImpl.createTokenCulqi(
      cardNumber: ctrlCardNumber.text,
      cvv: ctrlCvv.text,
      expirationMonth: ctrlExpirationMonth.text,
      expirationYear: ctrlExpirationYear.text,
      email: ctrlEmail.text,
    );

    if (response != null) {
      debugPrint(response.toString());
      tokenCreate = response;
      paymentRepositoryImpl.payCulqi(
        tokenCreate.id!,
        Helpers.toCents(amount),
        ctrlEmail.text,
      ); // Enviar este token a tu backend para crear el cargo
    } else {
      // Mostrar error al usuario
    }
  }

  //Pagar v1 pagar
  // Future<void> payMonthlyFeesv1(BuildContext context) async {
  //   await generateReceipt(
  //     receiptNumber: 'prueba',
  //     date: '07/09/25',
  //     name: 'JOSE WILMER SANCHEZ DIAZ',
  //     dni: '70833688',
  //     subtotal: 25,
  //     igv: 12,
  //     total: 280,
  //   );
  //   debugPrint('tratando de generar recibo');
  //   final token = await paymentRepositoryImpl.createTokenCulqi(
  //     cardNumber: ctrlCardNumber.text,
  //     cvv: ctrlCvv.text,
  //     expirationMonth: ctrlExpirationMonth.text,
  //     expirationYear: ctrlExpirationYear.text,
  //     email: ctrlEmail.text,
  //   );
  //   if (token != null) {
  //     final response = await paymentRepositoryImpl.payCulqi(
  //       token.id!,
  //       Helpers.toCents(amount),
  //       ctrlEmail.text,
  //     ); // Enviar este token a tu backend para crear el cargo
  //     if (response != null) {
  //       //TODO verificar si el pago fue exitoso o no
  //       Navigator.pop(context);
  //       CustomSnackbar.showSnackBarCustom(
  //         context,
  //         title: 'Éxito',
  //         message: 'El pago se realizo correctamente',
  //         type: 3,
  //         time: 2,
  //       );
  //     } else {
  //       CustomSnackbar.showSnackBarCustom(
  //         context,
  //         title: 'Validar',
  //         message: 'Ups...Ocurrio un error, intente nuevamente',
  //         type: 2,
  //         time: 2,
  //       );
  //     }
  //   }
  // }

  Future<String?> crearTokenCulqi() async {
    final uri = Uri.parse("https://api.culqi.com/v2/tokens");
    final client = HttpClient();

    final req = await client.postUrl(uri);
    req.headers.set('Content-Type', 'application/json');
    req.headers.set('Authorization', 'Bearer pk_test_sKWDD6bVub17VOqt');

    req.add(
      utf8.encode(
        json.encode({
          "card_number": ctrlCardNumber.text,
          "cvv": ctrlCvv.text,
          "expiration_month": ctrlExpirationMonth.text,
          "expiration_year": ctrlExpirationYear.text,
          "email": ctrlEmail.text,
        }),
      ),
    );

    final res = await req.close();
    final body = await res.transform(utf8.decoder).join();
    client.close();

    if (res.statusCode == 201) {
      final data = json.decode(body);
      print(data['id']);
      return data['id'];
    } else {
      print("Error creando token (HttpClient): $body");
      return null;
    }
  }

  void selectTab(int index) {
    _selectedIndex = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  void onPageChanged(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  List<Quota> listQuotas = [];
  bool isGettingPendingPay = true;

  Future<void> fetchPendingPay(BuildContext context) async {
    debugPrint('get cuotas pendientes');
    isGettingPendingPay = true;
    listQuotas.clear();
    try {
      final response = await quotaRepositoryImpl.fetchQuotasByPerson(personId);
      listQuotas.addAll(response);
      listQuotas.sort((a, b) => (a.feeMonth ?? 0).compareTo(b.feeMonth ?? 0));
      toggleSelectAll();
    } catch (e) {
      showToastGlobal(
        context,
        1,
        "error",
        "Ocurrio un error al tratar de optener sus cuotas pendientes. Detalles: $e",
      );
    } finally {
      isGettingPendingPay = false;
      notifyListeners();
    }
  }

  void togglePaid(int index, bool value) {
    if (value) {
      // ✅ Si quiere marcar, primero aseguramos que todas las anteriores estén marcadas
      for (int i = 0; i <= index; i++) {
        listQuotas[i].isSelected = true;
      }
    } else {
      // ❌ Si quiere desmarcar, también desmarcamos todas las posteriores
      for (int i = index; i < listQuotas.length; i++) {
        listQuotas[i].isSelected = false;
      }
    }
    notifyListeners();
  }

  //   double get totalSelected {
  //   return listQuotas
  //       .where((q) => q.isSelected)
  //       .fold(0.0, (sum, q) => sum + q.amount );
  // }
  double get totalSelected {
    return listQuotas
        .where((q) => q.isSelected)
        .fold(0.0, (totalsum, q) => totalsum + (q.amount ?? 0));
  }

  bool get allSelected =>
      listQuotas.isNotEmpty && listQuotas.every((q) => q.isSelected);

  void toggleSelectAll() {
    final allSelected = listQuotas.every((q) => q.isSelected);
    for (var quota in listQuotas) {
      quota.isSelected = !allSelected;
    }
    notifyListeners();
  }

  Future<void> getHistoryPayment(BuildContext context) async {
    paymentHistoryQuotas.clear();
    isGettinHistory = true;
    print(personId);
    try {
      final response =
          await paymentRepositoryImpl.historyPaymentQuotas(personId, PaymentType.monthlyFees.code);
      if (response == null) {
        return;
      }
      paymentHistoryQuotas.addAll(response);
      paymentHistoryQuotas.sort((a, b) => (b.feeMonth ?? 0).compareTo(a.feeMonth ?? 0));
      
    } catch (e) {
      CustomSnackbar.showSnackBarCustom(
        context,
        title: 'Error',
        message: kmessageErrorGeneral,
        type: 2,
        time: 2,
      );
      debugPrint(e.toString());
    } finally {
      isGettinHistory = false;
      notifyListeners();
    }
  }

  Future<void> openCheckout(BuildContext context) async {
    // Navigator.of(context).pop();
    debugPrint(totalSelected.toString());
    final int amountRound = Helpers.toCents(totalSelected);
    final token = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return PopupCheckout(
            onTapButton: () {},
            content: CulqiCheckout(
              publicKey: Environment.publicKeyCulqi,
              amount: amountRound,
              currency: 'PEN',
              email: 'culqitest@gmail.com',
            ),
          );
        });
    // print("TOKEN RECIBIDO: $token");
    if (token != null) {
      showDialog(
        context: context,
        barrierDismissible: false, 
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      debugPrint(token);
      final payCompleted = await paymentRepositoryImpl.payCulqi(
        token,
        amountRound,
        mainEmail,
      );
      Navigator.of(context).pop(); // cierra el loader
      if (payCompleted != null) {
        if (payCompleted.succces) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return PopupCheckout(
                title: '',
                onTapButton: () {},
                scrollable: false,
                content: PaymentGood(
                  payCompleted.creationDate ?? 0,
                  totalSelected,
                  textMonthlyfees,
                ),
              );
            },
          );
          if (deviceInfo != null){

          }
          List<PaymentQuotaModel> paymentQuotaModels = listQuotas
              .where((q) => q.isSelected) // 1. Solo las cuotas seleccionadas
              .map(
                (q) => PaymentQuotaModel(
                  creationDatePay: Timestamp.fromDate(DateTime.now()),
                  deviceInfoPay: deviceInfo?.nameDevice ?? '',
                  ipAddressPay: deviceInfo?.ip ?? '',
                  locationCityPay: deviceInfo?.nameCity ?? '',
                  locationCountryPay: deviceInfo?.nameCountry ?? '',
                  locationPay: GeoPoint( deviceInfo?.latitude ?? 0.0, deviceInfo?.longitude ?? 0),
                  paymentState: true,
                  paymentValue: q.amount?.toDouble() ?? 0.0,
                  personId: personId,
                  platformPayment: PlatformPayment.app.name,
                  quantityPayment: q.amount,
                  receiptType: ReceiptType.bill.code,
                  typePay: PaymentType.monthlyFees.code,
                  paymentChannel: PaymentChannel.online.code,
                  rucId: rucId,
                  feeMonth: q.feeMonth ?? 0,
                  feeYear: q.feeYear ?? 0,
                ),
              )
              .toList();
          await paymentRepositoryImpl.payQuotas(paymentQuotaModels);

          List<QuotaModel> quotaModel = listQuotas
              .where((q) => q.isSelected) // 1. Solo las cuotas seleccionadas
              .map(
                (q) => QuotaModel(
                  id: q.id ?? '',
                  personId: q.personId ?? '',
                  isSelected: q.isSelected,
                ),
              )
              .toList();

          await quotaRepositoryImpl.updateQuotas(quotaModel);
          fetchPendingPay(context);
        } else {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return PopupCheckout(
                title: '',
                onTapButton: () {},
                scrollable: false,
                content: PaymentBad(
                  Helpers.generateRandomOperationNumber(),
                  Helpers.formatCustomDate(payCompleted.creationDate),
                  payCompleted.userMessage ?? '',
                ),
              );
            },
          );
        }
      }
    }
  }

  Future<void> getReceipt(
    String receiptNumber,
    String date,
    String name,
    String dni,
    double subtotal,
  ) async {
    final igv =subtotal * 0.18;
    await generateReceipt(
        receiptNumber: receiptNumber,
        date: date,
        name: name,
        dni: dni,
        subtotal: subtotal - igv,
        igv: igv,
        total: subtotal);
  }

  
  DeviceInfo? deviceInfo;
  void getInfoDevice(context) async{
    deviceInfo = await Provider.of<InfodeviceProvider>(context, listen: false).deviceInfo();
    print(deviceInfo);
  }
  void prueba(BuildContext context) async {
    print('object');
    print(rucId);
  /*   showDialog(
      context: context,
      builder: (BuildContext context) {
        return PopupCheckout(
          title: '',
          onTapButton: () {},
          scrollable: false,
          content: const PaymentGood(
            0,
            30,
            textMonthlyfees,
          ),
        );
      },
    ); */
     
  }
  // void prueba(){
  //   for ( var quota in listQuotas){
  //     print(quota.id); 
  //   }
  // }
}
