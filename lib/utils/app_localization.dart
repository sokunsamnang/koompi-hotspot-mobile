import 'package:koompi_hotspot/all_export.dart';

class AppLocalizeService {
  final Locale locale;
  AppLocalizeService(this.locale);

  static AppLocalizeService of(BuildContext context) {
    return Localizations.of<AppLocalizeService>(context, AppLocalizeService);
  }

  static const LocalizationsDelegate<AppLocalizeService> delegate =
      _AppLocalizationDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String translate(String key) {
    return _localizedStrings[key];
  }
}

class _AppLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizeService> {
  const _AppLocalizationDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'km'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizeService> load(Locale locale) async {
    AppLocalizeService localization = AppLocalizeService(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizeService> old) =>
      false;
}
