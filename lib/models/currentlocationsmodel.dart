
class LocationEntry {
  LocationEntry({
    required this.currentLocation,
  });
  late final List<CurrentLocation> currentLocation;
  
  LocationEntry.fromJson(Map<String, dynamic> json){
    currentLocation = List.from(json['current_location']).map((e)=>CurrentLocation.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_location'] = currentLocation.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CurrentLocation {
  CurrentLocation({
    required this.user,
    required this.userId,
    required this.streetName,
    required this.images,
    required this.entries,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });
  late final String user;
  late final String userId;
  late final String streetName;
  late final String images;
  late final String entries;
  late final double latitude;
  late final double longitude;
  late final String timestamp;
  
  CurrentLocation.fromJson(Map<String, dynamic> json){
    user = json['user'];
    userId = json['user_id'];
    streetName = json['street_name'];
    images = json['images'];
    entries = json['entries'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user;
    _data['user_id'] = userId;
    _data['street_name'] = streetName;
    _data['images'] = images;
    _data['entries'] = entries;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['timestamp'] = timestamp;
    return _data;
  }
}