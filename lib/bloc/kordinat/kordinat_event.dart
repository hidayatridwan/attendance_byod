part of 'kordinat_bloc.dart';

abstract class KordinatEvent extends Equatable {
  const KordinatEvent();

  @override
  List<Object?> get props => [];
}

class GetKordinatEvent extends KordinatEvent {
  final String nik;

  const GetKordinatEvent(this.nik);
}
