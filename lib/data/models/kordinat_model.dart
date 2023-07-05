import 'dart:convert';

KordinatModel kordinatModelFromJson(Map<String, dynamic> json) =>
    KordinatModel.fromJson(json);

String kordinatModelToJson(KordinatModel data) => jsonEncode(data.toJson());

class KordinatModel {
  KordinatModel({
    required this.nama,
    required this.lat,
    required this.lng,
    required this.jumlahAbsen,
  });

  String nama;
  double lat;
  double lng;
  int jumlahAbsen;

  factory KordinatModel.fromJson(Map<String, dynamic> json) => KordinatModel(
        nama: json["nama"],
        lat: json["lat"],
        lng: json["lng"],
        jumlahAbsen: json["jumlahAbsen"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "lat": lat,
        "lng": lng,
        "jumlahAbsen": jumlahAbsen,
      };
}
