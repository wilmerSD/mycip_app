import 'package:cip_payment_app/app/models/response/login_response.dart';
import 'package:flutter/material.dart';

// class UserProvider with ChangeNotifier {
//   Future<LoginResponse> postLogin(
//     RequestLoginModel request,
//   ) async {
//     final response = await dioClient.post(
//       path: "/PostPrcValidaLogin02",
//       bodyRaw: request.toJson(),
//     );
//     return ResponseInfopersonalModel.fromJson(response);
//   }

//   Future<ResponseInforassistantModel> getInfoAssistant(
//       String personalid) async {
//     final response = await dioClient.get(
//         path: "/GetProc_InfoAssistant",
//         queryParameters: {"Ppersonalid": personalid});
//     return ResponseInforassistantModel.fromJson(response);
//   }
 
//   Future<ResponseSaveassistantModel> postSaveAssistant(
//       RequestSaveassistantModel request) async {
//     final response = await dioClient.post(
//         path: "/PostProc_GuardarAsistencia", bodyRaw: request.toJson());
//     return ResponseSaveassistantModel.fromJson(response);
//   }
// }
