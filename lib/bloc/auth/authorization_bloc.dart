import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/bloc/auth/authorization_state.dart';
import 'package:bounty_hub_client/data/repositories/user_repository.dart';
import 'package:bounty_hub_client/data/repositories/profile_local_repository.dart';
import 'package:bounty_hub_client/utils/bloc_utils.dart';
import 'authentication_event.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository _userRepository;

  final ProfileLocalRepository _profileRepository;

  AuthenticationBloc(this._userRepository, this._profileRepository) : super(AuthenticationState(status: AuthenticationStatus.uninitialized));

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield state.copyWith(status: AuthenticationStatus.loading);
    }
    if (event is SelectAuthenticationType) {
      _userRepository.saveGuestMode(event.type == AuthenticationType.guest);
      yield state.copyWith(type: event.type, status: AuthenticationStatus.selectAuthentication);
    }
    if (event is AppLoaded) {
      final String accessToken = await _userRepository.getAccessToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        yield state.copyWith(status: AuthenticationStatus.authenticated, token: accessToken);
      } else {
        yield state.copyWith(status: AuthenticationStatus.unauthenticated, token: '');
      }
    }
    if (event is LoggedOut) {
      logOut();
      yield state.copyWith(status: AuthenticationStatus.unauthenticated, token: '', signature: generateSignature());
    }
    if (event is LoggedIn) {
      yield state.copyWith(status: AuthenticationStatus.authenticated, signature: generateSignature());
    }
  }

  void logOut() {
    _userRepository.removeAccessData();
    _profileRepository.removeUserData();
  }
}