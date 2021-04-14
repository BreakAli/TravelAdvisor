import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:travel_advisor/model/MarkerInformationWindow.dart';
import 'package:travel_advisor/model/MarkerInformation.dart';

// Ali's Task - April 1
class MapPage extends StatefulWidget {
  static String x = "Yellowstone National Park";
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  GoogleMapController mapController;
  // Holds initial position of map (in this case Yellowstone)
  LatLng _initialPosition = const LatLng(
      44.423691, -110.588516); // Yellow stone coords: 44.4280° N, 110.5885° W


  // Title of national park passed from HomePage
  String title = "";





  // Set of markers for scenic spots
  Set<Marker> scenicSpots = {};

  @override
  void didUpdateWidget(MapPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget IS " + MapPage.x);
    scenicSpots = {};


  }

  Map<String, MarkerInformation> chosenMarkerList = {};

  LatLng initial1 = LatLng(37.59587, -112.18724);
  Map<String, MarkerInformation> _markerList1 = {
    "sunrisePoint": MarkerInformation(
        'Sunrise Point',
        "assets/BC-SunrisePoint.jpg",
        'Beautiful view of the legendary rock formations',
        LatLng(37.62835, -112.16293)
    ),
    "brycePoint": MarkerInformation(
        'Bryce Point',
        "assets/BC-BrycePoint.jpg",
        'Enjoy an amazing view of Bryce amphitheater',
        LatLng(37.604361,-112.159528)
    ),
    "mossyWindow": MarkerInformation(
        'Mossy Window',
        "assets/BC-MossyWindow.jpg",
        'Rock formation view with a mossy outline',
        LatLng(37.665472,-112.112778)
    ),
    "farviewPoint": MarkerInformation(
        'Farview Point',
        "assets/BC-FairviewPoint.jpg",
        'Great view of valleys, rock ridges, and the sun',
        LatLng(37.544306,-112.244278)
    ),
    "naturalBridge": MarkerInformation(
        'Natural Bridge',
        "assets/BC-NaturalBridge.jpg",
        'Naturally formed arched in the rock formations',
        LatLng(37.620194,-112.161417)
    )
  };

  LatLng initial2 = LatLng(37.7555,-119.5491);
  Map<String, MarkerInformation> _markerList2 = {
    "elCapitan": MarkerInformation(
        'El Capitan',
        "assets/YO-ElCapitan.jpg",
        'Must-see 3,000 ft mountain',
        LatLng(37.73395, -119.63775)
    ),
    "veranalFall": MarkerInformation(
        'Vernal Fall',
        "assets/YO-VernalFalls.jpg",
        'Popular hiking route with a waterfall',
        LatLng(37.7275,-119.54388)
    ),
    "glacierPoint": MarkerInformation(
        'Glacier Point',
        "assets/YO-GlacierPoint.jpg",
        'Amazing view of the Half Dome and High Sieera',
        LatLng(37.7274, -119.57432)
    ),
    "mirrorLake": MarkerInformation(
        'Mirror Lake',
        "assets/YO-MirrorLake.jpg",
        'Stunning mirror view of the Half Dome',
        LatLng(37.7485,-119.5491)
    ),
    "yosemiteFalls": MarkerInformation(
        'Yosemite Falls',
        "assets/YO-YosemiteFalls.jpg",
        'Legendary waterfall made up of three waterfalls',
        LatLng(37.75671, -119.59684)
    )
  };

  LatLng initial3 = LatLng(37.300710, -113.024016);
  Map<String, MarkerInformation> _markerList3 = {
    "zionCanyon": MarkerInformation(
        'Zion Canyon',
        "assets/ZI-ZionCanyon.jpg",
        'Beautiful canyon with roads on the canyon floor',
        LatLng(37.423717, -113.153551)
    ),
    "zionHighway": MarkerInformation(
        'Zion-Mount Highway',
        "assets/ZI-ZionHighway.jpg",
        'Highway drive with amazing view of the mountainside',
        LatLng(37.209935, -112.956692)
    ),
    "weepingRock": MarkerInformation(
        'Weeping Rock',
        "assets/ZI-WeepingRock.jpg",
        'Dripping stone overhang with hanging gardens',
        LatLng(37.271423, -112.936527)
    ),
    "emeraldPools": MarkerInformation(
        'Lower Emerald Pools',
        "assets/ZI-EmeraldPools.jpg",
        'Gorgeous walkway through nature',
        LatLng(37.248342, -112.959278)
    ),
    "checkerboardMesa": MarkerInformation(
        'Checkerboard Mesa',
        "assets/ZI-CheckerboardMesa.jpg",
        'White-colored mesa with stones up the mountain side',
        LatLng(37.225508, -112.880595)
    )
  };

