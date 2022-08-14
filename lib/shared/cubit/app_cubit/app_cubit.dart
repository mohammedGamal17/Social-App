import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/models/chat_model/chat_model.dart';
import 'package:social/models/post_model/post_model.dart';
import 'package:social/modules/messages/messages_screen.dart';
import 'package:social/modules/notifications/notifications_screen.dart';
import 'package:social/modules/settings/settings_screen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/components/constants.dart';
import 'package:social/shared/cubit/app_cubit/app_states.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../models/user_model/user_model.dart';
import '../../../layout/Layout_screen.dart';
import '../../../modules/home/home_screen.dart';
import '../../networks/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit({this.userModel}) : super(AppInit());

  static AppCubit get(context) => BlocProvider.of(context);

  DioHelper dio = DioHelper();

  UserModel? userModel;
  PostModel? postModel;
  int currentIndex = 0;
  IconData disLikeIcon = Icons.favorite_outline;
  IconData likedIcon = Icons.favorite_outlined;
  IconData darkIcon = Icons.dark_mode;
  IconData lightIcon = Icons.light_mode;
  IconData suffix = Icons.visibility_outlined;
  String darkMode = 'Dark mode';
  String lightMode = 'Light mode';
  String profileImageUrl = '';
  String coverImageUrl = '';
  int likeNum = 0;
  bool isDark = false;
  bool isPassword = true;
  bool isLike = false;
  File? profileImage;
  File? coverImage;
  File? postImage;
  File? postVideo;
  File? chatImage;
  File? chatVideo;

  final _picker = ImagePicker();
  final storage = FirebaseStorage.instance;

  List<Widget> screen = [
    HomeScreen(),
    MessagesScreen(),
    const NotificationsScreen(),
    const SettingsScreen(),
  ];
  List<String> title = [
    'News Feed',
    'Messages',
    'Notifications',
    'Settings',
  ];

  List<BottomNavigationBarItem> navBarItem = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(FontAwesomeIcons.message),
      label: 'Messages',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.notifications_outlined),
      label: 'Notifications',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.menu),
      label: 'Settings',
    ),
  ];

  void navBarChange(int index) {
    currentIndex = index;
    if (index == 0) {
      const LayOutScreen();
    }
    if (index == 1) {
      MessagesScreen();
    }
    if (index == 2) {
      const NotificationsScreen();
    }
    if (index == 3) {
      const SettingsScreen();
    }
    emit(BtmNavBarChangeItemState());
  }

  void getUserData(context) {
    emit(GetHomeDataLoading());

    final fireStore = FirebaseFirestore.instance;
    final fireStoreDirection = fireStore.collection('users').doc(uId);
    fireStoreDirection.get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(GetHomeDataSuccess());
    }).catchError((onError) {
      snack(context, content: onError.toString(), bgColor: Colors.red);
      emit(GetHomeDataFail(onError.toString()));
    });
  }

  void changeThemeMode() {
    isDark = !isDark;
    emit(ChangeThemeMode());
  }

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(PasswordVisibilityState());
  }

  Future<void> getProfileImageGallery(context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccess());
    } else {
      snack(context, content: 'No Profile Image Selected', bgColor: Colors.red);
      emit(ProfileImagePickedFail());
    }
  }

  Future<void> getProfileImageCamera(context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccess());
    } else {
      snack(context, content: 'No Profile Image Selected', bgColor: Colors.red);
      emit(ProfileImagePickedFail());
    }
  }

  Future<void> getCoverImageGallery(context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccess());
    } else {
      snack(context, content: 'No Cover Image Selected', bgColor: Colors.red);
      emit(CoverImagePickedFail());
    }
  }

  Future<void> getCoverImageCamera(context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccess());
    } else {
      snack(context, content: 'No Cover Image Selected', bgColor: Colors.red);
      emit(CoverImagePickedFail());
    }
  }

  void uploadProfileImage(context) {
    emit(UploadProfileImageLoading());
    final storageRef = storage.ref();
    final storageRefData = storageRef
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}');
    storageRefData.putFile(profileImage!).then(
      (value) {
        value.ref.getDownloadURL().then((value) {
          updateData(
            context,
            name: userModel!.name!,
            lastName: userModel!.lastName!,
            phone: userModel!.phone!,
            bio: userModel!.bio!,
            cover: userModel!.coverImage!,
            image: value,
          );
          emit(GetDownloadURLProfileImageSuccess());
        }).catchError(
          (onError) {
            emit(GetDownloadURLProfileImageFail());
            if (kDebugMode) {
              print('* ${onError.toString()} * Profile Image URI Fail');
            }
            snack(
              context,
              content: '* ${onError.toString()} * Profile Image Upload Fail',
              bgColor: Colors.red,
            );
          },
        );
        emit(UploadProfileImageSuccess());
        snack(context, content: 'Profile Image Uploaded Successfully');
      },
    ).catchError(
      (onError) {
        emit(UploadProfileImageFail());
        if (kDebugMode) {
          print('* ${onError.toString()} *  Profile Image Upload Fail');
        }
        snack(
          context,
          content: '* ${onError.toString()} * Profile Image Upload Fail',
          bgColor: Colors.red,
        );
      },
    );
  }

  void uploadCoverImage(context) {
    emit(UploadCoverImageLoading());
    final storageRef = storage.ref();
    final storageRefData = storageRef
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}');
    storageRefData.putFile(coverImage!).then(
      (value) {
        value.ref.getDownloadURL().then((value) {
          updateData(
            context,
            name: userModel!.name!,
            lastName: userModel!.lastName!,
            phone: userModel!.phone!,
            bio: userModel!.bio!,
            image: userModel!.image!,
            cover: value,
          );
          emit(GetDownloadURLCoverImageSuccess());
        }).catchError(
          (onError) {
            emit(GetDownloadURLCoverImageFail());
            if (kDebugMode) {
              print('* ${onError.toString()} * Cover Image URI Fail');
            }
            snack(
              context,
              content: '* ${onError.toString()} * Cover Image Upload Fail',
              bgColor: Colors.red,
            );
          },
        );
        emit(UploadCoverImageSuccess());
        snack(context, content: 'Cover Image Uploaded Successfully');
      },
    ).catchError(
      (onError) {
        emit(UploadCoverImageFail());
        if (kDebugMode) {
          print('* ${onError.toString()} *  Cover Image Upload Fail');
        }
        snack(
          context,
          content: '* ${onError.toString()} * Cover Image Upload Fail',
          bgColor: Colors.red,
        );
      },
    );
  }

  void updateData(
    context, {
    required String name,
    required String lastName,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    UserModel model = UserModel(
      name: name,
      lastName: lastName,
      phone: phone,
      bio: bio,
      coverImage: cover ?? userModel!.coverImage,
      image: image ?? userModel!.image,
      uId: userModel!.uId,
      isEmailVerified: userModel!.isEmailVerified,
      email: userModel!.email,
      password: userModel!.password,
    );
    emit(UpdateUserDataLoading());
    final fireStore = FirebaseFirestore.instance;
    final fireStoreDirection = fireStore.collection('users').doc(uId);
    fireStoreDirection.update(model.toMap()).then(
      (value) {
        getUserData(context);
        snack(context, content: 'Your Data Are Updated');
        navigateToAndReplace(context, const LayOutScreen());
      },
    ).catchError(
      (onError) {
        emit(UpdateUserDataFail());
        if (kDebugMode) {
          print('* ${onError.toString()} *  Update User Data Fail');
        }
        snack(
          context,
          content: '* ${onError.toString()} * Update User Data Fail',
          bgColor: Colors.red,
        );
      },
    );
  }

  void createPost(
    context, {
    required String text,
    required String dateTime,
    required String uId,
    required String name,
    required String lastName,
    required String email,
    required String image,
    required String coverImage,
    required String bio,
    String? postImage,
    String? postVideo,
  }) {
    PostModel model = PostModel(
      uId: uId,
      name: name,
      lastName: lastName,
      email: email,
      image: image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
      postVideo: postVideo ?? '',
      coverImage: coverImage,
      bio: bio,
    );
    emit(CreatePostLoadingState());

    final fireStore = FirebaseFirestore.instance;
    final fireStoreDirection = fireStore.collection('posts');
    fireStoreDirection.add(model.toMap()).then((value) {
      emit(CreatePostSuccessState());
      snack(context, content: 'Post Added Successfully');
      navigateToAndReplace(context, const LayOutScreen());
    }).catchError(
      (onError) {
        emit(CreatePostFailState());
        if (kDebugMode) {
          print(onError.toString());
        }
        snack(context,
            content: '* ${onError.toString()} * Post Added Fail',
            bgColor: Colors.red);
      },
    );
  }

  void createMyPost(
    context, {
    required String text,
    required String dateTime,
    required String uId,
    required String name,
    required String lastName,
    required String email,
    required String image,
    required String coverImage,
    required String bio,
    String? postImage,
    String? postVideo,
  }) {
    PostModel model = PostModel(
      uId: uId,
      name: name,
      lastName: lastName,
      email: email,
      image: image,
      text: text,
      dateTime: dateTime,
      postImage: postImage ?? '',
      postVideo: postVideo ?? '',
      coverImage: coverImage,
      bio: bio,
    );
    emit(CreatePostLoadingState());

    final fireStore = FirebaseFirestore.instance;
    final fireStoreDirection =
        fireStore.collection('users').doc(uId).collection('posts');
    fireStoreDirection.add(model.toMap()).then((value) {
      emit(CreatePostSuccessState());
      snack(context, content: 'Post Added Successfully');
      navigateToAndReplace(context, const LayOutScreen());
    }).catchError(
      (onError) {
        emit(CreatePostFailState());
        if (kDebugMode) {
          print(onError.toString());
        }
        snack(context,
            content: '* ${onError.toString()} * Post Added Fail',
            bgColor: Colors.red);
      },
    );
  }

  Future<void> postImageGallery(context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccess());
    } else {
      emit(PostImagePickedFail());
      snack(context, content: 'No Image Selected', bgColor: Colors.red);
    }
  }

  Future<void> postImageCamera(context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      emit(PostImagePickedSuccess());
    } else {
      emit(PostImagePickedFail());
      snack(context, content: 'No Image Selected', bgColor: Colors.red);
    }
  }

  Future<void> postVideoCamera(context) async {
    final pickedFile = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(
          seconds: 60,
        ));
    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      emit(PostVideoPickedSuccess());
    } else {
      emit(PostVideoPickedFail());
      snack(context, content: 'No Video Selected', bgColor: Colors.red);
    }
  }

  Future<void> postVideoGallery(context) async {
    final pickedFile = await _picker
        .pickVideo(
            source: ImageSource.gallery,
            maxDuration: const Duration(
              seconds: 60,
            ))
        .catchError((onError) {
      emit(PostVideoPickedFail());
      snack(context,
          content: 'Video Max Duration is 60 Second', bgColor: Colors.red);
    });
    if (pickedFile != null) {
      postVideo = File(pickedFile.path);
      emit(PostVideoPickedSuccess());
    } else {
      emit(PostVideoPickedFail());
      snack(context, content: 'No Video Selected', bgColor: Colors.red);
    }
  }

  void removePickedPhoto() {
    postImage = null;
    emit(PostImagePickedRemove());
  }

  void removePickedVideo() {
    postVideo = null;
    emit(PostImagePickedRemove());
  }

  void uploadPostImage(
    context, {
    required String text,
    required String dateTime,
    required String uId,
    required String name,
    required String lastName,
    required String email,
    required String image,
    required String coverImage,
    required String bio,
  }) {
    emit(CreatePostLoadingState());
    emit(UploadPostImageLoading());
    storage
        .ref()
        .child('posts/picture/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then((value) {
          createPost(
            context,
            text: text,
            dateTime: dateTime,
            postImage: value,
            uId: uId,
            name: name,
            lastName: lastName,
            email: email,
            image: image,
            coverImage: coverImage,
            bio: bio,
          );
        }).catchError(
          (onError) {
            emit(GetDownloadURLPostImageFail());
            if (kDebugMode) {
              print('* ${onError.toString()} * Post Image URI Fail');
            }
            snack(
              context,
              content: '* ${onError.toString()} * Post Image Upload Fail',
              bgColor: Colors.red,
            );
          },
        );
        emit(UploadPostImageSuccess());
        snack(context, content: 'Post Image Uploaded Successfully');
      },
    ).catchError(
      (onError) {
        emit(UploadPostImageFail());
        if (kDebugMode) {
          print('* ${onError.toString()} *  Post Image Upload Fail');
        }
        snack(
          context,
          content: '* ${onError.toString()} * Post Image Upload Fail',
          bgColor: Colors.red,
        );
      },
    );
  }
  void uploadMyPostImage(
      context, {
        required String text,
        required String dateTime,
        required String uId,
        required String name,
        required String lastName,
        required String email,
        required String image,
        required String coverImage,
        required String bio,
      }) {
    emit(CreatePostLoadingState());
    emit(UploadPostImageLoading());
    storage
        .ref()
        .child('users/$uId/posts/picture/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then(
          (value) {
        value.ref.getDownloadURL().then((value) {
          createMyPost(
            context,
            text: text,
            dateTime: dateTime,
            postImage: value,
            uId: uId,
            name: name,
            lastName: lastName,
            email: email,
            image: image,
            coverImage: coverImage,
            bio: bio,
          );
        }).catchError(
              (onError) {
            emit(GetDownloadURLPostImageFail());
            if (kDebugMode) {
              print('* ${onError.toString()} * Post Image URI Fail');
            }
            snack(
              context,
              content: '* ${onError.toString()} * Post Image Upload Fail',
              bgColor: Colors.red,
            );
          },
        );
        emit(UploadPostImageSuccess());
        snack(context, content: 'Post Image Uploaded Successfully');
      },
    ).catchError(
          (onError) {
        emit(UploadPostImageFail());
        if (kDebugMode) {
          print('* ${onError.toString()} *  Post Image Upload Fail');
        }
        snack(
          context,
          content: '* ${onError.toString()} * Post Image Upload Fail',
          bgColor: Colors.red,
        );
      },
    );
  }
  void uploadPostVideo(
    context, {
    required String text,
    required String dateTime,
    required String uId,
    required String name,
    required String lastName,
    required String email,
    required String image,
    required String coverImage,
    required String bio,
  }) {
    emit(CreatePostLoadingState());
    emit(UploadPostVideoLoading());
    storage
        .ref()
        .child('posts/video/${Uri.file(postVideo!.path).pathSegments.last}')
        .putFile(postVideo!)
        .then(
      (value) {
        value.ref.getDownloadURL().then((value) {
          createPost(
            context,
            text: text,
            dateTime: dateTime,
            postVideo: value,
            uId: uId,
            name: name,
            lastName: lastName,
            email: email,
            image: image,
            coverImage: coverImage,
            bio: bio,
          );
        }).catchError(
          (onError) {
            emit(GetDownloadURLPostImageFail());
            if (kDebugMode) {
              print('* ${onError.toString()} * Post Video URI Fail');
            }
            snack(
              context,
              content: '* ${onError.toString()} * Post Video Upload Fail',
              bgColor: Colors.red,
            );
          },
        );
        emit(UploadPostImageSuccess());
        snack(context, content: 'Post Video Uploaded Successfully');
      },
    ).catchError(
      (onError) {
        emit(UploadPostImageFail());
        if (kDebugMode) {
          print('* ${onError.toString()} *  Post Video Upload Fail');
        }
        snack(
          context,
          content: '* ${onError.toString()} * Post Video Upload Fail',
          bgColor: Colors.red,
        );
      },
    );
  }

  void uploadMyPostVideo(
      context, {
        required String text,
        required String dateTime,
        required String uId,
        required String name,
        required String lastName,
        required String email,
        required String image,
        required String coverImage,
        required String bio,
      }) {
    emit(CreatePostLoadingState());
    emit(UploadPostVideoLoading());
    storage
        .ref()
        .child('users/$uId/posts/video/${Uri.file(postVideo!.path).pathSegments.last}')
        .putFile(postVideo!)
        .then(
          (value) {
        value.ref.getDownloadURL().then((value) {
          createPost(
            context,
            text: text,
            dateTime: dateTime,
            postVideo: value,
            uId: uId,
            name: name,
            lastName: lastName,
            email: email,
            image: image,
            coverImage: coverImage,
            bio: bio,
          );
        }).catchError(
              (onError) {
            emit(GetDownloadURLPostImageFail());
            if (kDebugMode) {
              print('* ${onError.toString()} * Post Video URI Fail');
            }
            snack(
              context,
              content: '* ${onError.toString()} * Post Video Upload Fail',
              bgColor: Colors.red,
            );
          },
        );
        emit(UploadPostImageSuccess());
        snack(context, content: 'Post Video Uploaded Successfully');
      },
    ).catchError(
          (onError) {
        emit(UploadPostImageFail());
        if (kDebugMode) {
          print('* ${onError.toString()} *  Post Video Upload Fail');
        }
        snack(
          context,
          content: '* ${onError.toString()} * Post Video Upload Fail',
          bgColor: Colors.red,
        );
      },
    );
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likesCount = [];
  List<PostModel> myPosts = [];

  void getPosts(context) {
    emit(GetPostsLoading());
    final fireStore = FirebaseFirestore.instance;
    final fireStoreDirection = fireStore.collection('posts');
    fireStoreDirection.get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likesCount.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(GetCommentsSuccess());
        }).catchError((onError) {
          snack(context,
              content: ' * likes not loaded * ${onError.toString()}');
          if (kDebugMode) {
            print(' * likes not loaded * ${onError.toString()}');
          }
          emit(GetCommentsFail());
        });
      }
    }).catchError((onError) {
      emit(GetCommentsFail());
    });
    emit(GetPostsSuccess());
  }

  void getMyPosts(context) {
    emit(GetPostsLoading());
    final fireStore = FirebaseFirestore.instance;
    final fireStoreDirection = fireStore.collection('posts');
    fireStoreDirection.get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likesCount.add(value.docs.length);
          postsId.add(element.id);
          myPosts.add(PostModel.fromJson(element.data()));
          emit(GetCommentsSuccess());
        }).catchError((onError) {
          snack(context,
              content: ' * likes not loaded * ${onError.toString()}');
          if (kDebugMode) {
            print(' * likes not loaded * ${onError.toString()}');
          }
          emit(GetCommentsFail());
        });
      }
    }).catchError((onError) {
      emit(GetCommentsFail());
    });
    emit(GetPostsSuccess());
  }

  void likePost(String postId) {
    final fireStore = FirebaseFirestore.instance;
    final fireStoreDirec =
        fireStore.collection('posts').doc(postId).collection('likes');

    fireStoreDirec.doc(userModel?.uId).set({'like': true}).then((value) {
      isLike = !isLike;
      emit(LikePostSuccess());
    }).catchError((onError) {
      emit(LikePostFail());
    });
  }

  late List<UserModel> users;

  void getAllUsers() {
    users = [];
    final fireStore = FirebaseFirestore.instance;
    final fireStoreDirection = fireStore.collection('users');
    fireStoreDirection.get().then((value) {
      emit(GetAllUsersLoading());
      if (users.isEmpty) {
        for (var element in value.docs) {
          if (element.data()['uId'] != uId) {
            users.add(UserModel.fromJson(element.data()));
          }
        }
      }
      emit(GetAllUsersSuccess());
    }).catchError((onError) {
      emit(GetAllUsersFail());
      if (kDebugMode) {
        print('* Get All Users Fail * ${onError.toString()}');
      }
    });
  }

  void sendMessages({
    required String messageText,
    required String receiverId,
    required String messageTime,
    required String date,
    String? chatImage,
    String? chatVideo,
  }) {
    MessageModel model = MessageModel(
      messageText: messageText,
      senderId: uId!,
      receiverId: receiverId,
      messageTime: messageTime,
      image: chatImage ?? '',
      video: chatVideo ?? '',
      date: date,
    );
    final fireStore = FirebaseFirestore.instance;
    final fireStoreDirection = fireStore.collection('users');
    fireStoreDirection
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toJson())
        .then((value) {
      emit(SendMessagesSuccess());
    }).catchError((onError) {
      emit(SendMessagesFail());
      if (kDebugMode) {
        print('* Send Messages Fail * ${onError.toString()}');
      }
    });

    fireStoreDirection
        .doc(receiverId)
        .collection('chats')
        .doc(uId)
        .collection('messages')
        .add(model.toJson())
        .then((value) {
      emit(SendMessagesSuccess());
    }).catchError((onError) {
      emit(SendMessagesFail());
      if (kDebugMode) {
        print('* Receiver Messages Fail * ${onError.toString()}');
      }
    });
  }

  List<MessageModel> messages = [];

  void getMessages({
    required String receiverId,
  }) {
    final fireStore = FirebaseFirestore.instance;
    final fireStoreDirection = fireStore.collection('users');
    fireStoreDirection
        .doc(uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('messageTime')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(MessageModel.fromJson(element.data()));
      }
      emit(GetMessagesSuccess());
    });
  }

  Future<void> chatImageGallery(context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(ChatImagePickedSuccess());
    } else {
      emit(ChatImagePickedFail());
      snack(context, content: 'No Image Selected', bgColor: Colors.red);
    }
  }

  Future<void> chatImageCamera(context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
    );
    if (pickedFile != null) {
      chatImage = File(pickedFile.path);
      emit(ChatImagePickedSuccess());
    } else {
      emit(ChatImagePickedFail());
      snack(context, content: 'No Image Selected', bgColor: Colors.red);
    }
  }

  void uploadChatImage(
    context, {
    required String receiverId,
    required String messageTime,
    required String messageText,
    required String date,
    String? chatVideo,
  }) {
    emit(UploadChatImageLoading());
    storage
        .ref()
        .child('chats/picture/${Uri.file(chatImage!.path).pathSegments.last}')
        .putFile(chatImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessages(
          receiverId: receiverId,
          messageTime: messageTime,
          messageText: messageText,
          chatImage: value,
          date: date,
          chatVideo: chatVideo ?? '',
        );
        emit(GetDownloadURLChatImageSuccess());
      }).catchError((onError) {
        emit(GetDownloadURLChatImageFail());
        if (kDebugMode) {
          print(' * Get Download URL Chat Image Fail * ${onError.toString()}');
        }
        snack(context,
            content:
                ' * Get Download URL Chat Image Fail * ${onError.toString()}');
      });
      emit(UploadChatImageSuccess());
    }).catchError((onError) {
      emit(UploadChatImageFail());
      if (kDebugMode) {
        print(' * Upload Chat Image Fail * ${onError.toString()}');
      }
      snack(context,
          content: ' * Upload Chat Image Fail * ${onError.toString()}');
    });
  }

  void removeChatPhoto() {
    chatImage = null;
    emit(PostImagePickedRemove());
  }

  Future<void> chatCameraVideo(context) async {
    final pickedFile = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(
          seconds: 60,
        ));
    if (pickedFile != null) {
      chatVideo = File(pickedFile.path);
      emit(ChatVideoPickedSuccess());
    } else {
      emit(ChatVideoPickedFail());
      snack(context, content: 'No Video Selected', bgColor: Colors.red);
    }
  }

  Future<void> chatGalleryVideo(context) async {
    final pickedFile = await _picker
        .pickVideo(
            source: ImageSource.gallery,
            maxDuration: const Duration(
              seconds: 60,
            ))
        .catchError((onError) {
      emit(ChatVideoPickedFail());
      snack(context,
          content: 'Video Max Duration is 60 Second', bgColor: Colors.red);
    });
    if (pickedFile != null) {
      chatVideo = File(pickedFile.path);
      emit(ChatVideoPickedSuccess());
    } else {
      emit(ChatVideoPickedFail());
      snack(context, content: 'No Video Selected', bgColor: Colors.red);
    }
  }

  void uploadChatVideo(
    context, {
    required String receiverId,
    required String messageTime,
    required String messageText,
    required String date,
  }) {
    emit(UploadChatVideoLoading());
    storage
        .ref()
        .child('chats/video/${Uri.file(chatVideo!.path).pathSegments.last}')
        .putFile(chatVideo!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessages(
          receiverId: receiverId,
          messageTime: messageTime,
          messageText: messageText,
          date: date,
          chatVideo: value,
        );
        emit(GetDownloadURLChatVideoSuccess());
      }).catchError((onError) {
        emit(GetDownloadURLChatVideoFail());
        if (kDebugMode) {
          print(' * Get Download URL Chat Video Fail * ${onError.toString()}');
        }
        snack(context,
            content:
                ' * Get Download URL Chat Video Fail * ${onError.toString()}');
      });
      emit(UploadChatVideoSuccess());
    }).catchError((onError) {
      emit(UploadChatVideoFail());
      if (kDebugMode) {
        print(' * Upload Chat Video Fail * ${onError.toString()}');
      }
      snack(context,
          content: ' * Upload Chat Video Fail * ${onError.toString()}');
    });
  }

  void removeChatVideo() {
    chatVideo = null;
    emit(PostImagePickedRemove());
  }
}
