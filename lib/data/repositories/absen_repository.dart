part of 'repositories.dart';

class AbsenRepository {
  final AbsenProvider _absenProvider = AbsenProvider();

  Future<Either<String, AbsenModel>> absen(String nik) async {
    try {
      final response = await _absenProvider.absen(nik);
      return Right(absenModelFromJson(response.data['result']));
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['error']);
      } else {
        return Left(e.message!);
      }
    }
  }

  Future<Either<String, List<AbsenModel>>> logs(String nik) async {
    try {
      final response = await _absenProvider.logs(nik);
      List data = response.data['result'];
      return Right(data.map((e) => absenModelFromJson(e)).toList());
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['error']);
      } else {
        return Left(e.message!);
      }
    }
  }
}
