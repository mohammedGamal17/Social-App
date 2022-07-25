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

class GetAllUsersLoading extends AppStates {}

class GetAllUsersSuccess extends AppStates {}

class GetAllUsersFail extends AppStates {}

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

class UploadProfileImageLoading extends AppStates {}

class UploadProfileImageSuccess extends AppStates {}

class UploadProfileImageFail extends AppStates {}

class GetDownloadURLProfileImageSuccess extends AppStates {}

class GetDownloadURLProfileImageFail extends AppStates {}

class UploadCoverImageLoading extends AppStates {}

class UploadCoverImageSuccess extends AppStates {}

class UploadCoverImageFail extends AppStates {}

class GetDownloadURLCoverImageSuccess extends AppStates {}

class GetDownloadURLCoverImageFail extends AppStates {}

class UpdateUserDataLoading extends AppStates {}

class UpdateUserDataSuccess extends AppStates {}

class UpdateUserDataFail extends AppStates {}

class CreatePostLoadingState extends AppStates {}

class CreatePostSuccessState extends AppStates {}

class CreatePostFailState extends AppStates {}

class PostImagePickedSuccess extends AppStates {}

class PostImagePickedFail extends AppStates {}

class PostImagePickedRemove extends AppStates {}

class GetDownloadURLPostImageSuccess extends AppStates {}

class GetDownloadURLPostImageFail extends AppStates {}

class UploadPostImageLoading extends AppStates {}

class UploadPostImageSuccess extends AppStates {}

class UploadPostImageFail extends AppStates {}

class GetPostsLoading extends AppStates {}

class GetPostsSuccess extends AppStates {}

class GetPostsFail extends AppStates {}

class LikePostSuccess extends AppStates{}

class LikePostFail extends AppStates{}

class GetLikesLoading extends AppStates{}

class GetLikesSuccess extends AppStates{}

class GetLikesFail extends AppStates{}

class GetCommentsLoading extends AppStates{}

class GetCommentsSuccess extends AppStates{}

class GetCommentsFail extends AppStates{}

class AddCommentsLoading extends AppStates{}

class AddCommentsSuccess extends AppStates{}

class AddCommentsFail extends AppStates{}
