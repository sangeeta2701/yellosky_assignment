import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String id;
  final String name;
  final String description;
  final String locationName;
  final List<double> location;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.locationName,
    required this.location,
  });

  // factory ProjectModel.fromMap(Map<String, dynamic> data, String docId) {
  //   return ProjectModel(
  //     id: docId,
  //     name: data['proName'] ?? '',
  //     description: data['proDesc'] ?? '',
  //     locationName: data['locationName'] ?? '',
  //     location: List<double>.from(data['proLocation'] ?? [0.0, 0.0]),
  //   );
  // } 

  factory ProjectModel.fromMap(Map<String, dynamic> data, String docId) {
  final geoPoint = data['proLocation'] as GeoPoint?;

  return ProjectModel(
    id: docId,
    name: data['proName'] ?? '',
    description: data['proDesc'] ?? '',
    locationName: data['locationName'] ?? '',
    location: geoPoint != null ? [geoPoint.latitude, geoPoint.longitude] : [0.0, 0.0],
  );
}

}
