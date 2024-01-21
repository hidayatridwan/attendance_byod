part of 'log_absen_bloc.dart';

abstract class LogAbsenEvent extends Equatable {
  const LogAbsenEvent();

  @override
  List<Object?> get props => [];
}

class GetLogAbsenEvent extends LogAbsenEvent {
  final String nik;
  final String period;

  const GetLogAbsenEvent(this.nik, this.period);
}
