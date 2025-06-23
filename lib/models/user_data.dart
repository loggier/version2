// To parse this JSON data, do
//
//     final userData = userDataFromMap(jsonString);

import 'dart:convert';

class UserData {
    String? expirationDate;
    Manager? manager;
    String? logo;


    UserData({
        this.expirationDate,
        this.manager,
        this.logo,
    });

    factory UserData.fromJson(String str) => UserData.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        expirationDate: json["expiration_date"],
        manager: json["manager"] == null ? null : Manager.fromMap(json["manager"]),
        logo: json["logo"],
    );

    Map<String, dynamic> toMap() => {
        "expiration_date": expirationDate,
        "manager": manager?.toMap(),
        "logo": logo,

    };
}

class Manager {
    int? id;
    String? email;
    String? phoneNumber;
    dynamic telephone;
   
    Manager({
        this.id,
        this.email,
        this.phoneNumber,
        this.telephone,
    });

    factory Manager.fromJson(String str) => Manager.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Manager.fromMap(Map<String, dynamic> json) => Manager(
        id: json["id"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        telephone: json["telephone"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "email": email,
        "phone_number": phoneNumber,
        "telephone": telephone,
    };
}