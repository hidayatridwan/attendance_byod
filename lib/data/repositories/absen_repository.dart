part of 'repositories.dart';

class AbsenRepository {
  final AbsenProvider _absenProvider = AbsenProvider();

  Future<Either<String, AbsenModel>> absen(String nik) async {
    try {
      final response = await _absenProvider.absen(nik);
      return Right(absenModelFromJson(response.data['result']));
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['error'] ?? e.response!.data['message']);
      } else {
        return const Left('Failed host lookup connection');
      }
    }
  }

  Future<Either<String, List<AbsenModel>>> logs(
      String nik, String period) async {
    try {
      final response = await _absenProvider.logs(nik, period);
      List data = response.data['result'];
      return Right(data.map((e) => absenModelFromJson(e)).toList());
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['error'] ?? e.response!.data['message']);
      } else {
        return const Left('Failed host lookup connection');
      }
    }
  }
}
