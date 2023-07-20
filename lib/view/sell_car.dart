import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hm_motors/controller/sellcar_controller.dart';
import 'package:hm_motors/global_variables.dart';
import 'package:image_picker/image_picker.dart';

import '../permissions/storage_permissions.dart';

class SellCar extends StatefulWidget {
  const SellCar({super.key});

  @override
  State<SellCar> createState() => _SellCarState();
}

class _SellCarState extends State<SellCar> {
  TextEditingController brandController = TextEditingController();

  TextEditingController modelController = TextEditingController();

  TextEditingController yearController = TextEditingController();

  TextEditingController ownersController = TextEditingController();

  TextEditingController kmsController = TextEditingController();

  TextEditingController insuranceController = TextEditingController();

  TextEditingController tyrelifeController = TextEditingController();

  TextEditingController vehicleCondition = TextEditingController();
  TextEditingController varientController = TextEditingController();
  TextEditingController registrationNumberController = TextEditingController();
  TextEditingController expectedPriceController = TextEditingController();

  List<XFile> files = [];

  List<XFile> files2 = [];

  List<String> paths = [];

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 0,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.asset(
                      "assets/banner2 Sell.png",
                      // "assets/sell3.png",
                      // height: height * 0.2,
                      width: width,
                      fit: BoxFit.contain,
                    )),
                Container(
                  width: width,
                  height: 150,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(top: 9, left: width * 0.03),
                        child: const Text(
                          "How it works?",
                          style: TextStyle(
                              fontFamily: "Rubik",
                              fontWeight: FontWeight.w600,
                              fontSize: 17),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          howItWorksWidget(
                            "assets/Fill the Form1.png",
                            "Fill in the form",
                          ),
                          howItWorksWidget(
                            "assets/inspection2.png",
                            "Get your car\ninspected",
                          ),
                          howItWorksWidget(
                            "assets/sellit1.png",
                            "Sell your car \nand get paid",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.02, vertical: height * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      customTextField(context, 50, width * 0.9, "Brand",
                          "eg: Toyota", brandController, false),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      customTextField(context, 50, width * 0.9, "Model",
                          "eg: Fortuner", modelController, false),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      customTextField(context, 50, width * 0.9, "Varient",
                          "eg: VXi", varientController, false),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      customTextField(
                          context,
                          50,
                          width * 0.9,
                          "Registration number",
                          "eg: KL10A1234",
                          registrationNumberController,
                          false),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      customTextField(
                          context,
                          50,
                          width * 0.9,
                          "Year of Registration",
                          "eg: 2020",
                          yearController,
                          true),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      customTextField(context, 50, width * 0.9, "No .of owners",
                          "eg: 2", ownersController, true),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      customTextField(context, 50, width * 0.9, "Run kms",
                          "eg: 2000", kmsController, true),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      selectDate(),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      customTextField(
                          context,
                          50,
                          width * 0.9,
                          "Tyre Condition",
                          "eg: Good",
                          tyrelifeController,
                          false),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      customTextField(
                          context,
                          50,
                          width * 0.9,
                          "Vehicle Condition",
                          "eg: Good",
                          vehicleCondition,
                          false),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      customTextField(
                          context,
                          50,
                          width * 0.9,
                          "Expected price",
                          "eg:500000",
                          expectedPriceController,
                          true),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                        width: width,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Add images",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Rubik",
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '\n[Max 6 images]',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Rubik",
                                          color: Colors.grey.shade500)),
                                ],
                              ),
                            ),
                            // const Text(
                            //   "Add images",
                            //   style: TextStyle(
                            //       fontFamily: "Rubik",
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 17),
                            // ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              width: 60,
                              height: 30,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey.shade300,
                                      alignment: Alignment.center),
                                  onPressed: () async {
                                    //storage permission accessing
                                    var result =
                                        await requestStoragePermission();

                                    if (result == "granted") {
                                      try {
                                        //picking multiple images
                                        files = await _picker.pickMultiImage();

                                        // paths.clear();

                                        for (int i = 0; i < files.length; i++) {
                                          //way to add image again to cureent selected images
                                          files2.add(files[i]);
                                          //convert each photo into file
                                          File imageFile = File(files[i].path);
                                          //convert each photo into base64

                                          String imagebase64 = base64Encode(
                                              imageFile.readAsBytesSync());

                                          //adding each image into list
                                          paths.add(imagebase64);
                                          setState(() {});
                                        }
                                      } catch (e) {
                                        debugPrint(e.toString());
                                      }
                                    }
                                  },
                                  child: const Icon(Icons.add)),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      files2.isEmpty
                          ? const SizedBox.shrink()
                          : GridView.builder(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.04,
                                  vertical: height * 0.02),
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1,
                                crossAxisSpacing: width * 0.02,
                                mainAxisSpacing: height * 0.01,
                              ),
                              itemCount: files2.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var current = files2[index];
                                return Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.file(
                                        File(current.path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                        top: 0,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            paths.removeAt(index);
                                            // files.removeAt(index);
                                            files2.removeAt(index);
                                            setState(() {});
                                          },
                                          child: Card(
                                            elevation: 2,
                                            shape: const CircleBorder(),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color:
                                                        Colors.grey.shade200),
                                                child: const Icon(Icons.close)),
                                          ),
                                        ))
                                  ],
                                );
                              }),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      SizedBox(
                        width: width * 0.4,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: isSkip
                              ? () => Fluttertoast.showToast(
                                  msg: "Please login to continue ",
                                  backgroundColor: Colors.red.shade600)
                              : () {
                                  String brand = brandController.text.trim();
                                  String model = modelController.text.trim();
                                  String year = yearController.text.trim();
                                  String owners = ownersController.text.trim();
                                  String kms = kmsController.text.trim();
                                  String insurance =
                                      insuranceController.text.trim();
                                  String tyre = tyrelifeController.text.trim();
                                  String vehicle = vehicleCondition.text.trim();
                                  String registrationNumber =
                                      registrationNumberController.text.trim();
                                  String varient =
                                      varientController.text.trim();
                                  String expectedPrice =
                                      expectedPriceController.text.trim();
                                  SellCarController().validateform(
                                      brand,
                                      model,
                                      registrationNumber,
                                      year,
                                      owners,
                                      kms,
                                      insurance,
                                      tyre,
                                      vehicle,
                                      paths,
                                      userNumber,
                                      varient,
                                      expectedPrice,
                                      context);
                                },
                          child: const Text("Submit",
                              style: TextStyle(
                                  fontFamily: "Rubik",
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

////////////////////////////////////////// textfield widget /////////////////////////////////////////////
  Widget customTextField(BuildContext context, double h, double w, String title,
      String hint, TextEditingController controller, bool isNumber) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontFamily: "Rubik", fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: h,
          width: w,
          child: TextField(
            controller: controller,
            // onTap: () {},
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            textAlign: TextAlign.start,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(fontFamily: "Rubik"),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber.shade900),
                    borderRadius: BorderRadius.circular(5)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black54),
                    borderRadius: BorderRadius.circular(5))),
          ),
        ),
      ],
    );
  }

