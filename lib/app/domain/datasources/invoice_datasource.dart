import 'package:cip_payment_app/app/domain/entities/company.dart';
import 'package:cip_payment_app/app/infrastructure/models/company_model.dart';

abstract class InvoiceDatasource {
  Future<List<Company>> getRucs(String personId);
  Future<Company?> createRuc(CompanyModel newCompany);
  Future<Company?> updateRuc(CompanyModel companyUpdate);
  Future<Company?> deleteRuc(String companyId);
}
