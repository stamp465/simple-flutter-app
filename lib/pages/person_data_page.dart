import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/bottom_navigation_index_provider.dart';
import '../providers/person_selected_provider.dart';

class PersonDataPage extends ConsumerWidget {
  const PersonDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personSelectedWatcher = ref.watch(personSelectedProvider);

    return SingleChildScrollView(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              ref.read(bottomNavigationIndexProvider.notifier).state = 0;
            },
            child: Center(
              child: Text(personSelectedWatcher != null
                  ? 'เปลี่ยนตัวเลือก'
                  : 'กรุณาเลือกบุคคลเพื่อดูข้อมูล'),
            ),
          ),
          if (personSelectedWatcher != null)
            Container(
              child: Column(
                children: [
                  Text('ชื่อ: ${personSelectedWatcher.firstname} '
                      'นามสกุล: ${personSelectedWatcher.lastname}'),
                  Text('วันเกิด(ปี-เดือน-วัน): ${personSelectedWatcher.dob}'),
                  Text('ที่อยู่: ${personSelectedWatcher.address}'),
                  Text('จังหวัด: ${personSelectedWatcher.province}'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
