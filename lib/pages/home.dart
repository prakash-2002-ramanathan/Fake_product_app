import 'package:demo/pages/verification.dart';
import 'package:demo/services/functions.dart';
import 'package:demo/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Client? httpClient;
  Web3Client? ethClient;
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infuraUrl, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Identify'),
        ),
        // ignore: avoid_unnecessary_containers
        body: Container(
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'enter your product id',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller2,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: 'enter your product name',
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
                    if (controller.text.isNotEmpty &&
                        controller2.text.isNotEmpty) {
                      await add(int.parse(controller.text), controller2.text,
                          ethClient!);
                    }
                  },
                  child: const Text('Enter Product in the system'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Verify()));
                  },
                  child: const Text('Move to verification page'),
                ),
              ),
            ],
          ),
        ));
  }
}
