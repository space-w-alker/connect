import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ui_elements/loading_view.dart';

class LoadingScreen extends StatefulWidget {
  final Map<String, AsyncCallback> load;

  LoadingScreen({this.load});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String currentLoading;

  @override
  void initState() {
    super.initState();
    currentLoading = "Loading...";
  }

  Future<void> loadAll() async {
    for (var loadName in widget.load.keys) {
      setState(() {
        currentLoading = loadName;
      });
      await widget.load[loadName]();
    }
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loadAll();
    });
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Stack(
        fit: StackFit.expand,
        children: [
          LoadingView(),
          Positioned(
            child: Text(
              currentLoading,
              style: TextStyle(color: Colors.grey[400]),
            ),
            bottom: 18,
            left: 18,
          ),
        ],
      ),
    );
  }
}
