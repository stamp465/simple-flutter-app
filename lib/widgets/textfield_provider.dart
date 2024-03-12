import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TextFieldProvider extends ConsumerWidget {
  const TextFieldProvider({
    required this.textController,
    required this.hintText,
    super.key,
  });

  final TextEditingController textController;
  final String hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: textController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: hintText,
      ),
      style: const TextStyle(fontSize: 20),
    );
  }
}
