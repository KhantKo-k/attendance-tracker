import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/core/navigation/app_router.dart';
import 'package:app_starter_kit_bloc/features/to-do/presentation/bloc/note_form_bloc.dart';
import 'package:app_starter_kit_bloc/features/to-do/presentation/bloc/notes_bloc.dart';
import 'package:app_starter_kit_bloc/features/to-do/presentation/pages/note_form_page.dart';
import 'package:app_starter_kit_bloc/features/to-do/presentation/pages/notes_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NoteRoutes {
  static const notes = '/notes';

  static const createNote = '$notes/new';
  
  static String editNote(String id) => '$notes/$id';

  static final routes = [
    GoRoute(
      path: notes,
      builder: (context, state) => BlocProvider(
        create: (context) => serviceLocator.get<NotesBloc>()
          ..add(const NotesEvent.fetchNotes()),
        child: const NotesPage(),
      ),
      routes: [
        GoRoute(
          path: 'new',
          builder: (context, state) => BlocProvider(
            create: (context) => serviceLocator.get<NoteFormBloc>()
              ..add(const NoteFormEvent.newNote()),
            child: const NoteFormPage(),
          ),
        ),
        GoRoute(
          path: ':id',
          builder: (context, state) {
            final id = state.pathParameters['id']!;
            return BlocProvider(
              create: (context) => serviceLocator.get<NoteFormBloc>()
                ..add(NoteFormEvent.loadNote(id)),
              child: NoteFormPage(noteId: id),
            );
          },
        ),
      ],
    ),
  ];
}

extension NoteRoutesExtension on AppRouter {
  void goToNotes(BuildContext context) {
    context.go(NoteRoutes.notes);
  }

  Future<void> goToCreateNote(BuildContext context) {
    return context.push(NoteRoutes.createNote);
  }

  Future<void> goToEditNote(BuildContext context, String id) {
    return context.push(NoteRoutes.editNote(id));
  }
}
