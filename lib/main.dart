import 'package:flutter/material.dart';
import 'package:nfc_app/home_view/home_view.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFC Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeView(),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   bool availability = false;

//   String availText = "";

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       availText =
//           "Please Click the button to Know the NFC Availability in your device!";
//     });
//   }

//   void _incrementCounter() async {
//     bool isAvailable = await NfcManager.instance.isAvailable();

//     if (isAvailable) {
//       print("NFC Scanning is supported in your device");
//       availText = "Congrats !!, NFC featured Supported in your device";
//     } else {
//       print("NFC Not supported in your device");
//       availText = "Sorry!! Your device is not supported for NFC Features";
//     }

//     setState(() {
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               child: Container(
//                 width: size.width,
//                 child: Text(
//                   availText,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'check availability',
//         child: const Icon(Icons.track_changes_sharp),
//       ),
//     );
//   }
// }
