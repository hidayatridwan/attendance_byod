part of 'absen_bloc.dart';

abstract class AbsenEvent extends Equatable {
  const AbsenEvent();

  @override
  List<Object?> get props => [];
}

class DoAbsenEvent extends AbsenEvent {
  final String nik;

  const DoAbsenEvent(this.nik);
}

class LogEvent extends AbsenEvent {
  final String nik;

  const LogEvent(this.nik);
}
