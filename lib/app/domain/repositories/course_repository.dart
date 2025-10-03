import 'package:cip_payment_app/app/domain/entities/course.dart';
import 'package:cip_payment_app/app/infrastructure/models/course_model.dart';

abstract class CourseRepository {
  Future<List<Course>> fetchAllCourse();
  Future<Course?>  createCourse(CourseModel course);
}
