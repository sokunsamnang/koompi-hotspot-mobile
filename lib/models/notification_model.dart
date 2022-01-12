class NotificationModel {
  int id;
  String title;
  String category;
  String description;
  String date;
  String image;
  String accId;
  int vote;

  NotificationModel(Map<String, dynamic> data) {
    _fromJson(data);
  }

  void _fromJson(Map<String, dynamic> data) {
    id = data['_id'];
    title = data['title'];
    category = data['category'];
    description = data['description'];
    date = data['date'];
    image = data['image'];
    accId = data['accId'];
    vote = data['vote'];
  }
}
