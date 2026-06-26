part of 'mock_bloc.dart';

abstract class MockState extends Equatable {
  const MockState();

  @override
  List<Object> get props => []; 
}

class MockInitial extends MockState {}

class MockLoading extends MockState {}

class MockLoaded extends MockState {
  final MockModel mockModel;

  const MockLoaded(this.mockModel);

  @override
  List<Object> get props => [mockModel];
}

class MockError extends MockState{
  final Failure failure;
  const MockError({required this.failure});

  @override
  List<Object> get props => [failure];
}