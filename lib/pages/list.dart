import 'package:flutter/material.dart';

import '../services/functions.dart';

class DisplayList extends StatefulWidget {
  List<Info>? newList;
  DisplayList({super.key, required this.newList});

  @override
  State<DisplayList> createState() => _DisplayListState();
}

class _DisplayListState extends State<DisplayList> {
  @override
  Widget build(BuildContext context) {
    // for (Info info in widget.newList) {
    //   print('ID: ${info.id}');
    //   print('Name: ${info.product}');
    //   print('Address: ${info.manufacturer}');
    //   print('-----------------------');
    // }
    return Scaffold(
      appBar: AppBar(
        title: const Text("product history"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.newList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFF6F1F1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0), // set the padding here
                        child: ListTile(
                          title: Text(
                            'Product : ${widget.newList![index].product}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 19, 19, 19),
                              fontSize: 20,
                              height: 1.5,
                            ),
                          ),
                          subtitle: Text(
                            'Source: ${widget.newList![index].source}\nDestination: ${widget.newList![index].destination}\nRemark: ${widget.newList![index].remark}\nTime Stamp: ${widget.newList![index].time}\nWallet Address: ${widget.newList![index].address.hex}',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 19, 19, 19),
                              height: 1.5,
                            ),
                          ),
                          leading: const Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
