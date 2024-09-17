/* Single color page */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/color.dart' as ColorModel;
import '../providers/color_provider.dart';
import '../widgets/search_bar.dart';

class ColorDetailScreen extends StatelessWidget {
  final ColorModel.Color color;

  const ColorDetailScreen({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Detail'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          CustomSearchBar(),
          Expanded(
            child: ColorCard(color: color, isFullHeight: true),
          ),
        ],
      ),
    );
  }
}

class ColorCard extends StatelessWidget {
  final ColorModel.Color color;
  final bool isFullHeight;

  const ColorCard({Key? key, required this.color, this.isFullHeight = false})
      : super(key: key);

  Color _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(isFullHeight ? 16 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: _getColorFromHex(color.hex),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  color.ral,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  color.english,
                  style: TextStyle(fontSize: 16),
                ),
                if (isFullHeight) ...[
                  SizedBox(height: 8),
                  Text('German: ${color.german}'),
                  Text('French: ${color.french}'),
                  Text('Spanish: ${color.spanish}'),
                  Text('Italian: ${color.italian}'),
                  Text('Dutch: ${color.dutch}'),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
