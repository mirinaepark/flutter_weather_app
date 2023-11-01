import 'package:http/http.dart' as http;
import 'dart:convert';

class Network {

  final String? url;
  final String? airUrl;

  Network(this.url, this.airUrl);

  Future<dynamic> getJsonData() async{

    http.Response response = await http.get(Uri.parse(url!));

    if(response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }

  }

  Future<dynamic> getAirJsonData() async{

    http.Response response = await http.get(Uri.parse(airUrl!));

    if(response.statusCode == 200) {
      String jsonData = response.body;
      var parsingData = jsonDecode(jsonData);
      return parsingData;
    }

  }
}