import 'dart:convert';

String jsonPrettier(Map<String, dynamic> data) {
  final String jsonString = const JsonEncoder.withIndent('  ').convert(data);
  return jsonString;
}
