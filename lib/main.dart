import 'package:famoo/Main.dart';
import 'package:famoo/pages/pages.dart';

export 'package:flutter/material.dart';
export 'package:famoo/theme.dart';
export 'package:provider/provider.dart';
export 'package:famoo/local_storage_service.dart';
export 'package:famoo/classes.dart';


List<Item> clothesItems = [];
Map<String, dynamic> settings = {'darkMode': false, 'addlogo': true};

int idnum = 0;
String get getid {
  final int id = idnum;
  idnum++;
  return id.toString().padLeft(5, '0');
}

Map<String, double> dress = {
  "Bust circ": 0,
  "Waist circ": 0,
  "Hip circ": 0,
  "Front length": 0,
  "Back length": 0,
  "Bust height": 0,
  "Bust distance": 0,
  "Hip height": 0,
  "Shoulder width": 0,
  "Back width": 0,
  "Sleeves length": 0,
  "Wrist circ": 0,
  "Muscle circ": 0,
  "Knee length": 0,
  "Dress length": 0,
  "Height": 0,
};
Map<String, double> jacket = {
  "Bust circ": 0,
  "Waist circ": 0,
  "Hip circ": 0,
  "Front length": 0,
  "Back length": 0,
  "Bust height": 0,
  "Bust  distance": 0,
  "Hip height": 0,
  "Shoulder width": 0,
  "Back width": 0,
  "Sleeves length": 0,
  "Wrist circ": 0,
  "Muscle circ": 0,
  "Jacket length": 0,
  "Height": 0,
};
Map<String, double> pants = {
  "Waist circ": 0,
  "Hip circ": 0,
  "Hip height": 0,
  "Crotch height": 0,
  "Knee length": 0,
  "Pants length": 0,
  "Height": 0,
};

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalStorageService.instance.init();
  clothesItems = LocalStorageService.instance.loadItems((Item.fromMap));
  settings = LocalStorageService.instance.loadSettings();
  runApp(ChangeNotifierProvider(create: (context)=> ThemeProvider(),child:  MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: App());
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      title: 'Aya Size-Chart',
      home: Pages(),
      // Scaffold(
      //   body: Text(""),
      // ),
    );
  }
}

extension CapitalizeExtension on String {
  String toCapitalCase() {
    if (isEmpty) return "";
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

// class MyWidget extends StatelessWidget {
//   const MyWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: Scaffold(body: Container(height: 100,width: 200,color: Colors.amber,),),);
//   }
// }
