import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_concept/blocs/blocs.dart';
import 'package:maps_concept/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {

  final LocationBloc locationBloc;
  GoogleMapController? _mapController;

  MapBloc({
    required this.locationBloc
  }) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);
    on<DisplayMarkersEvent>((event, emit) => emit(state.copyWith(markers: event.markers)));

    locationBloc.stream.listen((locationState) { 
      if(!state.followUser) return;
      if(locationState.lastKnownLocation == null) return;

      moveCamera(locationState.lastKnownLocation!);
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit){

    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(uberMapTheme));

    emit(state.copyWith(isMapInitialized: true));


  }

  void moveCamera(LatLng newLocation){
    print('NEW LOCATION $newLocation');
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  Future drawMarkers() async{

    
  }


}
