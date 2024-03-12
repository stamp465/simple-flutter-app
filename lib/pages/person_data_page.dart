import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/people_provider.dart';

class PersonDataPage extends ConsumerWidget {
  const PersonDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personProviderWatcher = ref.watch(peopleProvider);
    return Container(
      child: Text('Person Data Page'),
    );
  }
}