/////////////////////////////////////// BOTTOMSHEET  FUNCTIONS //////////////////////////////////////////
  selectManufacturingYear(
    BuildContext context,
    String title,
  ) {
    DateTime now = DateTime.now();
    int currentYear = now.year;
    List years = List.generate(100, (a) {
      int yearnow = currentYear - a;
      return yearnow;
    });
    showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        context: context,
        builder: (context) => Container(
              height: height * 0.7,
              color: Colors.white,
              child: Column(children: [
                Container(
                  width: width,
                  padding: EdgeInsets.only(
                      left: width * 0.04,
                      top: height * 0.01,
                      bottom: height * 0.01),
                  color: Colors.white,
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontFamily: "Rubik", fontSize: 18),
                  ),
                ),
                Container(
                  color: Colors.white,
                  width: width,
                  child: const Divider(
                    thickness: 2.5,
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        controller: ScrollController(),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: years.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: index % 2 == 0
                                ? Colors.grey.shade200
                                : Colors.white,
                            child: ListTile(
                              onTap: () {},
                              title: Text(years[index].toString()),
                            ),
                          );
                        })),
              ]),
            ));
  }

///////////////////////////////////////////// select date for insurance validity //////////////////////////////////////
  Widget selectDate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Insurance valid upto",
          style: TextStyle(
              fontFamily: "Rubik", fontWeight: FontWeight.w400, fontSize: 17),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 50,
          width: width * 0.9,
          child: TextField(
            readOnly: true,
            controller: insuranceController,
            onTap: () async {
              DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 365)),
                  lastDate: DateTime.now().add(const Duration(days: 3650)));

              if (selectedDate != null) {
                String date =
                    "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";

                insuranceController.text = date;
              }
            },
            textAlign: TextAlign.start,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
                suffixIcon: const Icon(Icons.date_range_outlined),
                hintText: "Select date",
                hintStyle: const TextStyle(fontFamily: "Rubik"),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber.shade900),
                    borderRadius: BorderRadius.circular(5)),
                border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black54),
                    borderRadius: BorderRadius.circular(5))),
          ),
        )
      ],
    );
  }

  /////////////////////////////////////////// how it works widget ///////////////////////////////////////////
  Widget howItWorksWidget(String imgUrl, String title) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: Image.asset(
            imgUrl,
            // "assets/sell3.png",
            height: 70,
            width: 70,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        Text(
          title,
          style: TextStyle(
              color: Colors.grey.shade800,
              fontFamily: "Rubik",
              fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
