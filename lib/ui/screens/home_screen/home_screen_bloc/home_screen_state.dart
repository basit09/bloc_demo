part of 'home_screen_bloc.dart';

enum GitDataStatus { initial, loading, loaded, empty, failure, refreshed }

@immutable
class HomeScreenState extends Equatable {
  final List<GitDataResponseModel> gitSearchDataList;
  final GitDataStatus gitDataStatus;

  const HomeScreenState(
      {this.gitSearchDataList = const [],
      this.gitDataStatus = GitDataStatus.initial});

  HomeScreenState copyWith({
    List<GitDataResponseModel>? gitSearchDataList,
    GitDataStatus? gitDataStatus,
  }) {
    return HomeScreenState(
        gitDataStatus: gitDataStatus ?? this.gitDataStatus,
        gitSearchDataList: gitSearchDataList ?? this.gitSearchDataList);
  }

  @override
  List<Object?> get props => [gitSearchDataList, gitDataStatus];
}
