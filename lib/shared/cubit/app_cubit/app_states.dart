abstract class AppStates {}

class AppInit extends AppStates {}

class GetHomeDataLoading extends AppStates {}

class GetHomeDataSuccess extends AppStates {}

class GetHomeDataFail extends AppStates {
  final String onError;

  GetHomeDataFail(this.onError);
}

class ChangeThemeMode extends AppStates {}

class GetMessagesLoading extends AppStates {}

class GetMessagesSuccess extends AppStates {}

class GetMessagesFail extends AppStates {}

class GetNotificationsLoading extends AppStates {}

class GetNotificationsSuccess extends AppStates {}

class GetNotificationsFail extends AppStates {}

class GetSettingsLoading extends AppStates {}

class GetSettingsSuccess extends AppStates {}

class GetSettingsFail extends AppStates {}

class BtmNavBarChangeItemState extends AppStates {}

class ChangeLikeIconState extends AppStates {}

class LikeCountState extends AppStates {}

class PasswordVisibilityState extends AppStates {}

class ProfileImagePickedSuccess extends AppStates {}

class ProfileImagePickedFail extends AppStates {}

class CoverImagePickedSuccess extends AppStates {}

class CoverImagePickedFail extends AppStates {}
