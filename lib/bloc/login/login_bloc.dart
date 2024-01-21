import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/karyawan_model.dart';
import '../../data/repositories/repositories.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final KaryawanRepository _karyawanRepository;

  LoginBloc(this._karyawanRepository) : super(LoginInitial()) {
    on<UserEvent>((event, emit) async {
      emit(LoginLoading());
      final result = await _karyawanRepository.login(event.nik, event.password);
      result.fold((l) => emit(LoginError(l)), (r) {
        emit(LoginSuccess(r));
      });
    });
  }
}
