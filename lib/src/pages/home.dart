import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'notes/note_detail.dart';
import 'notes/notes_list.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          //diable stupid debug tag
          debugShowCheckedModeBanner: false,
          //restoratin scope
          restorationScopeId: 'home',
          //localization
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('cs', ''),
          localeResolutionCallback: (
            locale,
            supportedLocales,
          ) {
            return locale;
          },
          //localized title
          onGenerateTitle: (BuildContext context) => 
          AppLocalizations.of(context)!.appTitle,
          // theme loading
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView();
                  case NoteList.routeName:
                  default:
                    return const NoteList();
                }
              },
            );
          },
        );
      },
    );
  }
}
