import 'package:easybill_app/app/data/repositories/base_repository.dart';
import '../../core/exceptions.dart';
import '../models/category.dart';

class CategoryRepo extends BaseRepo {
  CategoryRepo._privateConstructor();

  // Static instance variable
  static final CategoryRepo _instance = CategoryRepo._privateConstructor();

  // Factory constructor to return the singleton instance
  factory CategoryRepo() {
    return _instance;
  }

  Future<List<Category>?> addCategory(Category c) async {
    try {
      return await post("/category",
          body: c.toJson(), decoder: (json) => Category.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Category>?> getCategories() async {
    try {
      return await get<Category>("/category/get",
          decoder: (json) => Category.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Category>?> deleteCategory(Category p) async {
    try {
      return await delete("/category",
          body: p.toJson(), decoder: (json) => Category.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Category>?> editCategory(Category c) async {
    try {
      return await put("/category",
          body: c.toJson(), decoder: (json) => Category.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }
}
