import 'package:koompi_hotspot/src/models/model_balance.dart';

class Wallet{
  String title;
  String amount;
  String logo;

  Wallet(this.title, this.amount, this.logo);
}

final List<Wallet> wallets = [
  Wallet(
    'Selendra (SEL)',
    // '${mBalance.data.balance}',
    'RSEL 0',
    'assets/images/icon_launcher.png',
  ),
];
