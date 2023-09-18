import 'dart:convert';

import 'package:attendance_byod/data/models/karyawan_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsData {
  late final SharedPreferences _pref;

  static PrefsData instance = PrefsData();

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    _pref.remove('user');
    _pref.remove('kordinat');
  }

  Future<bool> setFirstInstall() async {
    return await _pref.setBool('isFirstInstall', false);
  }

  bool get isFirstInstall => _pref.getBool('isFirstInstall') ?? true;

  Future<bool> saveUser(String? user) async {
    return await _pref.setString('user', user!);
  }

  KaryawanModel? get user {
    final String? json = _pref.getString('user');
    if (json == null) {
      return null;
    } else {
      return karyawanModelFromJson(jsonDecode(json!));
    }
  }

  Future<bool> saveKordinat(String? kordinat) async {
    return await _pref.setString('kordinat', kordinat!);
  }

  String? get kordinat => _pref.getString('kordinat');
}
