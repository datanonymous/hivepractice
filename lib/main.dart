import 'package:HIVEpractice/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'contact_page.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse
  // final appDocumentDirector =
  //     await path_provider.getApplicationDocumentsDirectory();
  // Hive.init(appDocumentDirector.path); //comments section on Youtube says that Hive.initFlutter() will automatically put app directory path into it
  await Hive.initFlutter();
  Hive.registerAdapter(ContactAdapter());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive Tutorial',
      home: FutureBuilder(
        future: Hive.openBox('contacts'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            //snapshot.connectionState == ConnectionState.done
            return ContactPage();
          } else if (snapshot.hasError) {
            return Icon(Icons.error_outline);
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    Hive.box('contacts').close(); //can also use Hive.close()
    super.dispose();
  }
}
