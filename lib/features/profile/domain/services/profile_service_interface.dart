import 'dart:io';

import 'package:bokashi/features/profile/domain/models/profile_model.dart';

abstract class ProfileServiceInterface{

  Future<dynamic> getProfileInfo();
  Future<dynamic> delete(int id);
  Future<dynamic> updateProfile(ProfileModel userInfoModel, String pass, File? file, String token);

}