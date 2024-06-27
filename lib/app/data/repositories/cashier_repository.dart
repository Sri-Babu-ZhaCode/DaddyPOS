import 'package:easybill_app/app/core/exceptions.dart';
import 'package:easybill_app/app/data/models/cashier.dart';
import 'package:easybill_app/app/data/repositories/base_repository.dart';

class CashierRepo extends BaseRepo {
  CashierRepo._privateConstructor();

  // Static instance variable
  static final CashierRepo _instance = CashierRepo._privateConstructor();

  // Factory constructor to return the singleton instance
  factory CashierRepo() {
    return _instance;
  }
  Future<List<Cashier>?> addCashier(Cashier c) async {
    try {
      return await post("/staff",
          body: c.toJson(), decoder: (json) => Cashier.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Cashier>?> getCashier() async {
    try {
      return await get<Cashier>("/staff/get",
          decoder: (json) => Cashier.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Cashier>?> updateCashier(Cashier c) async {
    try {
      return await put("/staff",
          body: c.toJson(), decoder: (json) => Cashier.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

   Future<List<Cashier>?> deleteCashier(Cashier c) async {
    try {
      return await delete<Cashier>("/staff",
          body: {"userCredentialsId": c.usercredentialsid},
          decoder: (json) => Cashier.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }
}
