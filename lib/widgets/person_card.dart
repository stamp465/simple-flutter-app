import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_people_data_list_app/data_models/person.dart';
import 'package:simple_people_data_list_app/providers/bottom_navigation_index_provider.dart';

import '../database/database.dart';
import '../providers/person_selected_provider.dart';

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
          InkWell(
            onTap: () {
              ref.read(personSelectedProvider.notifier).state = person;
              ref.read(bottomNavigationIndexProvider.notifier).state = 2;
            },
            child: Column(
              children: [
                Text('ชื่อ-สกุล: ${person.firstname} ${person.lastname}'),
                Text('จังหวัด: ${person.province}'),
                Text('คลิกเพื่อดูรายละเอียดเพิ่มเติม'),
              ],
            ),
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
