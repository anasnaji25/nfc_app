import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String resultMessage = "Result Will show here";

  ValueNotifier<dynamic> result = ValueNotifier(null);

  void _ndefWrite() {
    setState(() {
      resultMessage = 'Session Started';
    });
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        setState(() {
          resultMessage = 'Tag is not ndef writable';
        });
        NfcManager.instance.stopSession(errorMessage: resultMessage);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createText('Student ID (success call back)'),
      ]);

      try {
        await ndef.write(message);
        setState(() {
          resultMessage = 'Success to "Ndef Write"';
        });
        NfcManager.instance.stopSession();
      } catch (e) {
        setState(() {
          resultMessage = e.toString();
        });
        NfcManager.instance.stopSession(errorMessage: resultMessage.toString());
        return;
      }
    });
  }

  void _tagRead() {
    setState(() {
      resultMessage = 'Session Started';
    });
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      setState(() {
        result.value = tag.data;
        resultMessage =
            tag.data.entries.first.value + " " + tag.data.entries.last.value;
      });
      NfcManager.instance.stopSession();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("NFC Attendance"),
      ),
      floatingActionButton: InkWell(
          onTap: () {
            NfcManager.instance.stopSession();
            setState(() {
              resultMessage =
                  "session stopped , now use read or write with new session";
            });
          },
          child: Icon(
            Icons.restart_alt,
            size: 30,
            color: Colors.green,
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  width: size.width,
                  child: Text(
                    resultMessage,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
            ValueListenableBuilder<dynamic>(
              valueListenable: result,
              builder: (context, value, _) => Text('${value ?? ''}'),
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: _tagRead,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 106, 190, 238),
                      Color.fromARGB(255, 6, 209, 199),
                    ])),
                alignment: Alignment.center,
                child: const Text(
                  "Read",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: _ndefWrite,
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 124, 142, 247),
                      Color.fromARGB(255, 6, 26, 209),
                    ])),
                alignment: Alignment.center,
                child: const Text(
                  "Write",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
