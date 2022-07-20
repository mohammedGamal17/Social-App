import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/models/post_model/post_model.dart';
import 'package:social/modules/messages/messages_screen.dart';
import 'package:social/modules/notifications/notifications_screen.dart';
import 'package:social/modules/settings/settings_screen.dart';
import 'package:social/modules/videos/videos_screen.dart';
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

  final _picker = ImagePicker();
  final storage = FirebaseStorage.instance;

  List<Widget> screen = [
    const HomeScreen(),
    const VideosScreen(),
    const MessagesScreen(),
    const NotificationsScreen(),
    const SettingsScreen(),
  ];
  List<String> title = [
    'News Feed',
    'Videos',
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
      icon: Icon(FontAwesomeIcons.video),
      label: 'Videos',
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
      const VideosScreen();
    }
    if (index == 2) {
      const MessagesScreen();
    }
    if (index == 3) {
      const NotificationsScreen();
    }
    if (index == 4) {
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

  void changeLikeIcon() {
    isLike = !isLike;
    emit(ChangeLikeIconState());
  }

  void likeCount() {
    if (isLike == true) {
      likeNum++;
    } else {
      likeNum--;
    }

    emit(LikeCountState());
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
        getUserData(context);
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
    String? postImage,
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

  Future<void> postImageGallery(context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
    } else {
      snack(context, content: 'No Image Selected', bgColor: Colors.red);
    }
  }

  Future<void> postImageCamera(context) async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
    } else {
      snack(context, content: 'No Image Selected', bgColor: Colors.red);
    }
  }

  void removePickedPhoto() {
    postImage = null;
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
  }) {
    emit(CreatePostLoadingState());
    emit(UploadPostImageLoading());
    storage
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
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
}
