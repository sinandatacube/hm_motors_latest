import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/somethingwentwrong2.png",
              height: height * 0.2,
              width: width * 0.3,
              color: Colors.grey.shade400,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              "Bad response recieved !",
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: height * 0.01,
            ),
            Text(
              "Please try later!",
              textAlign: TextAlign.justify,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
