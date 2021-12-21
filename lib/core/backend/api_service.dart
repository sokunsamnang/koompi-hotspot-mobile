class ApiService {
  static final url = 'https://api-hotspot.koompi.org/api';
  static final getAvatar = 'https://api-hotspot.koompi.org/uploads';
  static final notiImage = 'https://api-hotspot.koompi.org/uploads/noti';
}

class ApiHeader {
  static const headers = <String, String>{
    "accept": "application/json",
    "Content-Type": "application/json"
  };
}
