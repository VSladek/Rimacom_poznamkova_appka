import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'notes/note_detail.dart';
import 'notes/notes_view.dart';
import 'notes/note_list.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';
import 'package:localstorage/localstorage.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.settingsController});

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = LocalStorage('notes');
    final notesList = NotesList();
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.data == true) {
              notesList.loadNotes();
            }
            return ChangeNotifierProvider.value(
              value: notesList,
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
                              final dynamic noteId = routeSettings.arguments;
                              if (noteId is int) {
                                return NoteDetail(id: noteId);
                              } else {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  Navigator.pushReplacementNamed(context, NoteView.routeName);
                                });
                                return const SizedBox.shrink();
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
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
