import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_people_data_list_app/widgets/person_card.dart';

import '../data_models/person.dart';
import '../providers/people_provider.dart';

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
    final personProviderWatcher = ref.watch(peopleProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          ...getMapPeopleByProvince(personProviderWatcher)
              .entries
              .toList()
              .map((data) {
            return Column(
              children: [
                Text('จังหวัด: ${data.key}'),
                ...data.value.map((person) {
                  return PersonCard(person: person);
                })
              ],
            );
          }),
        ],
      ),
    );
  }
}
