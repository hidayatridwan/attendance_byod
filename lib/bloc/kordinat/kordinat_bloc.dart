import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/kordinat_model.dart';
import '../../data/repositories/repositories.dart';

part 'kordinat_event.dart';

part 'kordinat_state.dart';

class KordinatBloc extends Bloc<KordinatEvent, KordinatState> {
  final KordinatRepository _kordinatRepository;

  KordinatBloc(this._kordinatRepository) : super(KordinatInitial()) {
    on<GetKordinatEvent>((event, emit) async {
      emit(KordinatLoading());
      final result = await _kordinatRepository.getKordinat(event.nik);
      result.fold(
          (l) => emit(KordinatError(l)), (r) => emit(KordinatSuccess(r)));
    });
  }
}
