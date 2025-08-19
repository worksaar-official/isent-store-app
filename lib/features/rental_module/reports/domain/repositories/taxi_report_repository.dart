import 'package:get/get.dart';
import 'package:sixam_mart_store/api/api_client.dart';
import 'package:sixam_mart_store/features/rental_module/reports/domain/models/taxi_expense_model.dart';
import 'package:sixam_mart_store/features/rental_module/reports/domain/models/taxi_tax_report_model.dart';
import 'package:sixam_mart_store/features/rental_module/reports/domain/repositories/taxi_report_repository_interface.dart';
import 'package:sixam_mart_store/util/app_constants.dart';

class TaxiReportRepository implements TaxiReportRepositoryInterface {
  final ApiClient apiClient;
  TaxiReportRepository({required this.apiClient});

  @override
  Future<TaxiExpenseModel?> getExpenseList({required int offset, required int? restaurantId, required String? from, required String? to,  required String? searchText}) async {
    TaxiExpenseModel? expenseModel;
    Response response = await apiClient.getData('${AppConstants.expenseListUri}?limit=10&offset=$offset&restaurant_id=$restaurantId&from=$from&to=$to&search=${searchText ?? ''}');
    if(response.statusCode == 200){
      expenseModel = TaxiExpenseModel.fromJson(response.body);
    }
    return expenseModel;
  }

  @override
  Future<TaxiTaxReportModel?> getTaxReport({required int offset, required String? from, required String? to}) async {
    TaxiTaxReportModel? taxReportModel;
    Response response = await apiClient.getData('${AppConstants.taxiTaxReportUri}?limit=10&offset=$offset&from=$from&to=$to');
    if(response.statusCode == 200){
      taxReportModel = TaxiTaxReportModel.fromJson(response.body);
    }
    return taxReportModel;
  }

  @override
  Future add(value) {
    throw UnimplementedError();
  }

  @override
  Future delete(int? id) {
    throw UnimplementedError();
  }

  @override
  Future get(int? id) {
    throw UnimplementedError();
  }

  @override
  Future getList() {
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body) {
    throw UnimplementedError();
  }

}