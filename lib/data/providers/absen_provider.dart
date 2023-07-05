part of 'providers.dart';

class AbsenProvider {
  Future<Response> absen(String nik) async {
    try {
      dio.options.headers['x-api-key'] = token;
      final Response response = await dio.post(absenUrl, data: {'nik': nik});
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> logs(String nik) async {
    try {
      dio.options.headers['x-api-key'] = token;
      final Response response = await dio.get('$absenUrl/$nik');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
