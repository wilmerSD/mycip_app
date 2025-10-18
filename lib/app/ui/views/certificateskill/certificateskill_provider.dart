import 'package:cip_payment_app/app/domain/entities/deviceinfo.dart';
import 'package:cip_payment_app/app/domain/entities/enums.dart';
import 'package:cip_payment_app/app/domain/entities/speciality.dart';
import 'package:cip_payment_app/app/domain/entities/storepay.dart';
import 'package:cip_payment_app/app/infrastructure/datasources/paymentdb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/datasources/quotadb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/datasources/specialitydb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/models/response/payment_model.dart';
import 'package:cip_payment_app/app/infrastructure/models/select_model.dart';
import 'package:cip_payment_app/app/infrastructure/repositories/payment_repository_impl.dart';
import 'package:cip_payment_app/app/infrastructure/repositories/quota_repository_impl.dart';
import 'package:cip_payment_app/app/infrastructure/repositories/speciality_repository_impl.dart';
import 'package:cip_payment_app/app/providers/infodevice_provider.dart';
import 'package:cip_payment_app/app/ui/components/alert/popup_checkout.dart';
import 'package:cip_payment_app/app/ui/components/alert/popup_general.dart';
import 'package:cip_payment_app/app/ui/components/payment/payment_bad.dart';
import 'package:cip_payment_app/app/ui/components/payment/payment_good.dart';
import 'package:cip_payment_app/app/ui/components/payment/warning_pay.dart';
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

class CertificateSkillProvider with ChangeNotifier {
  final PaymentRepositoryImpl paymentRepositoryImpl = PaymentRepositoryImpl(
    PaymentdbDatasource(),
  );
  final SpecialityRepositoryImpl specialityRepositoryImpl =
      SpecialityRepositoryImpl(SpecialitydbDatasource());

  String ctrlNumberCip = '972 243 232';
  String ctrlColegiado = 'José Guevara Martinez';
  String ctrlState = 'Activo';
  String ctrlEnabledUntil = '31 de Agosto del 2025';
  String ctrlNumberCertf = '01';
  String ctrlSpecialty = 'Ing. De Sistemas e informática';
  double valueCertificate = 15;
  String rucId = '';
  bool stateCollegiate = false;
  TextEditingController quantityCertificate = TextEditingController(text: '1');
  final PageController pageController = PageController();

  bool haveQuotasPending = true;
  final QuotaRepositoryImpl quotaRepositoryImpl =
      QuotaRepositoryImpl(QuotadbDatasource());
  double amountToPay = 15.0;
  String mainEmail = '';
  String personId = '';

  int receiptType = 0; //0 boleta, 1: facura

  Future<void> onInit(BuildContext context) async {
    selectTab(0);
    getInfoDevice(context);
    personId = PreferencesUser.personId;
    mainEmail = PreferencesUser.mainEmail;
    getSpecilaities(personId);
    hasQuotasPending(context);
    getHistoryQuotasPayment(context);
    getHistoryPayment(context);
  }

  Future<void> hasQuotasPending(BuildContext context) async {
    stateCollegiate = true;
    try {
      final response = await quotaRepositoryImpl.hasPendingQuotas(personId);
      haveQuotasPending = response;
      if (haveQuotasPending) {
        showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return PopupGeneral(
              title: '',
              onTapButton: () {},
              scrollable: true,
              content: WarningPay(
                  'Para poder generar tu certificado de habilidad debe pagar su deuda pendiente.'),
            );
          },
        );
        stateCollegiate = false; // Deshabilitado
      }
      //TODO: si es false entonces hacer la petición hasta cuando esta habilitado
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

