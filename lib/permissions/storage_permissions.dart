import 'package:permission_handler/permission_handler.dart';

Future requestStoragePermission() async {
  // final serviceStatus = await Permission.storage.isGranted;

  // bool isStorageOn = (serviceStatus == ServiceStatus.enabled);

  final status = await Permission.storage.request();

  if (status == PermissionStatus.granted) {
    // print('Permission Granted');
    return "granted";
  } else if (status == PermissionStatus.denied) {
    // print('Permission  Denied');

    return "denied";
  } else if (status == PermissionStatus.permanentlyDenied) {
    // print('Permission Permanently Denied');
    return "permanently denied";
    // await openAppSettings();

  }
}
