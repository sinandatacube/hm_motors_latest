import 'package:flutter/material.dart';
import 'package:hm_motors/global_variables.dart';

class Support extends StatelessWidget {
  const Support({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Support"),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: height * 0.1,
        ),
        Center(
          child: Image.asset(
            "assets/customer-service.png",
            height: 250,
            width: 250,
          ),
        ),
        SizedBox(
          height: height * 0.05,
        ),
        const Text(
          "How can we help you?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            width: width * 0.7,
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(50)),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/headphones.png"),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Call Support",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: height * 0.03,
        ),
        Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            width: width * 0.7,
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(), borderRadius: BorderRadius.circular(50)),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/technical-support.png"),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Chat Support",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //   children: [
        //     CircleAvatar(
        //       radius: 50,
        //       child: Image.asset("assets/headphones.png"),
        //     ),
        //     Container(
        //       height: 100,
        //       width: 130,
        //       decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(15),
        //           border: Border.all()),
        //       child: Image.asset(
        //         "assets/technical-support.png",
        //         // height: 50,
        //         // width: 50,
        //       ),
        //     )
        //   ],
        // )
      ],
    );
  }
}
