import 'package:cip_payment_app/app/ui/components/field_form.dart';
import 'package:cip_payment_app/app/ui/views/certificateskill/certificateskill_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CertificateSkillView extends StatelessWidget {
const CertificateSkillView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final certificateSkill = Provider.of<CertificateSkillController>(context);
    
    Widget numberCip = FieldForm(
      label: "CIP",
      // hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: certificateSkill.ctrlNumberCip,
    );
    Widget numberColegiado = FieldForm(
      label: "Colegiado",
      // hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: certificateSkill.ctrlColegiado,
    );
    Widget numberState = FieldForm(
      label: "Estado",
      // hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: certificateSkill.ctrlState,
    );
    Widget numberEnabledUntil = FieldForm(
      label: "Habilitado hasta",
      // hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: certificateSkill.ctrlEnabledUntil,
    );
    Widget numberSpecialty = FieldForm(
      label: "Especialidad",
      // hintText: "Ingresa tu usuario",
      textInputType: TextInputType.emailAddress,
      textEditingController: certificateSkill.ctrlSpecialty,
    );
    
    return Scaffold(
      appBar: AppBar(title: Text('Certificado de habilidad'),),
      body: Column(

        spacing: 15.0,
        children: [
          SizedBox(),
          numberCip,
          numberColegiado,
          numberState,
          numberEnabledUntil,
          numberSpecialty,
        ],
      )
    );
  }
}