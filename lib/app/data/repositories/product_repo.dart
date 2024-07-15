import 'package:easybill_app/app/core/exceptions.dart';
import 'package:easybill_app/app/data/models/product.dart';
import 'package:easybill_app/app/data/repositories/base_repository.dart';

import '../models/utilities.dart';

class ProductRepo extends BaseRepo {
  ProductRepo._privateConstructor();

  // Static instance variable
  static final ProductRepo _instance = ProductRepo._privateConstructor();

  // Factory constructor to return the singleton instance
  factory ProductRepo() {
    return _instance;
  }

  // product repos
  Future<List<Product>?> addProduct(Product p) async {
    try {
      return await post("/products",
          body: p.toJson(), decoder: (json) => Product.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Product>?> updateProduct(Product p) async {
    try {
      return await put("/products",
          body: p.toJson(), decoder: (json) => Product.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Product>?> getProducts() async {
    try {
      return await get<Product>("/products/get",
          decoder: (json) => Product.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Product>?> deleteProducts(Product p) async {
    try {
      return await delete<Product>("/products",
          body: {"shopproductid": p.shopproductid},
          decoder: (json) => Product.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Product>?> downloadProduct() async {
    try {
      return await get<Product>("/productDownload",
          decoder: (json) => Product.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Product>?> uploadProduct(Product p) async {
    try {
      return await post<Product>("/upload",
          body: p, decoder: (json) => Product.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

// Utilities Repo
  Future<List<Units>?> getUtilitiesUnit() async {
    try {
      return await get<Units>("/utilites/units",
          decoder: (json) => Units.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<TaxType>?> getUtilitiesTaxtype() async {
    try {
      return await get<TaxType>("/utilites/taxtypes",
          decoder: (json) => TaxType.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }
}
