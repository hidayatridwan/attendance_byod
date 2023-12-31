import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/absen_model.dart';
import '../../data/repositories/repositories.dart';

part 'absen_event.dart';

part 'absen_state.dart';

class AbsenBloc extends Bloc<AbsenEvent, AbsenState> {
  final AbsenRepository _absenRepository;

  AbsenBloc(this._absenRepository) : super(AbsenInitial()) {
    on<DoAbsenEvent>((event, emit) async {
      emit(AbsenLoading());
      final result = await _absenRepository.absen(event.nik);
      result.fold((l) => emit(AbsenError(l)), (r) => emit(AbsenSuccess(r)));
    });

    on<LogEvent>((event, emit) async {
      emit(LogLoading());
      final result = await _absenRepository.logs(event.nik, event.period);
      result.fold((l) => emit(LogError(l)), (r) => emit(LogSuccess(r)));
    });
  }
}
