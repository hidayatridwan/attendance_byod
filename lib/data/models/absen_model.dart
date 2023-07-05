import 'dart:convert';

AbsenModel absenModelFromJson(Map<String, dynamic> json) =>
    AbsenModel.fromJson(json);

String absenModelToJson(AbsenModel data) => jsonEncode(data.toJson());

class AbsenModel {
  AbsenModel({
    required this.nik,
    required this.jamDatang,
    required this.jamPulang,
  });

  String nik;
  String? jamDatang;
  String? jamPulang;

  factory AbsenModel.fromJson(Map<String, dynamic> json) => AbsenModel(
        nik: json["nik"],
        jamDatang: json["jamDatang"],
        jamPulang: json["jamPulang"],
      );

  Map<String, dynamic> toJson() => {
        "nik": nik,
        "jamDatang": jamDatang,
        "jamPulang": jamPulang,
      };
}
