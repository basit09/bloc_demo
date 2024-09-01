// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../ui/screens/home_screen/home_screen_bloc/home_screen_bloc.dart'
    as _i140;
import '../data_access_layer/services/database/local_database.dart' as _i0;
import '../data_access_layer/services/repositories/home_repository.dart'
    as _i107;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i0.LocalDatabase>(() => _i0.LocalDatabase());
    gh.singleton<_i107.HomeRepository>(() => _i107.HomeRepository());
    gh.factory<_i140.HomeScreenBloc>(() => _i140.HomeScreenBloc(
          homeRepository: gh<_i107.HomeRepository>(),
          localDatabase: gh<_i0.LocalDatabase>(),
        ));
    return this;
  }
}
