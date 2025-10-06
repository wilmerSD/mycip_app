import 'package:cip_payment_app/app/domain/datasources/speciality_datasource.dart';
import 'package:cip_payment_app/app/domain/entities/speciality.dart';
import 'package:cip_payment_app/app/infrastructure/mappers/speciality_mapper.dart';
import 'package:cip_payment_app/app/infrastructure/models/speciality_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SpecialitydbDatasource extends SpecialityDatasource {
  final FirebaseFirestore firestoredb = FirebaseFirestore.instance;

  @override
  Future<List<Speciality>> getSpecialties(String personId) async {
    try {
      // Paso 1: obtener los IDs de especialidades asociadas a la persona
      final response = await firestoredb
          .collection('PersonSpeciality')
          .where("personId", isEqualTo: personId)
          .get();

      final specialityIds =
          response.docs.map((doc) => doc['specialityId'] as String).toList();

      if (specialityIds.isEmpty) {
        return [];
      }

      // Paso 2: traer todas las especialidades desde la colección "Speciality"
      final specialtiesResponse = await firestoredb
          .collection('Speciality')
          .where(FieldPath.documentId, whereIn: specialityIds)
          .get();

      final specialtiesMap = specialtiesResponse.docs
          .map((doc) => SpecialityModel.fromJson(doc.data()))
          .toList();

      final specialties = specialtiesMap
          .map((resp) => SpecialityMapper.specialityResponseToEntity(resp))
          .toList();

      return specialties;
    } catch (e) {
      print("Error obteniendo especialidades: $e");
      return [];
    }
  }
  

}
