import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/core/di/injection.dart';
import 'package:kptube_mobile/features/auth/data/repositories/abstract_auth_repository.dart';

part 'auth_events.dart';
part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final authRepository = getIt<AbstractAuthRepository>();

  AuthBloc(abstractAuthRepository) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
