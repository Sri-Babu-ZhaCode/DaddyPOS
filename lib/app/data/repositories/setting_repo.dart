import 'package:easybill_app/app/data/models/setting.dart';
import 'package:easybill_app/app/data/repositories/base_repository.dart';
import '../../core/exceptions.dart';

class SettingsRepo extends BaseRepo {
  SettingsRepo._privateConstructor();

  // Static instance variable
  static final SettingsRepo _instance = SettingsRepo._privateConstructor();

  // Factory constructor to return the singleton instance
  factory SettingsRepo() {
    return _instance;
  }

  Future<List<Setting>?> getSettings() async {  
    try {
      return await get<Setting>("/settings",
          decoder: (json) => Setting.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }

  Future<List<Setting>?> editSettings(Setting s) async {
    try {
      return await put("/settings",
          body: s.toJson(), decoder: (json) => Setting.fromJson(json));
    } catch (e) {
      throw EbException(e);
    }
  }
}
