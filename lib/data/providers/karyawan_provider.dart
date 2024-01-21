part of 'providers.dart';

class KaryawanProvider {
  Future<Response> login(String nik, String password) async {
    try {
      final Response response =
          await dio.post(loginUrl, data: {'nik': nik, 'password': password});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> register(String nik, String facePoint) async {
    try {
      dio.options.headers['x-api-key'] = token;
      final Response responseApi = await dio.get('$apiKaryawanUrl/$nik');
      if (responseApi.statusCode == 404) {
        throw Exception(responseApi.data['message']);
      }

      final data = responseApi.data;

      final Response response = await dio.post(userUrl, data: {
        'nik': data['NIK'],
        'nama': data['NamaKaryawan'],
        'jenisKelamin': data['JenisKelamin'][0].toString().toUpperCase(),
        'tempatLahir': data['TempatLahir'],
        'tanggalLahir': data['TglLahir'],
        'noHp': data['Telepon'],
        'alamat': data['Alamat'],
        'email': data['Email'],
        'divisi': data['Divisi'],
        'jabatan': data['Jabatan'],
        'facePoint': facePoint
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> user(String nik) async {
    try {
      dio.options.headers['x-api-key'] = token;
      final Response response = await dio.get('$userUrl/$nik');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> changePassword(
      String nik, String newPassword, String oldPassword) async {
    try {
      final Response response = await dio.patch(changePasswordUrl, data: {
        'nik': nik,
        'password': newPassword,
        'oldPassword': oldPassword
      });
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
