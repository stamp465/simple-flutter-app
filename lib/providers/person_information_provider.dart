import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:simple_people_data_list_app/data_models/person.dart';

import '../database/database.dart';

class PersonListNotifier extends ChangeNotifier {
  final persons = isarDB.persons;
  List<Person> list = [];

  ///?
  Future<void> init() async {
    await persons.where().findAll().then((value) {
      list.clear();
      list = value;
      notifyListeners();
    });
  }

  ///?
  Future<void> streamDB() async {
    Stream<void> stream = isarDB.persons.watchLazy();
    stream.listen((event) async {
      await persons.where().findAll().then((value) {
        list.clear();
        list = value;
        notifyListeners();
      });
    });
  }
}

final personsList =
    ChangeNotifierProvider<PersonListNotifier>((ref) => PersonListNotifier());
