class Contact {
  static const tblname = "contact";
  static const colId = "id";
  static const colName = "name";
  static const colPhone = "phone";
  static const colEmail = "email";

  int id;
  String name;
  String phone;
  String email;

  Contact({this.id, this.name, this.phone, this.email});

  Contact.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    name = map[colName];
    phone = map[colPhone];
    email = map[colEmail];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colName: name,
      colPhone: phone,
      colEmail: email
    };
    if (id != null) {
      map[colId] = id;
    }
    return map;
  }
}
