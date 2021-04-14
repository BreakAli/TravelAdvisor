import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerInformation {
  final String name;
  final String image;
  final String description;
  final LatLng location;

  MarkerInformation(
      this.name,
      this.image,
      this.description,
      this.location,
      );


}