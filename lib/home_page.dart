import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_ws_locations/locations_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: context.read<LocationsBloc>().mapController,
        options: MapOptions(
          zoom: 9.2,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.wslocations.app',
          ),
          BlocBuilder<LocationsBloc, LocationsStates>(
            builder: (context, state) {
              return MarkerLayer(
                markers: state.locations
                    .map((e) => Marker(
                          point: e,
                          height: 50,
                          width: 50,
                          anchorPos: AnchorPos.align(AnchorAlign.top),
                          builder: (context) {
                            return Icon(
                              Icons.location_on_rounded,
                              size: 50,
                            );
                          },
                        ))
                    .toList(),
              );
            },
          )
        ],
      ),
    );
  }
}
