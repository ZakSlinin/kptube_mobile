import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kptube_mobile/features/auth/data/repositories/abstract_auth_repository.dart';

part 'auth_events.dart';
part 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AbstractAuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AuthUserEvent>(_handleAuthUser);
  }

  Future<void> _handleAuthUser(
    AuthUserEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await authRepository.authUser(name: event.name, password: event.password);
      emit(AuthSuccess());
    } catch (e) {
      print('Failed auth with error: ${e.toString()}');
      emit(AuthFailed(error: e.toString()));
    }
  }
}
