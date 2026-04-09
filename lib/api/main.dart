import 'dart:convert';
import 'package:cnpj_getter/models/cnpj.dart';
import 'package:http/http.dart' as http;

Future<CnpjData?> apiCall(String cnpj) async {
  final url = Uri.parse('https://api.opencnpj.org/$cnpj');
  final response = await http.get(url);

  if (response.statusCode != 200) {
    return null;
  }
  final jsonMap = jsonDecode(response.body) as Map<String, dynamic>;
  final cnpjData = CnpjData.fromJson(jsonMap);
  return cnpjData;
}