import 'package:intl/intl.dart';

class MoneyFormat {
  String moneyFormat(String? price) {
    final indianRupeesFormat = NumberFormat.currency(
      name: "RS ",
      locale: 'en_IN',
      decimalDigits: 0, // change it to get decimal places
      // symbol: '₹ ',
    ).format(int.parse(price!));
    return indianRupeesFormat;
  }
}
