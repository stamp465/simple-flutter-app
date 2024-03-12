class Person {
  /// constructor
  Person({
    required this.firstname,
    required this.lastname,
    required this.address,
  });

  final String firstname;
  final String lastname;
  final String? address;

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      firstname: json['firstname'],
      lastname: json['lastname'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['address'] = address;
    return data;
  }
}
