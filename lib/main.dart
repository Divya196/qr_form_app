import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Form App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QRFormPage(),
    );
  }
}

class QRFormPage extends StatefulWidget {
  @override
  _QRFormPageState createState() => _QRFormPageState();
}

class _QRFormPageState extends State<QRFormPage> {
  final _formKey = GlobalKey<FormState>();
  String name = '', role = '', company = '', qrData = '';
  Database? _db;

  @override
  void initState() {
    super.initState();
    initDatabase();
  }

  Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, 'userdata.db');
    _db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE User(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, role TEXT, company TEXT)',
      );
    });
  }

  Future<void> saveToDB(String name, String role, String company) async {
    await _db?.insert('User', {'name': name, 'role': role, 'company': company});
  }

  Future<void> handleSubmit() async {
    if (name.isEmpty || role.isEmpty || company.isEmpty) return;
    qrData = '$name|$role|$company';
    await saveToDB(name, role, company);
    setState(() {});
  }

  Future<void> scanQR() async {
    String scanned = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.QR);

    if (scanned != '-1') {
      List<String> parts = scanned.split('|');
      String result = 'Name: ${parts[0]}\nRole: ${parts[1]}\nCompany: ${parts[2]}';
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Scanned Data"),
          content: Text(result),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('QR Code Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onChanged: (val) => name = val,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Role'),
                  onChanged: (val) => role = val,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Company'),
                  onChanged: (val) => company = val,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: handleSubmit,
                  child: Text('Submit & Generate QR'),
                ),
                SizedBox(height: 20),
                if (qrData.isNotEmpty)
                  QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 200,
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: scanQR,
                  child: Text('Scan QR'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
