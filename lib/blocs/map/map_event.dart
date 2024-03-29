part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}


class OnMapInitializedEvent extends MapEvent{
  final GoogleMapController controller;
  const OnMapInitializedEvent(this.controller);

}

class DisplayMarkersEvent extends MapEvent{
  final Map<String, Marker> markers;
  const DisplayMarkersEvent(this.markers);
}