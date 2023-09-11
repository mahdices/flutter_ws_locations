import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_ws_locations/const.dart';
import 'package:latlong2/latlong.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class LocationsBloc extends Bloc<LocationsEvents, LocationsStates> {
  final wsUrl = Uri.parse(Const.baseUrl);
  WebSocketChannel? _channel;
  final mapController = MapController();

  LocationsBloc() : super(LocationsStates(locations: [])) {
    _connectAndListenSocket();

    on<NewLocationEvent>((event, emit) {
      final currentList = state.locations.toList();
      currentList.add(event.location);

      _changeMapCamera(currentList);
      emit(LocationsStates(locations: currentList));
    });
  }

  void _changeMapCamera(List<LatLng> currentList) {
    final center =
        mapController.centerZoomFitBounds(LatLngBounds.fromPoints(currentList));
    mapController.move(center.center, 9);
  }

  void _connectAndListenSocket() {
    _channel = WebSocketChannel.connect(wsUrl);
    _channel?.stream.listen((message) {
      _addNewLocationState(message as String);
    });
  }

  void _addNewLocationState(String message) {
    final latitude = double.parse(message.substring(0, message.indexOf(',')));
    final longitude = double.parse(message.substring(message.indexOf(',') + 1));
    final latlng = LatLng(latitude, longitude);
    add(NewLocationEvent(location: latlng));
  }

  @override
  Future<void> close() {
    _channel?.sink.close(status.goingAway);
    return super.close();
  }
}

abstract class LocationsEvents {}

class LocationsStates {
  final List<LatLng> locations;

  LocationsStates({required this.locations});
}

class NewLocationEvent extends LocationsEvents {
  final LatLng location;

  NewLocationEvent({required this.location});
}
