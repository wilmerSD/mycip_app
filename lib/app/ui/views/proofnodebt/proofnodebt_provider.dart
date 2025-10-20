import 'package:cip_payment_app/app/domain/entities/deviceinfo.dart';
import 'package:cip_payment_app/app/domain/entities/enums.dart';
import 'package:cip_payment_app/app/domain/entities/payment.dart';
import 'package:cip_payment_app/app/domain/entities/speciality.dart';
import 'package:cip_payment_app/app/infrastructure/datasources/paymentdb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/datasources/quotadb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/datasources/specialitydb_datasource.dart';
import 'package:cip_payment_app/app/infrastructure/models/response/payment_model.dart';
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
import 'package:cip_payment_app/core/helpers/helpers.dart';
import 'package:cip_payment_app/preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProofnodebtProvider with ChangeNotifier {
  final QuotaRepositoryImpl quotaRepositoryImpl =
      QuotaRepositoryImpl(QuotadbDatasource());
  final PaymentRepositoryImpl paymentRepositoryImpl = PaymentRepositoryImpl(
    PaymentdbDatasource(),
  );
  final SpecialityRepositoryImpl specialityRepositoryImpl =
      SpecialityRepositoryImpl(SpecialitydbDatasource());
  bool isGetQuotasPending = false;
  bool haveQuotasPending = true;
  final double amountToPay = 30.0;
  bool stateCollegiate = false;
  int receiptType = 0; //0 boleta, 1: facura
  Future<void> onInit(BuildContext context) async {
    selectTab(0);
    getInfoDevice(context);
    await getDataPerson();
    await hasQuotasPending(context);
    getHistoryPayment(context);
    fetchLastQuotaByPerson();
    getSpecilaities();
  }

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  String personId = '';
  String mainEmail = '';

  Future<void> getDataPerson() async {
    personId = PreferencesUser.personId;
    mainEmail = PreferencesUser.mainEmail;
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
              content: const WarningPay(
                'Para poder generar su constancia de no adeudo debe pagar su deuda pendiente.',
              ),
            );
          },
        );
        // stateCollegiate = false;
        stateCollegiate = true;
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
                      textProofnodebt,
                      PaymentType.proffnodebt.code),
                );
              },
            );

            if (deviceInfo != null) {}
            final paymentMade = PaymentModel(
              creationDatePay: Timestamp.fromDate(DateTime.now()),
              deviceInfoPay: deviceInfo?.nameDevice ?? '',
              ipAddressPay: deviceInfo?.ip ?? '',
              locationCityPay: deviceInfo?.nameCity ?? '',
              locationCountryPay: deviceInfo?.nameCountry ?? '',
              locationPay: GeoPoint(
                  deviceInfo?.latitude ?? 0.0, deviceInfo?.longitude ?? 0),
              paymentState: true,
              paymentValue: amountToPay,
              personId: personId,
              platformPayment: PlatformPayment.app.name,
              quantityPayment: 1,
              receiptType: receiptType,
              typePay: PaymentType.proffnodebt.code,
              paymentChannel: PaymentChannel.online.code,
              rucId: rucId,
              feeMonth: 0,
              feeYear: 0,
              specialtyId: '',
            );
            final List<PaymentModel> paymentMadeList = [paymentMade];
            await paymentRepositoryImpl.payQuotas(paymentMadeList);
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
      debugPrint(e.toString());
    } finally {
      cleanVariables();
    }
  }

  List<Payment> paymentHistory = [];
  bool isGettinHistory = false;

  Future<void> getHistoryPayment(BuildContext context) async {
    paymentHistory.clear();
    isGettinHistory = true;
    print(personId);
    try {
      final response = await paymentRepositoryImpl.historyPaymentQuotas(
          personId, PaymentType.proffnodebt.code);
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

  String enabledUntil = '-';
  Future<void> fetchLastQuotaByPerson() async {
    try {
      final response =
          await quotaRepositoryImpl.fetchLastQuotaByPerson(personId);
      if (response == null) {
        return;
      }
      enabledUntil =
          '${Helpers.getNameMonth(response.feeMonth ?? 0)} del ${response.feeYear}';
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      notifyListeners();
    }
  }

  List<Speciality> listSpecialities = [];
  Speciality specialityToPdf = Speciality();
  Future<void> getSpecilaities() async {
    listSpecialities.clear();
    final response = await specialityRepositoryImpl.getSpecialties(personId);
    listSpecialities.addAll(response);
    if (listSpecialities.isNotEmpty) {
      specialityToPdf = listSpecialities.first;
    }
  }

  String rucId = '';
  DeviceInfo? deviceInfo;
  void getInfoDevice(context) async {
    deviceInfo = await Provider.of<InfodeviceProvider>(context, listen: false)
        .deviceInfo();
  }

  final PageController pageController = PageController();
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

  void cleanVariables() {
    rucId = '';
    receiptType = 0;
  }
}
