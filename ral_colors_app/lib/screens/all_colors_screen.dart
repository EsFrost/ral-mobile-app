/* Sets the page for all colors coming from the API */
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/color_provider.dart';
import '../widgets/color_card.dart';

class AllColorsScreen extends StatefulWidget {
  @override
  _AllColorsScreenState createState() =>
      _AllColorsScreenState(); // State handling
}

class _AllColorsScreenState extends State<AllColorsScreen> {
  ScrollController _scrollController = ScrollController();
  bool _showBackToTopButton = false; // Back to top button

  /* If scrolled makes the button appear, else it stays false */
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 400 && !_showBackToTopButton) {
        setState(() {
          _showBackToTopButton = true;
        });
      } else if (_scrollController.offset < 400 && _showBackToTopButton) {
        setState(() {
          _showBackToTopButton = false;
        });
      }
    });
  }

  /* Disposes the scroll controller */
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  /* Appearance of the page */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All RAL Colors'),
      ),
      body: Consumer<ColorProvider>(
        builder: (context, colorProvider, child) {
          return GridView.builder(
            controller: _scrollController,
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75, // Adjusted for better card proportions
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: colorProvider.colors.length,
            itemBuilder: (context, index) {
              return ColorCard(color: colorProvider.colors[index]);
            },
          );
        },
      ),
      floatingActionButton: _showBackToTopButton
          ? FloatingActionButton(
              onPressed: _scrollToTop,
              child: Icon(Icons.arrow_upward),
              tooltip: 'Back to Top',
            )
          : null,
    );
  }
}
