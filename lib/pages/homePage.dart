import "package:flutter/material.dart";

class HomePage extends StatelessWidget {
  const HomePage() : super();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        gridDelegate:
            SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 20),
        children: [],
      ),
    );
  }
}
