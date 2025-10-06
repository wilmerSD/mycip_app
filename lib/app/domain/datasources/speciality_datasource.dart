import 'package:cip_payment_app/app/domain/entities/speciality.dart';

abstract class SpecialityDatasource {
  Future<List<Speciality>> getSpecialties(String personId);
  // Future<Speciality?> createSpeciality(); 
  // Future<Speciality?> deleteSpeciality();
  // Future<Speciality?> updateSpeciality();
}