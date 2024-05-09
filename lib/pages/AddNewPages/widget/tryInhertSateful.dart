import 'package:flutter/material.dart';

class c1 extends StatefulWidget {
  const c1({super.key});

  @override
  State<c1> createState() => _c1State();
}

class _c1State extends State<c1> {
  @override
  Widget build(BuildContext context) {
    return const Text("dd");
  }
}

class c2 extends c1 {
  const c2({super.key});

  @override
  State<c1> createState() => _c2State();
}

class _c2State extends _c1State {}
