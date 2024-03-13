import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/person_information_provider.dart';

class PersonDataPage extends ConsumerWidget {
  const PersonDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(personInformationProvider);
    return const Text('Person Data Page');
  }
}
