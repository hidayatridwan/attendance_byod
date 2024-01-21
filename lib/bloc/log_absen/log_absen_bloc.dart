import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/absen_model.dart';
import '../../data/repositories/repositories.dart';

part 'log_absen_event.dart';

part 'log_absen_state.dart';

class LogAbsenBloc extends Bloc<LogAbsenEvent, LogAbsenState> {
  final AbsenRepository _absenRepository;

  LogAbsenBloc(this._absenRepository) : super(LogAbsenInitial()) {
    on<GetLogAbsenEvent>((event, emit) async {
      emit(LogAbsenLoading());
      final result = await _absenRepository.logs(event.nik, event.period);
      result.fold(
          (l) => emit(LogAbsenError(l)), (r) => emit(LogAbsenSuccess(r)));
    });
  }
}
