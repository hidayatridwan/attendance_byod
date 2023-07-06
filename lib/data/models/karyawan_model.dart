import 'dart:convert';

KaryawanModel karyawanModelFromJson(Map<String, dynamic> json) =>
    KaryawanModel.fromJson(json);

String karyawanModelToJson(KaryawanModel data) => jsonEncode(data.toJson());

class KaryawanModel {
  KaryawanModel(
      {required this.id,
      required this.nik,
      required this.nama,
      required this.jenisKelamin,
      required this.tempatLahir,
      required this.tanggalLahir,
      required this.noHp,
      required this.alamat,
      this.email,
      required this.divisi,
      required this.jabatan,
      required this.password,
      required this.facePoint});

  String id;
  String nik;
  String nama;
  String jenisKelamin;
  String tempatLahir;
  String tanggalLahir;
  String noHp;
  String alamat;
  String? email;
  String divisi;
  String jabatan;
  String password;
  String facePoint;

  factory KaryawanModel.fromJson(Map<String, dynamic> json) => KaryawanModel(
        id: json["id"],
        nik: json["nik"],
        nama: json["nama"],
        jenisKelamin: json["jenisKelamin"],
        tempatLahir: json["tempatLahir"],
        tanggalLahir: json["tanggalLahir"],
        noHp: json["noHp"],
        alamat: json["alamat"],
        email: json["email"],
        divisi: json["divisi"],
        jabatan: json["jabatan"],
        password: json["password"],
        facePoint: json["facePoint"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nik": nik,
        "nama": nama,
        "jenisKelamin": jenisKelamin,
        "tempatLahir": tempatLahir,
        "tanggalLahir": tanggalLahir,
        "noHp": noHp,
        "alamat": alamat,
        "email": email,
        "divisi": divisi,
        "jabatan": jabatan,
        "password": password,
        "facePoint": facePoint,
      };

  @override
  String toString() {
    return "id $id nik $nik nama $nama jenisKelamin $jenisKelamin"
        " tempatLahir $tempatLahir tanggalLahir $tanggalLahir noHp $noHp"
        "alamat $alamat email $email divisi $divisi jabatan $jabatan password $password facePoint $facePoint";
  }
}
