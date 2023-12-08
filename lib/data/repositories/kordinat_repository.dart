part of 'repositories.dart';

class KordinatRepository {
  final KordinatProvider _kordinatProvider = KordinatProvider();

  Future<Either<String, List<KordinatModel>>> getKordinat(String nik) async {
    try {
      final response = await _kordinatProvider.getKordinat(nik);
      List data = response.data['result'];
      return Right(data.map((e) => kordinatModelFromJson(e)).toList());
    } on DioException catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['error'] ?? e.response!.data['message']);
      } else {
        return const Left('Failed host lookup connection');
      }
    }
  }
}
