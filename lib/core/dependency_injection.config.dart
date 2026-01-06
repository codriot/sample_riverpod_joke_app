// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/datasources/remote_joke_datasource.dart' as _i751;
import '../data/repositories/joke_repository_impl.dart' as _i884;
import '../domain/repositories/joke_repository.dart' as _i325;
import 'dependency_injection.dart' as _i9;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i751.RemoteJokeDataSource>(
      () => _i751.RemoteJokeDataSource(gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i325.JokeRepository>(
      () => _i884.JokeRepositoryImpl(gh<_i751.RemoteJokeDataSource>()),
    );
    return this;
  }
}

class _$DioModule extends _i9.DioModule {}
