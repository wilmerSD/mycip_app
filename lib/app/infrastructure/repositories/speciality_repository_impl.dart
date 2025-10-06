import 'package:cip_payment_app/app/domain/datasources/speciality_datasource.dart';
import 'package:cip_payment_app/app/domain/entities/speciality.dart';
import 'package:cip_payment_app/app/domain/repositories/speciality_repository.dart';

class SpecialityRepositoryImpl extends SpecialityRepository{
  final SpecialityDatasource specialityDatasource;
  SpecialityRepositoryImpl(this.specialityDatasource);
  @override
  Future<List<Speciality>> getSpecialties(String personId) {
    return specialityDatasource.getSpecialties(personId);
  }
}

