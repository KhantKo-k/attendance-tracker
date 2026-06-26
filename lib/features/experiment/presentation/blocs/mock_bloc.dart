
import 'package:app_starter_kit_bloc/core/error/failures.dart';
import 'package:app_starter_kit_bloc/features/experiment/domain/entities/mock_model.dart';
import 'package:app_starter_kit_bloc/features/experiment/domain/use_cases/request_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'mock_state.dart';
part 'mock_event.dart';

@injectable
class MockBloc extends Bloc<MockEvent, MockState> {
  final RequestUseCase requestUseCase;

  MockBloc({required this.requestUseCase}) 
  : super(MockInitial()) {
    on<MockRequest> (_onMockRequest);
  }

  Future<void> _onMockRequest( 
    MockRequest event,
    Emitter<MockState> emit,
  ) async {
    emit(MockLoading());

    final result = await requestUseCase();

    result.fold(
      (mockmodel) {
        emit(MockLoaded(mockmodel));
      }, 
      (failure) {
        emit(MockError(failure: failure));
      });
  }
}