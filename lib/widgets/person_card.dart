import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_people_data_list_app/data_models/person.dart';

import '../database/database.dart';

// ignore: must_be_immutable
class PersonCard extends ConsumerWidget {
  PersonCard({required this.person, super.key});

  Person person;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text('ชื่อ-สกุล: ${person.firstname} ${person.lastname}'),
              Text('วันเกิด: ${person.dob}'),
              Text('ทีอยู่: ${person.address}'),
              Text('จังหวัด: ${person.province}'),
            ],
          ),
          IconButton(
            icon: const Text('ลบ'),
            onPressed: () async {
              await isarDB.writeTxn(() async {
                await isarDB.persons.delete(person.id);
              });
            },
          ),
        ],
      ),
    );
  }
}
