import 'package:bloc/bloc.dart';
import 'package:bloc_task/infrastructure/data_access_layer/services/database/local_database.dart';
import 'package:bloc_task/infrastructure/data_access_layer/services/repositories/home_repository.dart';
import 'package:bloc_task/infrastructure/models/response/git_data_response_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

part 'home_screen_event.dart';

part 'home_screen_state.dart';

@injectable
class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final HomeRepository _homeRepository;
  final LocalDatabase _localDatabase;

  HomeScreenBloc(
      {required HomeRepository homeRepository,
      required LocalDatabase localDatabase})
      : _homeRepository = homeRepository,
        _localDatabase = localDatabase,
        super(const HomeScreenState()) {

    on<GetRepoDataEvent>(
      (event, emit) async {
        emit(state.copyWith(gitDataStatus: GitDataStatus.loading));

        final currentDate = event.isRefresh ? DateTime.now().toIso8601String().split('T').first : '2022-04-29';
        try {
          final localDataList = await _localDatabase.getGitRepoData();

          if (localDataList.isNotEmpty) {
            emit(state.copyWith(
                gitSearchDataList: localDataList,
                gitDataStatus: GitDataStatus.loaded));
          }

          final repoDataList =
              await _homeRepository.fetchGitRepoData(currentDate: currentDate);
          if (repoDataList.isNotEmpty) {
            final Batch batch = _localDatabase.batch();
            for (final data in repoDataList) {
              batch.insert(
                LocalDatabase.gitRepoTable,
                data.toJson(),
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
            }
            await batch.commit();

            emit(state.copyWith(
                gitSearchDataList: repoDataList,
                gitDataStatus:event.isRefresh ?  GitDataStatus.refreshed : GitDataStatus.loaded));
          } else {
            if(localDataList.isNotEmpty){
              emit(state.copyWith(
                  gitSearchDataList: localDataList,
                  gitDataStatus: GitDataStatus.loaded));
            }else{
            emit(state.copyWith(gitDataStatus: GitDataStatus.empty));
          }}


        } catch (e) {
          emit(state.copyWith(gitDataStatus: GitDataStatus.failure));
          if (kDebugMode) {
            print('Exception while fetching data $e');
          }
        }
      },
    );
  }
}
