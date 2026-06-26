part of 'mock_bloc.dart';

abstract class MockEvent extends Equatable {
  const MockEvent();
  
  @override
  List<Object> get props => [];
}

class MockRequest extends MockEvent{
  const MockRequest();

  @override
  List<Object> get props => [];
}