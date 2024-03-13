import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_people_data_list_app/data_models/person.dart';

late Isar isarDB;

Future<void> isarInit() async {
  final dir = await getApplicationSupportDirectory();
  isarDB = await Isar.open(
    [PersonSchema],
    directory: dir.path,
    inspector: !kReleaseMode,
  );
}