  Future<void> openCheckout(BuildContext context) async {
    try {
      final int amountRound = Helpers.toCents(amountToPay);
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
                    amountToPay,
                    textCertificateskill,
                    PaymentType.certificateskill.code,
                  ),
                );
              },
            );
            //TODO: GUARDAR EN LA TABLA DE PAYMENT EL PAGO REALIZADO
            final cuantityCert = int.parse(quantityCertificate.text);
            List<PaymentModel> paymentQuotaModels =
                List.generate(cuantityCert, (index) {
              return PaymentModel(
                creationDatePay: Timestamp.fromDate(DateTime.now()),
                deviceInfoPay: deviceInfo?.nameDevice ?? '',
                ipAddressPay: deviceInfo?.ip ?? '',
                locationCityPay: deviceInfo?.nameCity ?? '',
                locationCountryPay: deviceInfo?.nameCountry ?? '',
                locationPay: GeoPoint(
                    deviceInfo?.latitude ?? 0.0, deviceInfo?.longitude ?? 0.0),
                paymentState: true,
                paymentValue: valueCertificate, // el monto del certificado
                personId: personId,
                platformPayment: PlatformPayment.app.name,
                quantityPayment: 1, // cada uno representa un certificado
                receiptType: receiptType, //ReceiptType.bill.code,
                typePay: PaymentType.certificateskill.code,
                paymentChannel: PaymentChannel.online.code,
                rucId: rucId,
                feeMonth: 0,
                feeYear: 0,
                specialtyId: currectSpecialty.id,
              );
            });
            await paymentRepositoryImpl.payQuotas(paymentQuotaModels);
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
    } catch (e) {
    } finally {
      cleanVariables();
    }
  }

  bool isGettinHistory = false;
  List<Storepay> paymentHistory = [];

  Future<void> getHistoryPayment(BuildContext context) async {
    paymentHistory.clear();
    isGettinHistory = true;
    print(personId);
    try {
      final response = await paymentRepositoryImpl.historyPaymentQuotas(
          personId, PaymentType.certificateskill.code);
      if (response == null) {
        return;
      }
      paymentHistory.addAll(response);
      paymentHistory.sort((a, b) => (b.feeMonth ?? 0)
          .compareTo(a.feeMonth ?? 0)); //Ordena de mayor a menor
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

  List<Storepay> paymentHistoryQuotas = [];
  String enabledUntil = '-';
  Future<void> getHistoryQuotasPayment(BuildContext context) async {
    paymentHistoryQuotas.clear();
    try {
      final response = await paymentRepositoryImpl.historyPaymentQuotas(
          personId, PaymentType.monthlyFees.code);
      if (response == null || response.isEmpty) {
        return;
      }
      paymentHistoryQuotas.addAll(response);
      paymentHistoryQuotas
          .sort((a, b) => (b.feeMonth ?? 0).compareTo(a.feeMonth ?? 0));
      print(paymentHistoryQuotas.length);
      final mayor = paymentHistoryQuotas.first;
      print(mayor);
      enabledUntil =
          '${Helpers.getNameMonth(mayor.feeMonth ?? 0)} del ${mayor.feeYear}';
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
      notifyListeners();
    }
  }

  List<Speciality> listSpecialities = [];
  SelectModel currectSpecialty = SelectModel(id: '0', value: 'Seleccionar');

  Future<void> getSpecilaities(String personId) async {
    listSpecialities.clear();
    final response = await specialityRepositoryImpl.getSpecialties(personId);
    listSpecialities.addAll(response);
    if (response.isNotEmpty && currectSpecialty.id == '0') {
      final first = listSpecialities.first;
      currectSpecialty = SelectModel(
        id: first.id ?? '',
        value: first.nameSpeciality ?? '',
      );
    }
    notifyListeners();
  }
  // Speciality specialityToCertificate = Speciality();
  Speciality getSpecialityToCertificate(String specialityId) {
      final specialityToCertificate = listSpecialities.firstWhere(
        (item) => item.id == specialityId,
      );
      return specialityToCertificate;
    }

  Future<void> getReceipt(
    String receiptNumber,
    String date,
    String name,
    String dni,
    double subtotal,
  ) async {
    final igv = subtotal * 0.18;
    await generateReceipt(
      receiptNumber: receiptNumber,
      date: date,
      name: name,
      dni: dni,
      subtotal: subtotal - igv,
      igv: igv,
      total: subtotal,
      typePay: textCertificateskill,
    );
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  void onPageChanged(int index) {
    _selectedIndex = index;
    notifyListeners();
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

  DeviceInfo? deviceInfo;
  void getInfoDevice(context) async {
    deviceInfo = await Provider.of<InfodeviceProvider>(context, listen: false)
        .deviceInfo();
  }

  void updateAmount() {
    amountToPay = 0;
    if (quantityCertificate.text.isNotEmpty) {
      final quantityCert = int.parse(quantityCertificate.text);
      amountToPay = valueCertificate * quantityCert;
    }
    notifyListeners();
  }

  void prueba() {
    final prueba = currectSpecialty.id;
    print(prueba);
  }

  void cleanVariables() {
    rucId = '';
    receiptType = 0;
  }
}
