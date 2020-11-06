import 'package:bloc/bloc.dart';
import 'package:bounty_hub_client/data/repositories/profile_local_repository.dart';
import 'package:bounty_hub_client/data/repositories/profile_repository.dart';
import 'package:bounty_hub_client/ui/pages/profile/bloc/profile_event.dart';
import 'package:bounty_hub_client/ui/pages/profile/bloc/profile_state.dart';
import 'package:logger/logger.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._profileRepository, this._profileLocalRepository)
      : super(ProfileState());

  final ProfileRepository _profileRepository;
  final ProfileLocalRepository _profileLocalRepository;

  final log = Logger();

  void loadUserProfile() async {
    var localUser = await _profileLocalRepository.getUser();
    if (localUser != null) {
      add(UserProfileReceivedEvent(localUser));
    }
    var apiUser = await _profileRepository.getUser();
    if (apiUser != null) {
      add(UserProfileReceivedEvent(apiUser));
      _profileLocalRepository.putUser(apiUser);
    }

    var socials = await _profileRepository.getMySocialAccounts();

    add(SocialsReceivedEvent(socials));
  }

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is FetchProfileEvent) {
      loadUserProfile();
    }

    if (event is UserProfileReceivedEvent) {
      yield ProfileState(
          user: event.user, selectedSocial: state.selectedSocial);
    }

    if (event is SocialsReceivedEvent) {
      yield state.copyWith(socials: event.socials);
    }

    if (event is SelectSocialProfileEvent) {
      yield state.copyWith(selectedSocial: event.socialNetworkType);
    }

    if (event is OnNextBtnPresEvent) {
      var newMap = Map.of(state.nextBtnWasPressed);
      newMap[event.socialNetworkType] = true;
      yield state.copyWith(nextBtnWasPressed: newMap);
    }
  }
}
