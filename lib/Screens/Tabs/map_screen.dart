import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yellosky_assignment/Model/projectModel.dart';
import 'package:yellosky_assignment/Screens/project_detail_screen.dart';
import 'package:yellosky_assignment/secret.dart';



class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  List<ProjectModel> allProjects = [];
  final apiKey = Secrets.apiKey;

  @override
  void initState() {
    super.initState();
    fetchProjectsAndMarkers();
  }

  Future<void> fetchProjectsAndMarkers() async {
    final snapshot = await FirebaseFirestore.instance.collection('projects').get();
    final projects = snapshot.docs
        .map((doc) => ProjectModel.fromMap(doc.data(), doc.id))
        .toList();

    Set<Marker> markers = {};

    for (var project in projects) {
      if (project.location.isNotEmpty) {
        final lat = project.location[0];
        final lng = project.location[1];

        markers.add(
          Marker(
            markerId: MarkerId(project.id),
            position: LatLng(lat, lng),
            infoWindow: InfoWindow(
              title: project.name,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectDetailScreen(
                      proId: project.id,
                      projectName: project.name,
                      projectDesc: project.description,
                      projectlocation: project.locationName,
                      projectImage: 'https://miro.medium.com/v2/resize:fit:1100/format:webp/1*8Ts9_oEByDWlShu3kj9X9g.png',
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    }

    setState(() {
      allProjects = projects;
      _markers = markers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _markers.isEmpty
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  allProjects.first.location[0],
                  allProjects.first.location[1],
                ),
                zoom: 10,
              ),
              markers: _markers,
              onMapCreated: (controller) => _mapController = controller,
            ),
    );
  }
}
