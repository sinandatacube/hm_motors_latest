import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hm_motors/url.dart';
import 'package:url_launcher/url_launcher.dart';

import 'delete_account.dart';

const _contactNumber = "+918921400916";

class Help extends StatelessWidget {
  const Help({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help"),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: () => launchPhone(),
            leading: const Icon(Icons.phone),
            title: const Text("Call"),
          ),
          ListTile(
            onTap: () => launchWhatsapp(),
            leading: const Icon(Icons.chat),
            title: const Text("WhatsApp"),
          ),
          ListTile(
            onTap: () => policyUrlLaunch(policyUrl),
            leading: const Icon(
              Icons.privacy_tip_outlined,
            ),
            title: const Text("Privacy policy"),
          ),
          ListTile(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AccountDelete(),
              ),
            ),
            leading: const Icon(Icons.delete_outline),
            title: const Text("Delete Account"),
          ),
        ],
      ),
    );
  }

//open privacypolicy webview
  policyUrlLaunch(String url) async {
    var uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $uri';
    }
  }

  //launch whatsapp
  launchWhatsapp() async {
    Uri url = Uri.parse("whatsapp://send?phone=$_contactNumber&text=Hi");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Fluttertoast.showToast(msg: "WhatsApp not installed");
    }
  }

//launch phone
  launchPhone() async {
    final uri = Uri(scheme: 'tel', path: _contactNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
