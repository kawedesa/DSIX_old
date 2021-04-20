import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpinKitCubeGrid(
        size: MediaQuery.of(context).size.width * 0.25,
        color: Colors.grey[700],
      ),
    );
  }
}
