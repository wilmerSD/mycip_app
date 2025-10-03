import 'package:cip_payment_app/app/domain/datasources/course_datasource.dart';
import 'package:cip_payment_app/app/domain/entities/course.dart';
import 'package:cip_payment_app/app/domain/repositories/course_repository.dart';
import 'package:cip_payment_app/app/infrastructure/models/course_model.dart';

class CourseRepositoryImpl extends CourseRepository {
  
  final CourseDatasource datasource;

  CourseRepositoryImpl(this.datasource);

  @override
  Future<Course?> createCourse(CourseModel course) {
    return datasource.createCourse(course);
  }

  @override
  Future<List<Course>> fetchAllCourse() {
    return datasource.fetchAllCourse();
  }
}