  LatLng initial7 = LatLng(44.4280, -110.5885);
  Map<String, MarkerInformation> _markerList7 = {
    "oldFaithful": MarkerInformation(
        'Old Faithful',
        "assets/YS-OldFaithful.jpg",
        'Historic geyser and popular tourist attraction',
        LatLng(44.4605, -110.8281)
    ),
    "mammothHotSprings": MarkerInformation(
        'Mammoth Hot Spring',
        "assets/YS-MammothHotSprings.jpg",
        'Exciting thermal hot springs that can reach up to 165°F',
        LatLng(44.9769, -110.6991)
    ),
    "mountWashburn": MarkerInformation(
        'Mount Washburn',
        "assets/YS-MountWashburn.jpg",
        'Mountain that peaks at 10,243 ft with an amazing view',
        LatLng(44.7977, -110.4344)
    ),
    "mudVolcano": MarkerInformation(
        'Mud Volcano',
        "assets/YS-MudVolcano.jpg",
        'Historic geyser and popular tourist attraction',
        LatLng(44.6249, -110.4336)
    ),
    "yellowStoneLake": MarkerInformation(
        'YellowStone Lake',
        "assets/YS-YellowstoneLake.jpg",
        'Largest high elevation lake in North America',
        LatLng(44.4622, -110.3333)
    )
  };



  final double _infoWindowWidth = 250;
  final double _markerOffset = 170;

  @override
  Widget build(BuildContext context) {
    print("build() x is " + MapPage.x);
    final providerObject =
        Provider.of<MarkerInformationWindow>(context, listen: false);



    switch(MapPage.x) {
      case "Bryce Canyon National Park":
        chosenMarkerList = _markerList1;
        _initialPosition = initial1;
        break;
      case "Yosemite National Park":
        chosenMarkerList = _markerList2;
        _initialPosition = initial2;
        break;
      case "Zion National Park":
        chosenMarkerList = _markerList3;
        _initialPosition = initial3;
        break;
      case "Yellowstone National Park":
        chosenMarkerList = _markerList7;
        _initialPosition = initial7;
        break;
      default:
        break;
    }

    chosenMarkerList.forEach((key, value) {
      scenicSpots.add(
        Marker(
          markerId: MarkerId(value.name),
          position: value.location,
          onTap: () {
            providerObject.updateInfoWindow(
              context,
              mapController,
              value.location,
              _infoWindowWidth,
              _markerOffset,
            );
            providerObject.updateMarkerInformation(value);
            providerObject.updateVisibility(true);
            providerObject.rebuildInfoWindow();
          }, // onTap
        ),
      );
    });

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Map Page"),
        ),
        body: Container(
          child: Consumer<MarkerInformationWindow>(
            builder: (context, model, child) {
              return Stack(
                children: [
                  child,
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Visibility(
                      visible: providerObject.showInfoWindow,
                      child: (providerObject.markerInformation == null ||
                              !providerObject.showInfoWindow)
                          ? Container()
                          : Container(
                              margin: EdgeInsets.only(
                                left: providerObject.leftMargin,
                                top: providerObject.topMargin,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.green,
                                          Colors.brown,
                                        ],
                                        end: Alignment.bottomCenter,
                                        begin: Alignment.topCenter,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 1.0),
                                            blurRadius: 6.0),
                                      ],
                                    ),
                                    height: 115,
                                    width: 250,
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          providerObject
                                              .markerInformation.image,
                                          height: 75,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              providerObject
                                                  .markerInformation.name,
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            FlatButton(
                                              onPressed: () {
                                                print(providerObject
                                                    .markerInformation.name);

                                              },
                                              child: Text('More Information'),
                                              color: Colors.brown,
                                              textColor: Colors.white,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ),
                  ),
                ],
              );
            },
            child: Positioned(
              child: GoogleMap(
                onTap: (position) {
                  if (providerObject.showInfoWindow) {
                    providerObject.updateVisibility(false);
                    providerObject.rebuildInfoWindow();
                  }
                },
                onCameraMove: (position) {
                  if (providerObject.markerInformation != null) {
                    providerObject.updateInfoWindow(
                        context,
                        mapController,
                        providerObject.markerInformation.location,
                        _infoWindowWidth,
                        _markerOffset);
                    providerObject.rebuildInfoWindow();
                  }
                },
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                  print("MAP CREATED x is " + MapPage.x);
                  scenicSpots = {};
                },
                markers: scenicSpots,
                initialCameraPosition: CameraPosition(
                  target: _initialPosition,
                  zoom: 9.0,
                ),
              ),
            ),
          ),
        ));
  }
} // end mapPageState

