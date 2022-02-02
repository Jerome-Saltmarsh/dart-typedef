import 'dart:convert';

typedef Json = Map<String, dynamic>;

Json toJson(String source, {Object? Function(Object? key, Object? value)? reviver}){
  return jsonDecode(source, reviver: reviver);
}

extension JsonExtension on Json {
  double getDouble(String key) {
    if (!containsKey(key)) {
      throw Exception("json.getDouble($key). No key");
    }
    final value = this[key];
    if (value is num) {
      return value.toDouble();
    }
    if (value is String) {
      return double.parse(value);
    }
    if (value is bool) {
      return value ? 0.0 : 1.0;
    }
    throw Exception("could not parse $value to double");
  }

  String getString(String key){
    if (!containsKey(key)) {
      throw Exception("json.getString($key). No key");
    }
    final value = this[key];
    if (value is String){
      return value;
    }
    return value.toString();
  }

  bool getBool(String key){
    if (!containsKey(key)) {
      throw Exception("json.getBool($key). No key");
    }
    final value = this[key];
    if (value is bool){
      return value;
    }
    if (value is int){
      if (value == 0) return false;
      if (value == 1) return true;
      throw Exception("could not parse int $value to bool (1 or 0 only)");
    }
    if (value is double){
      if (value == 0) return false;
      if (value == 1.0) return true;
      throw Exception("could not parse double $value to bool (1 or 0 only)");
    }
    if (value is String){
      if (value.trim().toLowerCase() == 'true') return true;
      if (value.trim().toLowerCase() == 'false') return false;
      throw Exception("could not parse string $value to bool ('true' or 'false' only)");
    }

    throw Exception("could not parse value $value to bool");
  }

  String encode(){
    return jsonEncode(this);
  }
}
