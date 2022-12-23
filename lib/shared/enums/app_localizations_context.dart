import 'package:blu_time/helpers/locator.dart';
import 'package:blu_time/utilities/navigation_service.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}

extension LocalizedString on String {
  AppLocalizations? get localized => locator<NavigationService>().navigatorKey.currentContext?.loc;
}
