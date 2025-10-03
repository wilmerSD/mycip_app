

import 'package:cip_payment_app/app/domain/entities/person.dart';
import 'package:cip_payment_app/app/infrastructure/models/person_model.dart';

abstract class PersonRepository {
  Future<List<Person>> fetchAllPersons();
  Future<Person?> getPersonById(String personId);
  Future<Person?> createPerson(PersonModel person);
}
