part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
}

class GetRepoDataEvent extends HomeScreenEvent {
  final GitDataResponseModel? gitDataResponseModel;
  final bool isRefresh;

  const GetRepoDataEvent({this.gitDataResponseModel, this.isRefresh = false});

  @override
  List<Object?> get props => [gitDataResponseModel, isRefresh];
}
