// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Enter your email`
  String get txt_email_hint {
    return Intl.message(
      'Enter your email',
      name: 'txt_email_hint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get txt_password_hint {
    return Intl.message(
      'Enter your password',
      name: 'txt_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get btn_forgot_password {
    return Intl.message(
      'Forgot password',
      name: 'btn_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get btn_login {
    return Intl.message(
      'Login',
      name: 'btn_login',
      desc: '',
      args: [],
    );
  }

  /// `Create new account?`
  String get txt_create_account {
    return Intl.message(
      'Create new account?',
      name: 'txt_create_account',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get btn_register {
    return Intl.message(
      'Register',
      name: 'btn_register',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get lbl_register {
    return Intl.message(
      'Register',
      name: 'lbl_register',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get lbl_first_name {
    return Intl.message(
      'First name',
      name: 'lbl_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your first name`
  String get txt_first_name_hint {
    return Intl.message(
      'Enter your first name',
      name: 'txt_first_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lbl_last_name {
    return Intl.message(
      'Last name',
      name: 'lbl_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your last name`
  String get txt_last_name_hint {
    return Intl.message(
      'Enter your last name',
      name: 'txt_last_name_hint',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get lbl_email {
    return Intl.message(
      'Email',
      name: 'lbl_email',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get lbl_gender {
    return Intl.message(
      'Gender',
      name: 'lbl_gender',
      desc: '',
      args: [],
    );
  }

  /// `Select your gender`
  String get txt_gender_hint {
    return Intl.message(
      'Select your gender',
      name: 'txt_gender_hint',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get lbl_password {
    return Intl.message(
      'Password',
      name: 'lbl_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get lbl_confirm_password {
    return Intl.message(
      'Confirm password',
      name: 'lbl_confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get lbl_forgot_password {
    return Intl.message(
      'Forgot password',
      name: 'lbl_forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get btn_send {
    return Intl.message(
      'Send',
      name: 'btn_send',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get txt_search_hint {
    return Intl.message(
      'Search',
      name: 'txt_search_hint',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get btn_cancel {
    return Intl.message(
      'Cancel',
      name: 'btn_cancel',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get lbl_account {
    return Intl.message(
      'Account',
      name: 'lbl_account',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get lbl_post {
    return Intl.message(
      'Post',
      name: 'lbl_post',
      desc: '',
      args: [],
    );
  }

  /// `Follower`
  String get lbl_follower {
    return Intl.message(
      'Follower',
      name: 'lbl_follower',
      desc: '',
      args: [],
    );
  }

  /// `Following`
  String get lbl_following {
    return Intl.message(
      'Following',
      name: 'lbl_following',
      desc: '',
      args: [],
    );
  }

  /// `Add bio`
  String get btn_add_bio {
    return Intl.message(
      'Add bio',
      name: 'btn_add_bio',
      desc: '',
      args: [],
    );
  }

  /// `Update profile`
  String get btn_update_profile {
    return Intl.message(
      'Update profile',
      name: 'btn_update_profile',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get lbl_notification {
    return Intl.message(
      'Notification',
      name: 'lbl_notification',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get lbl_comment {
    return Intl.message(
      'Comment',
      name: 'lbl_comment',
      desc: '',
      args: [],
    );
  }

  /// `Enter your comment`
  String get txt_comment_hint {
    return Intl.message(
      'Enter your comment',
      name: 'txt_comment_hint',
      desc: '',
      args: [],
    );
  }

  /// `Post`
  String get btn_post {
    return Intl.message(
      'Post',
      name: 'btn_post',
      desc: '',
      args: [],
    );
  }

  /// `What's on your mind?`
  String get txt_post_hint {
    return Intl.message(
      'What\'s on your mind?',
      name: 'txt_post_hint',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get lbl_content {
    return Intl.message(
      'Content',
      name: 'lbl_content',
      desc: '',
      args: [],
    );
  }

  /// `Photo/Video`
  String get lbl_media {
    return Intl.message(
      'Photo/Video',
      name: 'lbl_media',
      desc: '',
      args: [],
    );
  }

  /// `New post`
  String get lbl_new_post {
    return Intl.message(
      'New post',
      name: 'lbl_new_post',
      desc: '',
      args: [],
    );
  }

  /// `Old password`
  String get lbl_old_password {
    return Intl.message(
      'Old password',
      name: 'lbl_old_password',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get lbl_new_password {
    return Intl.message(
      'New password',
      name: 'lbl_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm new password`
  String get lbl_confirm_new_password {
    return Intl.message(
      'Confirm new password',
      name: 'lbl_confirm_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your old password`
  String get txt_old_password_hint {
    return Intl.message(
      'Enter your old password',
      name: 'txt_old_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get txt_new_password_hint {
    return Intl.message(
      'Enter your new password',
      name: 'txt_new_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Enter confirm new password`
  String get txt_confirm_new_password_hint {
    return Intl.message(
      'Enter confirm new password',
      name: 'txt_confirm_new_password_hint',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get lbl_change_password {
    return Intl.message(
      'Change password',
      name: 'lbl_change_password',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get btn_update {
    return Intl.message(
      'Update',
      name: 'btn_update',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get btn_done {
    return Intl.message(
      'Done',
      name: 'btn_done',
      desc: '',
      args: [],
    );
  }

  /// `Recent activities`
  String get lbl_recent_activities {
    return Intl.message(
      'Recent activities',
      name: 'lbl_recent_activities',
      desc: '',
      args: [],
    );
  }

  /// `Saved posts`
  String get lbl_saved_posts {
    return Intl.message(
      'Saved posts',
      name: 'lbl_saved_posts',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get btn_log_out {
    return Intl.message(
      'Log out',
      name: 'btn_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get lbl_setting {
    return Intl.message(
      'Setting',
      name: 'lbl_setting',
      desc: '',
      args: [],
    );
  }

  /// `Select your gender`
  String get lbl_select_gender {
    return Intl.message(
      'Select your gender',
      name: 'lbl_select_gender',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get lbl_bio {
    return Intl.message(
      'Bio',
      name: 'lbl_bio',
      desc: '',
      args: [],
    );
  }

  /// `Update bio`
  String get lbl_update_bio {
    return Intl.message(
      'Update bio',
      name: 'lbl_update_bio',
      desc: '',
      args: [],
    );
  }

  /// `Enter your bio`
  String get txt_bio_hint {
    return Intl.message(
      'Enter your bio',
      name: 'txt_bio_hint',
      desc: '',
      args: [],
    );
  }

  /// `Add photo`
  String get btn_add_photo {
    return Intl.message(
      'Add photo',
      name: 'btn_add_photo',
      desc: '',
      args: [],
    );
  }

  /// `Change photo`
  String get btn_change_photo {
    return Intl.message(
      'Change photo',
      name: 'btn_change_photo',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your first name`
  String get txt_err_empty_first_name {
    return Intl.message(
      'Please enter your first name',
      name: 'txt_err_empty_first_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your last name`
  String get txt_err_empty_last_name {
    return Intl.message(
      'Please enter your last name',
      name: 'txt_err_empty_last_name',
      desc: '',
      args: [],
    );
  }

  /// `Password is mismatch`
  String get txt_err_mismatch_password {
    return Intl.message(
      'Password is mismatch',
      name: 'txt_err_mismatch_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get txt_err_empty_email {
    return Intl.message(
      'Please enter your email',
      name: 'txt_err_empty_email',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get txt_err_invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'txt_err_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get txt_err_empty_password {
    return Intl.message(
      'Please enter your password',
      name: 'txt_err_empty_password',
      desc: '',
      args: [],
    );
  }

  /// `Password can't contain space`
  String get txt_err_have_spacing {
    return Intl.message(
      'Password can\'t contain space',
      name: 'txt_err_have_spacing',
      desc: '',
      args: [],
    );
  }

  /// `Password must be more than 8 chars length`
  String get txt_err_less_than_8_length {
    return Intl.message(
      'Password must be more than 8 chars length',
      name: 'txt_err_less_than_8_length',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get txt_male {
    return Intl.message(
      'Male',
      name: 'txt_male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get txt_female {
    return Intl.message(
      'Female',
      name: 'txt_female',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get btn_delete {
    return Intl.message(
      'Delete',
      name: 'btn_delete',
      desc: '',
      args: [],
    );
  }

  /// `comments`
  String get txt_comments {
    return Intl.message(
      'comments',
      name: 'txt_comments',
      desc: '',
      args: [],
    );
  }

  /// `comment`
  String get txt_comment {
    return Intl.message(
      'comment',
      name: 'txt_comment',
      desc: '',
      args: [],
    );
  }

  /// `This post has no content`
  String get txt_create_empty_post {
    return Intl.message(
      'This post has no content',
      name: 'txt_create_empty_post',
      desc: '',
      args: [],
    );
  }

  /// `Like`
  String get btn_like {
    return Intl.message(
      'Like',
      name: 'btn_like',
      desc: '',
      args: [],
    );
  }

  /// `like`
  String get txt_like {
    return Intl.message(
      'like',
      name: 'txt_like',
      desc: '',
      args: [],
    );
  }

  /// `likes`
  String get txt_likes {
    return Intl.message(
      'likes',
      name: 'txt_likes',
      desc: '',
      args: [],
    );
  }

  /// `Comment`
  String get btn_comment {
    return Intl.message(
      'Comment',
      name: 'btn_comment',
      desc: '',
      args: [],
    );
  }

  /// `Save post`
  String get btn_save_post {
    return Intl.message(
      'Save post',
      name: 'btn_save_post',
      desc: '',
      args: [],
    );
  }

  /// `There is no image`
  String get txt_no_image {
    return Intl.message(
      'There is no image',
      name: 'txt_no_image',
      desc: '',
      args: [],
    );
  }

  /// `Change language`
  String get lbl_change_language {
    return Intl.message(
      'Change language',
      name: 'lbl_change_language',
      desc: '',
      args: [],
    );
  }

  /// `System language`
  String get txt_system_language {
    return Intl.message(
      'System language',
      name: 'txt_system_language',
      desc: '',
      args: [],
    );
  }

  /// `Please check your email`
  String get txt_check_mail {
    return Intl.message(
      'Please check your email',
      name: 'txt_check_mail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your bio`
  String get txt_empty_bio {
    return Intl.message(
      'Please enter your bio',
      name: 'txt_empty_bio',
      desc: '',
      args: [],
    );
  }

  /// `Update successfully`
  String get txt_update_successfully {
    return Intl.message(
      'Update successfully',
      name: 'txt_update_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Saved post`
  String get btn_saved_post {
    return Intl.message(
      'Saved post',
      name: 'btn_saved_post',
      desc: '',
      args: [],
    );
  }

  /// `The password is incorrect`
  String get txt_err_wrong_password {
    return Intl.message(
      'The password is incorrect',
      name: 'txt_err_wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Change password successfully`
  String get txt_change_password_successfully {
    return Intl.message(
      'Change password successfully',
      name: 'txt_change_password_successfully',
      desc: '',
      args: [],
    );
  }

  /// `User Information`
  String get btn_user_info {
    return Intl.message(
      'User Information',
      name: 'btn_user_info',
      desc: '',
      args: [],
    );
  }

  /// `There is no user`
  String get txt_no_user {
    return Intl.message(
      'There is no user',
      name: 'txt_no_user',
      desc: '',
      args: [],
    );
  }

  /// `There is no post`
  String get txt_no_post {
    return Intl.message(
      'There is no post',
      name: 'txt_no_post',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get btn_photo {
    return Intl.message(
      'Photo',
      name: 'btn_photo',
      desc: '',
      args: [],
    );
  }

  /// `Video`
  String get btn_video {
    return Intl.message(
      'Video',
      name: 'btn_video',
      desc: '',
      args: [],
    );
  }

  /// `Save to phone`
  String get btn_save_to_phone {
    return Intl.message(
      'Save to phone',
      name: 'btn_save_to_phone',
      desc: '',
      args: [],
    );
  }

  /// `Downloading`
  String get btn_downloading {
    return Intl.message(
      'Downloading',
      name: 'btn_downloading',
      desc: '',
      args: [],
    );
  }

  /// `Saved to phone`
  String get btn_saved_to_phone {
    return Intl.message(
      'Saved to phone',
      name: 'btn_saved_to_phone',
      desc: '',
      args: [],
    );
  }

  /// `y`
  String get txt_y {
    return Intl.message(
      'y',
      name: 'txt_y',
      desc: '',
      args: [],
    );
  }

  /// `w`
  String get txt_w {
    return Intl.message(
      'w',
      name: 'txt_w',
      desc: '',
      args: [],
    );
  }

  /// `d`
  String get txt_d {
    return Intl.message(
      'd',
      name: 'txt_d',
      desc: '',
      args: [],
    );
  }

  /// `h`
  String get txt_h {
    return Intl.message(
      'h',
      name: 'txt_h',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get txt_m {
    return Intl.message(
      'm',
      name: 'txt_m',
      desc: '',
      args: [],
    );
  }

  /// `Just now`
  String get txt_just_now {
    return Intl.message(
      'Just now',
      name: 'txt_just_now',
      desc: '',
      args: [],
    );
  }

  /// `Choose location`
  String get lbl_choose_location {
    return Intl.message(
      'Choose location',
      name: 'lbl_choose_location',
      desc: '',
      args: [],
    );
  }

  /// `Listview`
  String get lbl_listview {
    return Intl.message(
      'Listview',
      name: 'lbl_listview',
      desc: '',
      args: [],
    );
  }

  /// `Gridview`
  String get lbl_gridview {
    return Intl.message(
      'Gridview',
      name: 'lbl_gridview',
      desc: '',
      args: [],
    );
  }

  /// `No activity recorded yet`
  String get txt_no_activity {
    return Intl.message(
      'No activity recorded yet',
      name: 'txt_no_activity',
      desc: '',
      args: [],
    );
  }

  /// `You`
  String get txt_you {
    return Intl.message(
      'You',
      name: 'txt_you',
      desc: '',
      args: [],
    );
  }

  /// `posted`
  String get txt_post {
    return Intl.message(
      'posted',
      name: 'txt_post',
      desc: '',
      args: [],
    );
  }

  /// `liked`
  String get txt_liked {
    return Intl.message(
      'liked',
      name: 'txt_liked',
      desc: '',
      args: [],
    );
  }

  /// `commented`
  String get txt_commented {
    return Intl.message(
      'commented',
      name: 'txt_commented',
      desc: '',
      args: [],
    );
  }

  /// `saved`
  String get txt_saved {
    return Intl.message(
      'saved',
      name: 'txt_saved',
      desc: '',
      args: [],
    );
  }

  /// `unliked`
  String get txt_unliked {
    return Intl.message(
      'unliked',
      name: 'txt_unliked',
      desc: '',
      args: [],
    );
  }

  /// `unsaved`
  String get txt_unsaved {
    return Intl.message(
      'unsaved',
      name: 'txt_unsaved',
      desc: '',
      args: [],
    );
  }

  /// `just`
  String get txt_just {
    return Intl.message(
      'just',
      name: 'txt_just',
      desc: '',
      args: [],
    );
  }

  /// `post of`
  String get txt_post_of {
    return Intl.message(
      'post of',
      name: 'txt_post_of',
      desc: '',
      args: [],
    );
  }

  /// `a new post`
  String get txt_new_post {
    return Intl.message(
      'a new post',
      name: 'txt_new_post',
      desc: '',
      args: [],
    );
  }

  /// `your post`
  String get txt_your_post {
    return Intl.message(
      'your post',
      name: 'txt_your_post',
      desc: '',
      args: [],
    );
  }

  /// `in`
  String get txt_in {
    return Intl.message(
      'in',
      name: 'txt_in',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
