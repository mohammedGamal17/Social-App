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

class UploadProfileImageLoading extends AppStates {}

class UploadProfileImageSuccess extends AppStates {}

class UploadProfileImageFail extends AppStates {}

class GetDownloadURLProfileImageSuccess extends AppStates {}

class GetDownloadURLProfileImageFail extends AppStates {}

class CoverImagePickedSuccess extends AppStates {}

class CoverImagePickedFail extends AppStates {}

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

class PostVideoPickedSuccess extends AppStates {}

class PostVideoPickedFail extends AppStates {}

class UploadPostVideoLoading extends AppStates {}

class UploadPostVideoSuccess extends AppStates {}

class UploadPostVideoFail extends AppStates {}

class GetDownloadURLPostVideoSuccess extends AppStates {}

class GetDownloadURLPostVideoFail extends AppStates {}

class GetPostsLoading extends AppStates {}

class GetPostsSuccess extends AppStates {}

class GetPostsFail extends AppStates {}

class LikePostSuccess extends AppStates {}

class LikePostFail extends AppStates {}

class GetLikesLoading extends AppStates {}

class GetLikesSuccess extends AppStates {}

class GetLikesFail extends AppStates {}

class GetCommentsLoading extends AppStates {}

class GetCommentsSuccess extends AppStates {}

class GetCommentsFail extends AppStates {}

class AddCommentsLoading extends AppStates {}

class AddCommentsSuccess extends AppStates {}

class AddCommentsFail extends AppStates {}

class SendMessagesSuccess extends AppStates {}

class SendMessagesFail extends AppStates {}

class GetAllMessagesLoading extends AppStates {}

class GetAllMessagesSuccess extends AppStates {}

class GetAllMessagesFail extends AppStates {}

class ChatImagePickedSuccess extends AppStates {}

class ChatImagePickedFail extends AppStates {}

class UploadChatImageLoading extends AppStates {}

class UploadChatImageSuccess extends AppStates {}

class UploadChatImageFail extends AppStates {}

class GetDownloadURLChatImageSuccess extends AppStates {}

class GetDownloadURLChatImageFail extends AppStates {}

class ChatVideoPickedSuccess extends AppStates {}

class ChatVideoPickedFail extends AppStates {}

class UploadChatVideoLoading extends AppStates {}

class UploadChatVideoSuccess extends AppStates {}

class UploadChatVideoFail extends AppStates {}

class GetDownloadURLChatVideoSuccess extends AppStates {}

class GetDownloadURLChatVideoFail extends AppStates {}

class GetMyPostsLoading extends AppStates {}

class GetMyPostsSuccess extends AppStates {}

class GetMyPostsFail extends AppStates {}

class RecordingInit extends AppStates {}

class RecordingLoading extends AppStates {}

class RecordingSuccess extends AppStates {}

class RecordingFail extends AppStates {}

class RecordingUploadLoading extends AppStates {}

class RecordingUploadSuccess extends AppStates {}

class RecordingUploadFail extends AppStates {}

class RecordingUploadURLLoading extends AppStates {}

class RecordingUploadURLSuccess extends AppStates {}

class RecordingUploadURLFail extends AppStates {}
