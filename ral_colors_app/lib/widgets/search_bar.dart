import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/color_provider.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Search based on RAL or name',
          suffixIcon: Icon(Icons.search),
          border: OutlineInputBorder(),
        ),
        onChanged: (value) {
          context.read<ColorProvider>().search(value);
        },
      ),
    );
  }
}
