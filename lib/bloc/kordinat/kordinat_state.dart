part of 'kordinat_bloc.dart';

abstract class KordinatState extends Equatable {
  const KordinatState();
  @override
  List<Object> get props => [];
}

class KordinatInitial extends KordinatState {}


class KordinatLoading extends KordinatState {}

class KordinatSuccess extends KordinatState {
  final List<KordinatModel> data;

  const KordinatSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class KordinatError extends KordinatState {
  final String error;

  const KordinatError(this.error);

  @override
  List<Object> get props => [error];
}