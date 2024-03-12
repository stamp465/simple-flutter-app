class Person {
  /// constructor
  Person({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.province,
  });

  final int id;
  final String firstname;
  final String lastname;
  final String address;
  final String province;

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      address: json['address'],
      province: json['province'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['address'] = address;
    data['province'] = province;
    return data;
  }
}
