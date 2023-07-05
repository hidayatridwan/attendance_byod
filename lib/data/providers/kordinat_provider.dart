part of 'providers.dart';

class KordinatProvider {
  Future<Response> getKordinat(String nik) async {
    try {
      dio.options.headers['x-api-key'] = token;
      final Response response = await dio.get('$kordinatUrl/$nik');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
