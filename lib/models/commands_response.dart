import 'dart:convert';

class CommandsResponse {
  String? type;
  String? title;
  String? defaultData;

  CommandsResponse({
    this.type,
    this.title,
    this.defaultData,
  });

  factory CommandsResponse.fromJson(String str) =>
      CommandsResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CommandsResponse.fromMap(Map<String, dynamic> json) {
    // Asegúrate de que attributes sea una lista y accede al primer elemento si existe
    final attributes = json["attributes"] as List<dynamic>?;

    // Extrae el default del primer elemento de attributes o asigna "" si no está presente
    final defaultData = (attributes != null && attributes.isNotEmpty)
        ? attributes.first["default"] ?? ""
        : "";
    print(defaultData);
    return CommandsResponse(
      type: json["type"],
      title: json["title"],
      defaultData: defaultData, // Asigna el valor seguro de defaultData
    );
  }

  Map<String, dynamic> toMap() => {
        "type": type,
        "title": title,
        "defaultData": defaultData,
      };
}
