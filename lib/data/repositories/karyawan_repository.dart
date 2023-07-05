part of 'repositories.dart';

class KaryawanRepository {
  final KaryawanProvider _karyawanProvider = KaryawanProvider();

  Future<Either<String, KaryawanModel>> login(
      String nik, String password) async {
    try {
      final response = await _karyawanProvider.login(nik, password);
      final result = response.data['result'];
      PrefsData.instance.saveUser(jsonEncode(result));
      return Right(karyawanModelFromJson(result));
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['error']);
      } else {
        return Left(e.message!);
      }
    }
  }

  Future<Either<String, String>> register(String nik, String facePoint) async {
    try {
      await _karyawanProvider.register(nik, facePoint);
      return const Right('Register Succeeded');
    } on DioError {
      return const Left('Register Failed');
    }
  }
}
