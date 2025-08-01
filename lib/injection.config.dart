// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:kofuku/application/usecases/empathy_usecase.dart' as _i1043;
import 'package:kofuku/application/usecases/get_users_usecase.dart' as _i256;
import 'package:kofuku/application/usecases/message_usecase.dart' as _i123;
import 'package:kofuku/domain/repositories/empathy_repository.dart' as _i121;
import 'package:kofuku/domain/repositories/message_repository.dart' as _i76;
import 'package:kofuku/domain/repositories/user_repository.dart' as _i596;
import 'package:kofuku/infrastructure/repositories/empathy_repository_impl.dart'
    as _i514;
import 'package:kofuku/infrastructure/repositories/message_repository_impl.dart'
    as _i1053;
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
    gh.factory<_i76.MessageRepository>(() => _i1053.MessageRepositoryImpl());
    gh.factory<_i121.EmpathyRepository>(() => _i514.EmpathyRepositoryImpl());
    gh.factory<_i1043.EmpathyUseCase>(
        () => _i1043.EmpathyUseCase(gh<_i121.EmpathyRepository>()));
    gh.singleton<_i596.UserRepository>(() => _i902.UserRepositoryImpl());
    gh.factory<_i256.GetUsersUseCase>(
        () => _i256.GetUsersUseCase(gh<_i596.UserRepository>()));
    gh.factory<_i123.MessageUseCase>(
        () => _i123.MessageUseCase(gh<_i76.MessageRepository>()));
    return this;
  }
}
