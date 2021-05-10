import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitWave(
      color: Colors.grey[200],
      size: 25,
    );
  }
}
