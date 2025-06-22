import 'package:cip_payment_app/app/ui/views/certificateskill/certificateskill_view.dart';
import 'package:cip_payment_app/app/ui/views/home/home_view.dart';
import 'package:cip_payment_app/app/ui/views/monthlyfees/monthlyfees_view.dart';
import 'package:cip_payment_app/app/ui/views/myprofile/myprofile_view.dart';
import 'package:cip_payment_app/app/ui/views/proofnodebt/proofnodebt_view.dart';
import 'package:flutter/material.dart';

class HomeController with ChangeNotifier {

  void goToHome(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeView()));
  }
  void goToProfile(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MyprofileView()));
  }
  void goToMonthlyFees(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const MonthlyfeesView()));
  }
  void goToCertificateSkill(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const CertificateSkillView()));
  }
  void goToProofnodebtView(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const ProofnodebtView()));
  }
  
  
}