import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/people_provider.dart';

class PersonListPage extends ConsumerStatefulWidget {
  const PersonListPage({super.key});

  @override
  PersonListPageState createState() => PersonListPageState();
}

class PersonListPageState extends ConsumerState<PersonListPage> {
  @override
  Widget build(BuildContext context) {
    final personProviderWatcher = ref.watch(peopleProvider);

    return Container(
      child: Column(
        children: [
          ...personProviderWatcher.map((person) {
            return Container(
              child: Text(person.firstname),
            );
          }),
        ],
      ),
    );
  }
}
