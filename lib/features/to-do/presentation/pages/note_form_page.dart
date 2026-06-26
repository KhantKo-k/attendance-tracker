import 'package:app_starter_kit_bloc/core/error/global_error_handler.dart';
import 'package:app_starter_kit_bloc/features/to-do/domain/entities/note_entity.dart';
import 'package:app_starter_kit_bloc/features/to-do/note_routes.dart';
import 'package:app_starter_kit_bloc/features/to-do/presentation/bloc/note_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NoteFormPage extends StatefulWidget {
  const NoteFormPage({super.key, this.noteId});

  final String? noteId;

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends State<NoteFormPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;

  bool get _isEdit => widget.noteId != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteFormBloc, NoteFormState>(
      listenWhen: (previous, current) =>
          previous.saveFailure != current.saveFailure &&
          current.saveFailure != null,
      listener: _handleSaveFailure,
      builder: (context, state) {
        return state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => _buildScaffold(
            context,
            body: const Center(child: CircularProgressIndicator()),
          ),
          editing: (editing) {
            _syncControllers(editing.note);
            return _buildScaffold(
              context,
              state: state,
              body: _buildForm(context, state),
            );
          },
          failure: (failure) => _buildScaffold(
            context,
            body: _buildLoadFailure(context, failure.failure),
          ),
        );
      },
    );
  }

  Widget _buildScaffold(
    BuildContext context, {
    NoteFormState? state,
    required Widget body,
  }) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        await _onBackPressed(context);
      },
      child: Scaffold(
        appBar: state != null ? _buildAppBar(context, state) : null,
        body: body,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, NoteFormState state) {
    return AppBar(
      title: Text(_isEdit ? 'Edit note' : 'New note'),
      leading: IconButton(
        onPressed: state.isSaving ? null : () => _onBackPressed(context),
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [_buildSaveStatus(state)],
    );
  }

  Widget _buildSaveStatus(NoteFormState state) {
    if (state.isSaving) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    if (state.isDirty) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Text(
            'Unsaved',
            style: TextStyle(fontSize: 13),
          ),
        ),
      );
    }

    if (state.canEdit) {
      return const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Icon(Icons.cloud_done_outlined, size: 22),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildForm(BuildContext context, NoteFormState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTitleField(state),
          const SizedBox(height: 16),
          _buildContentField(state),
        ],
      ),
    );
  }

  Widget _buildLoadFailure(BuildContext context, failure) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48),
          const SizedBox(height: 16),
          const Text('Could not load note'),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: () => _onBackPressed(context),
            child: const Text('Go back'),
          ),
        ],
      ),
    );
  }

  Widget _buildTitleField(NoteFormState state) {
    return TextField(
      controller: _titleController,
      enabled: state.canEdit && !state.isSaving,
      autofocus: !_isEdit,
      decoration: const InputDecoration(
        labelText: 'Title',
        border: OutlineInputBorder(),
      ),
      textInputAction: TextInputAction.next,
      onChanged: (value) => context.read<NoteFormBloc>().add(
            NoteFormEvent.titleChanged(value),
          ),
    );
  }

  Widget _buildContentField(NoteFormState state) {
    return TextField(
      controller: _contentController,
      enabled: state.canEdit && !state.isSaving,
      decoration: const InputDecoration(
        labelText: 'Content',
        border: OutlineInputBorder(),
        alignLabelWithHint: true,
      ),
      minLines: 6,
      maxLines: 12,
      onChanged: (value) => context.read<NoteFormBloc>().add(
            NoteFormEvent.contentChanged(value),
          ),
    );
  }

  void _handleSaveFailure(BuildContext context, NoteFormState state) {
    final failure = state.saveFailure;
    if (failure == null) return;

    GlobalErrorHandler().handleError(context, failure);
    context.read<NoteFormBloc>().add(const NoteFormEvent.saveFailureHandled());
  }

  Future<void> _onBackPressed(BuildContext context) async {
    final bloc = context.read<NoteFormBloc>();
    final current = bloc.state;

    if (current.isDirty && !current.isSaving) {
      bloc.add(const NoteFormEvent.saveRequested());
      await bloc.stream.firstWhere(
        (s) => !s.isDirty && !s.isSaving || s.saveFailure != null,
      );
    } else if (current.isSaving) {
      await bloc.stream.firstWhere((s) => !s.isSaving);
    }

    if (!context.mounted) return;

    if (context.canPop()) {
      context.pop();
    } else {
      context.go(NoteRoutes.notes);
    }
  }

  void _syncControllers(NoteEntity note) {
    if (_titleController.text != note.title) {
      _titleController.text = note.title;
    }
    if (_contentController.text != note.content) {
      _contentController.text = note.content;
    }
  }
}
