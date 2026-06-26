import 'package:app_starter_kit_bloc/core/di/service_locator.dart';
import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/core/navigation/app_router.dart';
import 'package:app_starter_kit_bloc/features/to-do/note_routes.dart';
import 'package:app_starter_kit_bloc/features/to-do/presentation/bloc/notes_bloc.dart';
import 'package:app_starter_kit_bloc/features/to-do/presentation/pages/widgets/note_list_tile.dart';
import 'package:app_starter_kit_bloc/shared/widgets/common_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotesBloc, NotesState>(
      listenWhen: (previous, current) =>
          previous.failure != current.failure && current.failure != null,
      listener: (context, state) {
        _handleFailure(context, state);
      },
      child: Builder(builder: (context) => _buildNotesView(context)),
    );
  }

  Widget _buildNotesView(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToCreate(context),
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async =>
                context.read<NotesBloc>().add(const NotesEvent.refresh()),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                _buildAppBar(theme),
                _buildSliverContent(context, state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(ThemeData theme) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      title: Text(
        'Notes',
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSliverContent(BuildContext context, NotesState state) {
    if (state.isLoading && state.notes.isEmpty) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (state.notes.isEmpty) {
      return SliverFillRemaining(child: _buildEmptyNotesView());
    }

    return _buildSliverList(state);
  }

  Widget _buildSliverList(NotesState state) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
      sliver: SliverList.separated(
        itemCount: state.notes.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final note = state.notes[index];
          return NoteListTile(
            note: note,
            onTap: () => _navigateToEdit(context, note.id),
            onDelete: () => _confirmDelete(context, note.id),
          );
        },
      ),
    );
  }

  Widget _buildEmptyNotesView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_alt_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No notes yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Tap + to create your first note',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToCreate(BuildContext context) async {
    await serviceLocator.get<AppRouter>().goToCreateNote(context);
    if (!context.mounted) return;
    context.read<NotesBloc>().add(const NotesEvent.fetchNotes());
  }

  Future<void> _navigateToEdit(BuildContext context, String id) async {
    await serviceLocator.get<AppRouter>().goToEditNote(context, id);
    if (!context.mounted) return;
    context.read<NotesBloc>().add(const NotesEvent.fetchNotes());
  }

  Future<void> _confirmDelete(BuildContext context, String id) async {
    final confirmed = await CommonDialog.showConfirmDialog(
      context: context,
      title: 'Delete note?',
      message: 'This note will be removed permanently.',
      confirmText: 'Delete',
      cancelText: 'Cancel',
    );

    if (!context.mounted) return;
    if (confirmed) {
      context.read<NotesBloc>().add(NotesEvent.deleteNote(id));
    }
  }

  void _handleFailure(BuildContext context, NotesState state) {
    GlobalErrorHandler().handleError(context, state.failure!);
  }
}
