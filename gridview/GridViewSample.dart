
import 'package:flutter/material.dart';

class GridViewScreen extends StatefulWidget {
  const GridViewScreen({super.key});

  @override
  State<GridViewScreen> createState() => GridViewState();
}

class GridViewState extends State<GridViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Column&Row Example')),
      body: Center(
        child: Container(
          width: 400,
          height: 400,
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 3, 76, 96),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(color: Colors.black, blurRadius: (5.0))
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Cell(),
                  Cell(),
                  Cell(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Cell(),
                  Cell(),
                  Cell(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Cell(),
                  Cell(),
                  Cell(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Cell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 2.0,
        ),
      ),
    );
  }
}