

import 'package:cip_payment_app/app/domain/datasources/person_datasource.dart';
import 'package:cip_payment_app/app/domain/entities/person.dart';
import 'package:cip_payment_app/app/domain/repositories/person_repository.dart';
import 'package:cip_payment_app/app/infrastructure/models/person_model.dart';

class PersonRepositoryImpl extends PersonRepository{
  final PersonDatasource datasource;

  PersonRepositoryImpl(this.datasource);
  
  @override
  Future<Person?> createPerson(PersonModel person) {
    return datasource.createPerson(person);
  }

  @override
  Future<List<Person>> fetchAllPersons() {
    return datasource.fetchAllPersons();
  }

  @override
  Future<Person?> getPersonById(String personId) {
    return datasource.getPersonById(personId);
  }
}
