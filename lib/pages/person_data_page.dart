import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/bottom_navigation_index_provider.dart';
import '../providers/person_selected_provider.dart';

class PersonDataPage extends ConsumerWidget {
  const PersonDataPage({super.key});

  static const textStyle = TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personSelectedWatcher = ref.watch(personSelectedProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          personSelectedWatcher == null
              ? Icons.manage_accounts_outlined
              : Icons.person_outline,
          size: 96,
          color: Colors.purple,
        ),
        if (personSelectedWatcher != null)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple.shade700),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Firstname: ${personSelectedWatcher.firstname}',
                  style: textStyle,
                ),
                Text(
                  'Lastname: ${personSelectedWatcher.lastname}',
                  style: textStyle,
                ),
                Text(
                  'DOB(yy-mm-dd): ${personSelectedWatcher.dob}',
                  style: textStyle,
                ),
                Text(
                  'Address: ${personSelectedWatcher.address}',
                  style: textStyle,
                ),
                Text(
                  'Province: ${personSelectedWatcher.province}',
                  style: textStyle,
                ),
              ],
            ),
          ),
        TextButton(
          onPressed: () {
            ref.read(bottomNavigationIndexProvider.notifier).state = 0;
          },
          child: Center(
            child: Text(
              personSelectedWatcher != null
                  ? 'Change selected person'
                  : 'Please select a person to view information.',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        if (personSelectedWatcher != null)
          TextButton(
            onPressed: () {
              ref.read(personSelectedProvider.notifier).state = null;
            },
            child: const Center(
              child: Text(
                'Clear',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
      ],
    );
  }
}
