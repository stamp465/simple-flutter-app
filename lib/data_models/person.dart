import 'package:isar/isar.dart';

part 'person.g.dart';

@Collection()
class Person {
  Id id = Isar.autoIncrement;

  late String firstname;
  late String lastname;
  late String address;
  late String province;
  late String dob;

  @override
  String toString() {
    return 'Contact{id: $id, firstname: $firstname, lastname: $lastname, '
        'address: $address, province: $province, dob: $dob}';
  }
}
