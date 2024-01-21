part of 'absen_bloc.dart';

abstract class AbsenEvent extends Equatable {
  const AbsenEvent();

  @override
  List<Object?> get props => [];
}

class SendAbsenEvent extends AbsenEvent {
  final String nik;

  const SendAbsenEvent(this.nik);
}
