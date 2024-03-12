import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_people_data_list_app/pages/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

ThemeData _buildTheme(brightness) {
  var baseTheme = ThemeData(brightness: brightness);

  return baseTheme.copyWith(
    textTheme: GoogleFonts.kanitTextTheme(baseTheme.textTheme),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Personal Info App',
      theme: _buildTheme(Brightness.light),
      home: const MyHomePage(title: 'Personal Info App'),
    );
  }
}
