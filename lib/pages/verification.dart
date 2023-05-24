import 'package:http/http.dart';
import 'package:demo/utils/constants.dart';
import 'package:demo/pages/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:web3dart/web3dart.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import '../services/functions.dart';

class Verify extends StatefulWidget {
  const Verify({super.key});

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  Client? httpClient;
  Web3Client? ethClient;

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infuraUrl, httpClient!);
    super.initState();
  }

  String? result = "Hello World...!";

  Future _scanQR() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isGranted) {
      try {
        String? cameraScanResult = await scanner.scan();
        setState(() {
          result =
              cameraScanResult; // setting string result with cameraScanResult
        });
      } on PlatformException catch (e) {
        // ignore: avoid_print
        print(e);
      }
    } else {
      var isGrant = await Permission.camera.request();
      if (isGrant.isGranted) {
        try {
          String? cameraScanResult = await scanner.scan();
          setState(() {
            result =
                cameraScanResult; // setting string result with cameraScanResult
          });
        } on PlatformException catch (e) {
          // ignore: avoid_print
          print(e);
        }
      }
    }
  }

  void setdata(String x) {
    setState(() {
      name = x;
    });
  }

  TextEditingController controller = TextEditingController();
  var name = "Yet to scan";
  List<Info> myInfo = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Block Verify"),
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150.0,
              width: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(180.0),
              ),
              child: FractionalTranslation(
                translation: const Offset(0.0, -0.5),
                child: Image.network(
                  'https://i.etsystatic.com/26414773/c/786/625/174/57/il/85a7d6/3807920725/il_340x270.3807920725_jogx.jpg',
                  height: 300.0,
                  width: 300.0,
                ),
              ),
            ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: ' Product ID ',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  //showAlertDialog(context);
                  if (controller.text.isNotEmpty) {
                    List<dynamic> x =
                        await detail(int.parse(controller.text), ethClient!);
                    myInfo.clear();
                    if (x[0].isEmpty) {
                      setdata("fake");
                    } else {
                      for (int i = 0; i < x[0].length; i++) {
                        BigInt timeInMilliseconds = x[0][i][5];
                        DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(
                            timeInMilliseconds.toInt());
                        String nt = DateFormat('HH:mm:ss').format(dateTime);

                        myInfo.add(Info(x[0][i][0], x[0][i][1], x[0][i][2],
                            x[0][i][3], x[0][i][4], nt, x[0][i][6]));
                      }
                      setdata("Not fake");
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DisplayList(newList: myInfo)));
                      //Navigator.pop(context);
                    }
                  }
                },
                child: const Text("Verify"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () async {
                  await _scanQR();
                  controller.text = result!;
                },
                child: const Text("Use Scanner"),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[300],
              ),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: Color.fromARGB(255, 25, 24, 24),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
