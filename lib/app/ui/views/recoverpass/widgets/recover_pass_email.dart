import 'package:cip_payment_app/app/routes/app_routes_name.dart';
import 'package:cip_payment_app/app/ui/components/btn/btn_primary_ink.dart';
import 'package:cip_payment_app/app/ui/components/field_form.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/recoverpass_provider.dart';
import 'package:cip_payment_app/app/ui/components/appbar/leading.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/text_back_login.dart';
import 'package:cip_payment_app/app/ui/views/recoverpass/widgets/text_tittle.dart';
import 'package:cip_payment_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class RecoverPasswordEmail extends StatelessWidget {
  const RecoverPasswordEmail({super.key});

  @override
  Widget build(BuildContext context) {
    final recoverpassController = Provider.of<RecoverPassProvider>(context);

    /* 📌 Input de email */
    Widget inputEmail = FieldForm(
      label: "Email",
      hintText: "Ingrese correo email",
      textInputType: TextInputType.emailAddress,
      textEditingController: recoverpassController.ctrlEmail,
    );

    /* 📌 btn para enviar código de verificación */
    Widget getCodeVerification = BtnPrimaryInk(
      text: recoverpassController.isLoading ? "Enviando..." : "Obtener código",
      loading: recoverpassController.isLoading,
      onTap: () => recoverpassController.validateEmail(context),
    );

    Widget backLogin = Column(
      children: [
        InkWell(
          onTap: () => context.go(AppRoutesName.LOGIN),
          child: const Center(child: TextBackLogin()),
        ),
        const SizedBox(height: 15.0),
      ],
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundColor(context),
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor(context),
        leading: const Leading()),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 20.0,
            children: [
              TextTittle(
                tittle: '¿Olvidaste tu contraseña',
                subTittle:
                    'No te preocupes, eso pasa. Por favor, ingrese su email asociado con su cuenta',
              ),
              inputEmail,
              getCodeVerification,
              const Spacer(),
              backLogin,
            ],
          ),
        ),
      ),
    );
  }
}
