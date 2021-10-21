import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_demo/models/user_premium_model.dart';

class AppUser {
  FirebaseUser firebaseUser;
  UserPremiumData premium;
  bool get isPremium => premium?.expireDate == null
      ? false
      : DateTime.parse(premium.expireDate).compareTo(DateTime.now()) > 0;
  AppUser({this.firebaseUser, this.premium});
}
