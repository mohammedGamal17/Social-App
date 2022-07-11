abstract class AppStates {}

class AppInit extends AppStates {}

class GetHomeDataLoading extends AppStates {}

class GetHomeDataSuccess extends AppStates {}

class GetHomeDataFail extends AppStates {
  final String onError;

  GetHomeDataFail(this.onError);
}
 class ChangeThemeMode extends AppStates{}

class BtmNavBarChangeItemState extends AppStates {}