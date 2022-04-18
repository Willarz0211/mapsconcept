import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_concept/blocs/blocs.dart';
import 'package:maps_concept/views/views.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  //late permite declarar sin inicializacion, dice que se hará set del valor inicial en algún punto
  late LocationBloc locationBloc;

  @override
  void initState() {
    super.initState();

    locationBloc = BlocProvider.of<LocationBloc>(context);

    // locationBloc.getCurrentPosition();
    locationBloc.startFollowingUser();
    //Retornar un objjeto de tipo latlng
  }

  @override
  void dispose() {

    // se destruye la vista y deja de escuchar la ubicacion
    locationBloc.stopFollowingUser();
    super.dispose();
  }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          
          if(state.lastKnownLocation == null) {
            return const Center(child: Text('Espere por favor...',
              style: TextStyle(fontSize: 25, fontWeight:  FontWeight.w300),),);
          }


          return SingleChildScrollView(
            child: Stack(
              children: [
                MapView(initialLocation: state.lastKnownLocation!,)
              ],
            ),
          );
        },
      ),
    );
  }
}