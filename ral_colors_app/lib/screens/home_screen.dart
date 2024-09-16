/* Sets the initial / home page */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/color_provider.dart';
import '../widgets/color_card.dart';
import '../widgets/search_bar.dart';
import 'all_colors_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ColorProvider>().fetchColors());
  } // Fetch colors on init

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RAL Colors by Sigmund Frost'),
      ),
      body: Consumer<ColorProvider>(
        builder: (context, colorProvider, child) {
          if (colorProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (colorProvider.error != null) {
            return Center(
              child: Text('Error: ${colorProvider.error}'),
            );
          }
          return Column(
            children: [
              CustomSearchBar(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0), // Added horizontal padding
                  child: PageView.builder(
                    itemCount: (colorProvider.displayColors.length / 4).ceil(),
                    controller: PageController(
                        initialPage: colorProvider.currentIndex ~/ 4),
                    onPageChanged: (index) {
                      colorProvider
                          .updateDisplayColors(colorProvider.displayColors);
                      colorProvider.navigate('next');
                    },
                    itemBuilder: (context, pageIndex) {
                      final startIndex = pageIndex * 4;
                      return Column(
                        children: List.generate(4, (index) {
                          final colorIndex = startIndex + index;
                          if (colorIndex < colorProvider.displayColors.length) {
                            final color =
                                colorProvider.displayColors[colorIndex];
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical:
                                        8.0), // Added vertical padding between cards
                                child: ColorCard(color: color),
                              ),
                            );
                          }
                          return Expanded(child: SizedBox.shrink());
                        }),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  child: Text('Show all colors'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllColorsScreen()),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
