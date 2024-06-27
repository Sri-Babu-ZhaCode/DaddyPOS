
import 'package:easybill_app/app/data/repositories/base_repository.dart';
import '../../core/exceptions.dart';
import '../models/profile.dart';

class ProfileRepo extends BaseRepo {
  ProfileRepo._privateConstructor();

  // Static instance variable
  static final ProfileRepo _instance = ProfileRepo._privateConstructor();

  // Factory constructor to return the singleton instance
  factory ProfileRepo() {
    return _instance;
  }

  Future<List<Profile>?> getProfile(Profile p) async {
    try {
      return await post("/profile/getProfile",
          body: p.toJson(), decoder: (json) => Profile.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Profile>?> editProfile(Profile p) async {
    try {
      return await post("/profile/editProfile",
          body: p.toJson(), decoder: (json) => Profile.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Profile>?> updatePass(Profile p) async {
    try {
      return await post("/profile/editPassword",
          body: p.toJson(), decoder: (json) => Profile.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }
}
