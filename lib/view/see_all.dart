import 'package:flutter/material.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:hm_motors/list.dart';

class Seeall extends StatelessWidget {
  const Seeall({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Brands"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(vertical: height * 0.01),
        itemCount: brands.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1),
        itemBuilder: (context, index) {
          var current = brands[index];
          return Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(current["image"])),
                  Text(current["name"])
                ],
              ),
            ),
          );
        });
  }
}
