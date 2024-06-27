import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class S {
  static List<Locale> get locales => AppLocalizations.supportedLocales;

  static LocalizationsDelegate<AppLocalizations> get delegate =>
      AppLocalizations.delegate;

  static List<LocalizationsDelegate<dynamic>> get delegates =>
      AppLocalizations.localizationsDelegates;

  static AppLocalizations of(BuildContext context) =>
      AppLocalizations.of(context);

  const S._();
}