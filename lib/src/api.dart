import 'dart:convert';
import 'package:http/http.dart' as http;

class Repository {
  final baseUrl = "http://c9.devclass.me:5000";

  Future<List> loadDoctorsList() async {
    const pathDoctors = "/doctors";
    http.Response response =
        await http.get(Uri.parse(baseUrl + pathDoctors), headers: {
      "Secret": "PBMOnly",
    });
    if (response.statusCode != 200) {
      throw Exception();
    }
    final decodeList = json.decode(response.body);
    return decodeList;
  }
}
