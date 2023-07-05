import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/karyawan_model.dart';
import '../../data/repositories/repositories.dart';

part 'karyawan_event.dart';

part 'karyawan_state.dart';

class KaryawanBloc extends Bloc<KaryawanEvent, KaryawanState> {
  final KaryawanRepository _karyawanRepository;

  KaryawanBloc(this._karyawanRepository) : super(KaryawanInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await _karyawanRepository.login(event.nik, event.password);
      result.fold((l) => emit(LoginError(l)), (r) {
        emit(LoginSuccess(r));
      });
    });
  }
}
