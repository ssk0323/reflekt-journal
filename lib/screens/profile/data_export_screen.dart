import 'package:flutter/material.dart';

class DataExportScreen extends StatefulWidget {
  const DataExportScreen({Key? key}) : super(key: key);

  @override
  _DataExportScreenState createState() => _DataExportScreenState();
}

class _DataExportScreenState extends State<DataExportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('データエクスポート'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text('データエクスポート画面 - 準備中'),
      ),
    );
  }
}
