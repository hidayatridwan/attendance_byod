part of 'repositories.dart';

class KordinatRepository {
  final KordinatProvider _kordinatProvider = KordinatProvider();

  Future<Either<String, List<KordinatModel>>> getKordinat(String nik) async {
    try {
      final response = await _kordinatProvider.getKordinat(nik);
      List data = response.data['result'];
      return Right(data.map((e) => kordinatModelFromJson(e)).toList());
    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response!.data['error']);
      } else {
        return Left(e.message!);
      }
    }
  }
}
