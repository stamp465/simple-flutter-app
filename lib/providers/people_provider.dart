import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_people_data_list_app/data_models/person.dart';

final peopleProvider = StateProvider<List<Person>>((ref) {
  return [];
});
