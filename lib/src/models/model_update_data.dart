import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:koompi_hotspot/src/backend/api_service.dart';
import 'package:koompi_hotspot/src/models/model_userdata.dart';

class UpdateUserData{

  Future<ModelUserData> updateData(String fullname) async {
    final http.Response response = await http.put('${ApiService.url}/dashboard',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'full_name': fullname,
      }),
    );

    if (response.statusCode == 200) {
      return ModelUserData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update data.');
    }
  }

}