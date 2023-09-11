import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class MarkerItem extends Marker {
  MarkerItem({
    required super.point,
  }) : super(
          builder: (context) {
            return const Icon(
              Icons.location_on_rounded,
              size: 50,
            );
          },
          height: 50,
          width: 50,
          anchorPos: AnchorPos.align(AnchorAlign.top),
        );
}
