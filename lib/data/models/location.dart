class LocationModel {
  final int id;
  final String type;
  final String title;

  LocationModel({ 
    this.id, 
    this.type, 
    this.title
  });

  LocationModel.fromJson(Map json)
      : id = json['entity_id'],
        type = json['entity_type'],
        title = json['title'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entity_type'] = this.type;
    data['title'] = this.title;
    return data;
  }
  // League.fromJson(Map<String, dynamic> json) {
  //   imageUrls = json['imageUrls'] != null
  //       ? new LeagueImageUrls.fromJson(json['imageUrls'])
  //       : null;
  //   abbrName = json['abbrName'];
  //   id = json['id'];
  //   imgUrl = json['imgUrl'];
  //   name = json['name'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.imageUrls != null) {
  //     data['imageUrls'] = this.imageUrls.toJson();
  //   }
  //   data['abbrName'] = this.abbrName;
  //   data['id'] = this.id;
  //   data['imgUrl'] = this.imgUrl;
  //   data['name'] = this.name;
  //   return data;
  // }

}

// List<LocationModel> locations = [
//   LocationModel(
//     id: 1, 
//     type: "Type One", 
//     title: "Paris"
//   ),
//   LocationModel(
//     id: 2, 
//     type: "Type Two", 
//     title: "Cali"
//   ),
//   LocationModel(
//     id: 3, 
//     type: "Type Three", 
//     title: "Tokyo"
//   ),
//   LocationModel(
//     id: 4, 
//     type: "Type Four", 
//     title: "Seoul"
//   ),
// ];

