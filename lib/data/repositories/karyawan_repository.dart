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
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['error'] ?? e.response!.data['message']);
      } else {
        return const Left('Failed host lookup connection');
      }
    }
  }

  Future<Either<String, String>> register(String nik, String facePoint) async {
    try {
      await _karyawanProvider.register(nik, facePoint);
      return const Right('Register Succeeded');
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['error'] ?? e.response!.data['message']);
      } else {
        return const Left('Failed host lookup connection');
      }
    }
  }

  Future<Either<String, KaryawanModel>> user(String nik) async {
    try {
      final response = await _karyawanProvider.user(nik);
      final result = response.data['result'];
      PrefsData.instance.saveUser(jsonEncode(result));
      return Right(karyawanModelFromJson(result));
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['error'] ?? e.response!.data['message']);
      } else {
        return const Left('Failed host lookup connection');
      }
    }
  }

  Future<Either<String, String>> changePassword(
      String nik, String newPassword, String oldPassword) async {
    try {
      final response =
          await _karyawanProvider.changePassword(nik, newPassword, oldPassword);
      final result = response.data['message'];
      return Right(result);
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['error'] ?? e.response!.data['message']);
      } else {
        return const Left('Failed host lookup connection');
      }
    }
  }
}
