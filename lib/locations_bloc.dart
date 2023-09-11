import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

class LocationsBloc extends Bloc<LocationsEvents, LocationsStates> {
  LocationsBloc() : super(LocationsStates(locations: [])) {
    on<NewLocationState>((event, emit) => null);
  }
}

abstract class LocationsEvents {}

class LocationsStates {
  final List<LatLng> locations;

  LocationsStates({required this.locations});
}

class NewLocationState extends LocationsEvents {
  final LatLng location;

  NewLocationState({required this.location});
}
