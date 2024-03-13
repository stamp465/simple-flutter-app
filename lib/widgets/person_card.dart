import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_people_data_list_app/data_models/person.dart';
import 'package:simple_people_data_list_app/providers/bottom_navigation_index_provider.dart';

import '../database/database.dart';
import '../providers/person_selected_provider.dart';

// ignore: must_be_immutable
class PersonCard extends ConsumerWidget {
  PersonCard({required this.person, this.showProvince = true, super.key});

  Person person;

  bool showProvince;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      key: const Key('PersonCard'),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              focusColor: Colors.purple,
              hoverColor: Colors.purple,
              key: const Key('PersonCardInkWell'),
              onTap: () {
                ref.read(personSelectedProvider.notifier).state = person;
                ref.read(bottomNavigationIndexProvider.notifier).state = 2;
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${person.firstname} ${person.lastname}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  if (showProvince) Text('Province: ${person.province}'),
                  const Text(
                    'Click this card for see more details...',
                    style: TextStyle(
                      color: Colors.purple,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            key: const Key('PersonCardDelete'),
            icon: const Column(
              children: [
                Icon(
                  Icons.delete_outline,
                  color: Colors.purple,
                  size: 20,
                ),
                Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
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
