class PastLocation {
  PastLocation({
    required this.pastlocations,
  });
  late final List<Pastlocations> pastlocations;
  
  PastLocation.fromJson(Map<String, dynamic> json){
    pastlocations = List.from(json['pastlocations']).map((e)=>Pastlocations.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['pastlocations'] = pastlocations.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Pastlocations {
  Pastlocations({
    required this.name,
    required this.timeUpdated,
  });
  late final String name;
  late final String timeUpdated;
  
  Pastlocations.fromJson(Map<String, dynamic> json){
    name = json['name'];
    timeUpdated = json['time_updated'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['time_updated'] = timeUpdated;
    return _data;
  }
}