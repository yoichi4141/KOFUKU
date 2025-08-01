// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:kofuku/application/usecases/get_users_usecase.dart' as _i256;
import 'package:kofuku/domain/repositories/user_repository.dart' as _i596;
import 'package:kofuku/infrastructure/repositories/user_repository_impl.dart'
    as _i902;

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
    gh.singleton<_i596.UserRepository>(() => _i902.UserRepositoryImpl());
    gh.factory<_i256.GetUsersUseCase>(
        () => _i256.GetUsersUseCase(gh<_i596.UserRepository>()));
    return this;
  }
}
