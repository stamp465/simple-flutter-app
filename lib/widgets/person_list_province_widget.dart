import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_people_data_list_app/widgets/person_card.dart';

import '../data_models/person.dart';
import '../providers/person_information_provider.dart';

class PersonListByProvinceWidget extends ConsumerWidget {
  const PersonListByProvinceWidget({super.key});

  Map<String, List<Person>> getMapPeopleByProvince(List<Person> people) {
    Map<String, List<Person>> mapPeopleByProvince = {};
    for (int i = 0; i < people.length; i++) {
      if (mapPeopleByProvince[people[i].province] == null) {
        mapPeopleByProvince[people[i].province] = [people[i]];
      } else {
        mapPeopleByProvince[people[i].province]!.add(people[i]);
      }
    }
    return mapPeopleByProvince;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personInformationWatcher = ref.watch(personsList).list;

    return Container(
      key: const Key('PersonListByProvinceWidget'),
      color: Colors.purple[50],
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...getMapPeopleByProvince(personInformationWatcher)
                .entries
                .toList()
                .map((data) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      color: Colors.purple,
                      child: Text(
                        'Province: ${data.key}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    ...data.value.map((person) {
                      return PersonCard(
                        person: person,
                        showProvince: false,
                      );
                    })
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
