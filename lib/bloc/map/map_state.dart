part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class SetMapAreaState extends MapState {
  final bool isInSelectedArea;

  const SetMapAreaState(this.isInSelectedArea);

  @override
  List<Object> get props => [isInSelectedArea];
}
