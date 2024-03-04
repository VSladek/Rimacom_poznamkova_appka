import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:rimacom_poznamkova_appka/src/pages/notes/note.dart';
import 'notes/note_detail.dart';
import 'notes/notes_view.dart';
import 'notes/note_list.dart';
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
    return ChangeNotifierProvider(
      create: (context) => NotesList(),
      child: ListenableBuilder(
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
            locale: settingsController.localization,

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
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case SettingsView.routeName:
                      return SettingsView(controller: settingsController);
                    case NoteDetail.routeName: 
                      final dynamic arguments = routeSettings.arguments;
                      if (arguments is Map<String, dynamic>) {
                        final Note notedata = Note.fromJson(arguments);
                        return NoteDetail(note: notedata);
                      } else {
                        Navigator.pushNamed(context, NoteView.routeName);
                        return const NoteView();
                      }
                    case NoteView.routeName:
                    default:
                      return const NoteView();
                  }
                },
              );
            },
          );
        },
      )
    );
  }
}
