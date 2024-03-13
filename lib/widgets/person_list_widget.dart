import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_people_data_list_app/widgets/person_card.dart';

import '../providers/person_information_provider.dart';

class PersonListWidget extends ConsumerWidget {
  const PersonListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personInformationWatcher = ref.watch(personsList).list;

    return Container(
      key: const Key('PersonListWidget'),
      color: Colors.purple[50],
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...personInformationWatcher.map((person) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: PersonCard(person: person),
              );
            })
          ],
        ),
      ),
    );
  }
}
