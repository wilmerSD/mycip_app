import 'package:cip_payment_app/app/ui/views/login/login_view.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/recover_pass_code.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/recover_pass_reset.dart';
import 'package:cip_payment_app/routes/app_routes_name.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RecoverPassController with ChangeNotifier{
  bool _isVisiblePass = false;
  bool _isLoading = false;
  bool _isVisiblePassRepeat = false;

  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlPassword = TextEditingController();
  TextEditingController ctrlPasswordToConfirm = TextEditingController();
  TextEditingController ctrlCodeVerification = TextEditingController();
  TextEditingController ctrlUser = TextEditingController();

  String codeGenerate = '';
  String personalId = '';

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  set isVisiblePass(bool value) {
    _isVisiblePass = value;
    notifyListeners();
  }
  set isVisiblePassRepeat(bool value) {
    _isVisiblePassRepeat = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  bool get isVisiblePass => _isVisiblePass;
  bool get isVisiblePassRepeat => _isVisiblePassRepeat;


  /* 📌 Regresar a login */
  void goToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginView()),
    );
  }

  Future validateCode(BuildContext context) async{
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RecoverPassReset()));
  }

  Future validateEmail(BuildContext context) async{
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RecoverPassCode()));
  }
  Future validatePass(BuildContext context) async{
    context.go(AppRoutesName.LOGIN);
  }
}
