import 'package:flutter/material.dart';
import 'package:koompi_hotspot/core/services/services.dart';

class LangProvider with ChangeNotifier {
  Locale _manualLocale;
  StorageServices _prefService = StorageServices();
  String _lang;

  String get lang => _lang;

  Locale get manualLocale => _manualLocale;

  //SET LOCALIZE LANGUAGE
  void setLocal(String languageCode, context) {
    _lang = languageCode;

    if (_lang == null) {
      saveLang(languageCode, context);
    } else {
      switch (languageCode) {
        case 'KH':
          _manualLocale = Locale('km', 'KH');
          notifyListeners();
          break;
        case 'EN':
          _manualLocale = Locale('en', 'US');
          notifyListeners();
          break;
      }
      _prefService.saveString('lang', languageCode);
    }

    notifyListeners();
  }

  //GET SAVE LANGUAGE CODE
  void saveLang(String languageCode, context) async {
    Locale myLocale = Localizations.localeOf(context);
    if (languageCode != null) {
      _lang = languageCode;
    } else {
      _lang = myLocale.countryCode;
    }
    //print(myLocale.countryCode);

    notifyListeners();
  }
}
