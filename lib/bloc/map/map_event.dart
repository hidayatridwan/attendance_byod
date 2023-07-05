part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
  @override
  List<Object?> get props => [];
}


class SetMapAreaEvent extends MapEvent {
  final bool isInSelectedArea;

  const SetMapAreaEvent(this.isInSelectedArea);

}
