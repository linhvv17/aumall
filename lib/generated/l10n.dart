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

  /// `AuMall`
  String get appName {
    return Intl.message(
      'AuMall',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Explore & Select What You Love`
  String get onBoardingTitle1 {
    return Intl.message(
      'Explore & Select What You Love',
      name: 'onBoardingTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get onBoardingTitle2 {
    return Intl.message(
      'Add To Cart',
      name: 'onBoardingTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Pay By Card`
  String get onBoardingTitle3 {
    return Intl.message(
      'Pay By Card',
      name: 'onBoardingTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Fast Delievery Service`
  String get onBoardingTitle4 {
    return Intl.message(
      'Fast Delievery Service',
      name: 'onBoardingTitle4',
      desc: '',
      args: [],
    );
  }

  /// `Select Wide Range Of Products from Shop the most cool products available on the store let it be Car, Watch and much more!`
  String get onBoardingSubTitle1 {
    return Intl.message(
      'Select Wide Range Of Products from Shop the most cool products available on the store let it be Car, Watch and much more!',
      name: 'onBoardingSubTitle1',
      desc: '',
      args: [],
    );
  }

  /// `Just Two Clicks and you can buy all you want.`
  String get onBoardingSubTitle2 {
    return Intl.message(
      'Just Two Clicks and you can buy all you want.',
      name: 'onBoardingSubTitle2',
      desc: '',
      args: [],
    );
  }

  /// `Pay as per your convenience, we accept all credit and debit cards.`
  String get onBoardingSubTitle3 {
    return Intl.message(
      'Pay as per your convenience, we accept all credit and debit cards.',
      name: 'onBoardingSubTitle3',
      desc: '',
      args: [],
    );
  }

  /// `Our Modern Delivering technologies shipping to the porch of your apartment.`
  String get onBoardingSubTitle4 {
    return Intl.message(
      'Our Modern Delivering technologies shipping to the porch of your apartment.',
      name: 'onBoardingSubTitle4',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstname {
    return Intl.message(
      'First Name',
      name: 'firstname',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastname {
    return Intl.message(
      'Last Name',
      name: 'lastname',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get check {
    return Intl.message(
      'Check',
      name: 'check',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Product Added To Cart`
  String get addedToCart {
    return Intl.message(
      'Product Added To Cart',
      name: 'addedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get addToCart {
    return Intl.message(
      'Add To Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Product Removed From Cart`
  String get removeFromCart {
    return Intl.message(
      'Product Removed From Cart',
      name: 'removeFromCart',
      desc: '',
      args: [],
    );
  }

  /// `Apply`
  String get apply {
    return Intl.message(
      'Apply',
      name: 'apply',
      desc: '',
      args: [],
    );
  }

  /// `Write a review`
  String get writereview {
    return Intl.message(
      'Write a review',
      name: 'writereview',
      desc: '',
      args: [],
    );
  }

  /// `New products have arrived`
  String get recentlyAddedProducts {
    return Intl.message(
      'New products have arrived',
      name: 'recentlyAddedProducts',
      desc: '',
      args: [],
    );
  }

  /// `Products coming soon`
  String get comingSoonProducts {
    return Intl.message(
      'Products coming soon',
      name: 'comingSoonProducts',
      desc: '',
      args: [],
    );
  }

  /// `Today's Suggestions`
  String get todaySuggestProducts {
    return Intl.message(
      'Today\'s Suggestions',
      name: 'todaySuggestProducts',
      desc: '',
      args: [],
    );
  }

  /// `New`
  String get newText {
    return Intl.message(
      'New',
      name: 'newText',
      desc: '',
      args: [],
    );
  }

  /// `Old Password`
  String get oldpassword {
    return Intl.message(
      'Old Password',
      name: 'oldpassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newpassword {
    return Intl.message(
      'New Password',
      name: 'newpassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get repeatpassword {
    return Intl.message(
      'Confirm New Password',
      name: 'repeatpassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Name should have more than 3 characters`
  String get nameError {
    return Intl.message(
      'Name should have more than 3 characters',
      name: 'nameError',
      desc: '',
      args: [],
    );
  }

  /// `Name is required`
  String get nameEmpty {
    return Intl.message(
      'Name is required',
      name: 'nameEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Code is required`
  String get codeEmpty {
    return Intl.message(
      'Code is required',
      name: 'codeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password is Required`
  String get passwordEmpty {
    return Intl.message(
      'Password is Required',
      name: 'passwordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password is Required`
  String get repeatpasswordEmpty {
    return Intl.message(
      'Confirm New Password is Required',
      name: 'repeatpasswordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Old Password is Required`
  String get oldpasswordEmpty {
    return Intl.message(
      'Old Password is Required',
      name: 'oldpasswordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `New Password is Required`
  String get newpasswordEmpty {
    return Intl.message(
      'New Password is Required',
      name: 'newpasswordEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Password should atleast have 6 digits or characters`
  String get passwordError {
    return Intl.message(
      'Password should atleast have 6 digits or characters',
      name: 'passwordError',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Please, enter your email address. You will receive a Code to create a new password via email.`
  String get enteremail {
    return Intl.message(
      'Please, enter your email address. You will receive a Code to create a new password via email.',
      name: 'enteremail',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Remember me `
  String get saveAccount {
    return Intl.message(
      'Remember me ',
      name: 'saveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login done successfully`
  String get loginsuccess {
    return Intl.message(
      'Login done successfully',
      name: 'loginsuccess',
      desc: '',
      args: [],
    );
  }

  /// `Update Password done successfully`
  String get updatepasssuccess {
    return Intl.message(
      'Update Password done successfully',
      name: 'updatepasssuccess',
      desc: '',
      args: [],
    );
  }

  /// `Update Password Failed`
  String get updatepassfail {
    return Intl.message(
      'Update Password Failed',
      name: 'updatepassfail',
      desc: '',
      args: [],
    );
  }

  /// `Registration done successfully`
  String get registeruccess {
    return Intl.message(
      'Registration done successfully',
      name: 'registeruccess',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your pasasword?`
  String get forgetPassword {
    return Intl.message(
      'Forgot your pasasword?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgetPasswordtext {
    return Intl.message(
      'Forgot password',
      name: 'forgetPasswordtext',
      desc: '',
      args: [],
    );
  }

  /// `Product Removed from Favorite`
  String get deletefav {
    return Intl.message(
      'Product Removed from Favorite',
      name: 'deletefav',
      desc: '',
      args: [],
    );
  }

  /// `Product Added to Favorite`
  String get addfav {
    return Intl.message(
      'Product Added to Favorite',
      name: 'addfav',
      desc: '',
      args: [],
    );
  }

  /// `Verify Email`
  String get verify {
    return Intl.message(
      'Verify Email',
      name: 'verify',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get registerText {
    return Intl.message(
      'Sign Up',
      name: 'registerText',
      desc: '',
      args: [],
    );
  }

  /// `loading`
  String get loading {
    return Intl.message(
      'loading',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Update Password`
  String get updatePass {
    return Intl.message(
      'Update Password',
      name: 'updatePass',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Send Review`
  String get sendReview {
    return Intl.message(
      'Send Review',
      name: 'sendReview',
      desc: '',
      args: [],
    );
  }

  /// `Filter`
  String get filter {
    return Intl.message(
      'Filter',
      name: 'filter',
      desc: '',
      args: [],
    );
  }

  /// `Sort by`
  String get sortBy {
    return Intl.message(
      'Sort by',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Save Password`
  String get savepass {
    return Intl.message(
      'Save Password',
      name: 'savepass',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rate {
    return Intl.message(
      'Rating',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `My Orders`
  String get myOrders {
    return Intl.message(
      'My Orders',
      name: 'myOrders',
      desc: '',
      args: [],
    );
  }

  /// `My Addresses`
  String get myAddresses {
    return Intl.message(
      'My Addresses',
      name: 'myAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Shipping addresses`
  String get shippingAddresses {
    return Intl.message(
      'Shipping addresses',
      name: 'shippingAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Management shipping addresses`
  String get shippingAddressesDescription {
    return Intl.message(
      'Management shipping addresses',
      name: 'shippingAddressesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderdetails {
    return Intl.message(
      'Order Details',
      name: 'orderdetails',
      desc: '',
      args: [],
    );
  }

  /// `View Order Details`
  String get viewdetails {
    return Intl.message(
      'View Order Details',
      name: 'viewdetails',
      desc: '',
      args: [],
    );
  }

  /// `Active Orders`
  String get activeOrders {
    return Intl.message(
      'Active Orders',
      name: 'activeOrders',
      desc: '',
      args: [],
    );
  }

  /// `Delivered Orders`
  String get deliveredOrders {
    return Intl.message(
      'Delivered Orders',
      name: 'deliveredOrders',
      desc: '',
      args: [],
    );
  }

  /// `See more>`
  String get seeMore {
    return Intl.message(
      'See more>',
      name: 'seeMore',
      desc: '',
      args: [],
    );
  }

  /// `You can also like this`
  String get mayLike {
    return Intl.message(
      'You can also like this',
      name: 'mayLike',
      desc: '',
      args: [],
    );
  }

  /// `CONTINUE SHOPPING`
  String get continueShopping {
    return Intl.message(
      'CONTINUE SHOPPING',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `Rating & Reviews`
  String get rateandreview {
    return Intl.message(
      'Rating & Reviews',
      name: 'rateandreview',
      desc: '',
      args: [],
    );
  }

  /// `Give your workout\nA New Style!`
  String get headerTitle {
    return Intl.message(
      'Give your workout\nA New Style!',
      name: 'headerTitle',
      desc: '',
      args: [],
    );
  }

  /// `Shop the most cool products available on the store\nlet it be T-shirts, Electronics and much more!`
  String get headerSuTitle {
    return Intl.message(
      'Shop the most cool products available on the store\nlet it be T-shirts, Electronics and much more!',
      name: 'headerSuTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the code that was sent to your email. The Code is valid for 10 minutes.`
  String get enterLink {
    return Intl.message(
      'Please enter the code that was sent to your email. The Code is valid for 10 minutes.',
      name: 'enterLink',
      desc: '',
      args: [],
    );
  }

  /// `Code`
  String get code {
    return Intl.message(
      'Code',
      name: 'code',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset {
    return Intl.message(
      'Reset Password',
      name: 'reset',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmpass {
    return Intl.message(
      'Confirm Password',
      name: 'confirmpass',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password is Required`
  String get confirmEmpty {
    return Intl.message(
      'Confirm Password is Required',
      name: 'confirmEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Code is required`
  String get codeLink {
    return Intl.message(
      'Code is required',
      name: 'codeLink',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Valid Code`
  String get invalidCode {
    return Intl.message(
      'Please Enter Valid Code',
      name: 'invalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emptyEmail {
    return Intl.message(
      'Email is required',
      name: 'emptyEmail',
      desc: '',
      args: [],
    );
  }

  /// `Address is required`
  String get emptyaddress {
    return Intl.message(
      'Address is required',
      name: 'emptyaddress',
      desc: '',
      args: [],
    );
  }

  /// `Not a valid email address. Should be your@email.com`
  String get invalidEmail {
    return Intl.message(
      'Not a valid email address. Should be your@email.com',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password must equal Password`
  String get notValidConfirmPassword {
    return Intl.message(
      'Confirm Password must equal Password',
      name: 'notValidConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter New Password`
  String get enterPassword {
    return Intl.message(
      'Please Enter New Password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Look like you haven't added any product yet`
  String get emptybag {
    return Intl.message(
      'Look like you haven\'t added any product yet',
      name: 'emptybag',
      desc: '',
      args: [],
    );
  }

  /// `success`
  String get success {
    return Intl.message(
      'success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Your order will be delivered soon.\nThank you for choosing our app!`
  String get successMsg {
    return Intl.message(
      'Your order will be delivered soon.\nThank you for choosing our app!',
      name: 'successMsg',
      desc: '',
      args: [],
    );
  }

  /// `Update Profile`
  String get updateprofile {
    return Intl.message(
      'Update Profile',
      name: 'updateprofile',
      desc: '',
      args: [],
    );
  }

  /// `Profile Updated Successfully`
  String get updateproflesuccess {
    return Intl.message(
      'Profile Updated Successfully',
      name: 'updateproflesuccess',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get editPersonalInfo {
    return Intl.message(
      'Personal Information',
      name: 'editPersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `upload_profile_picture`
  String get profilePicture {
    return Intl.message(
      'upload_profile_picture',
      name: 'profilePicture',
      desc: '',
      args: [],
    );
  }

  /// `photo_gallery`
  String get photoGalley {
    return Intl.message(
      'photo_gallery',
      name: 'photoGalley',
      desc: '',
      args: [],
    );
  }

  /// `Review sent Successfully`
  String get sendreviewsuccess {
    return Intl.message(
      'Review sent Successfully',
      name: 'sendreviewsuccess',
      desc: '',
      args: [],
    );
  }

  /// `camera`
  String get photoCamera {
    return Intl.message(
      'camera',
      name: 'photoCamera',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get donthaveAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'donthaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get haveAccount {
    return Intl.message(
      'Already have an account?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter Phone Number`
  String get enterphone {
    return Intl.message(
      'Enter Phone Number',
      name: 'enterphone',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Address`
  String get deliveryAddress {
    return Intl.message(
      'Delivery Address',
      name: 'deliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Address Line`
  String get addressLine {
    return Intl.message(
      'Address Line',
      name: 'addressLine',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message(
      'search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Phone is Required`
  String get phoneRequired {
    return Intl.message(
      'Phone is Required',
      name: 'phoneRequired',
      desc: '',
      args: [],
    );
  }

  /// `Search Location`
  String get searchlocation {
    return Intl.message(
      'Search Location',
      name: 'searchlocation',
      desc: '',
      args: [],
    );
  }

  /// `Delivery Method`
  String get deliveryMethod {
    return Intl.message(
      'Delivery Method',
      name: 'deliveryMethod',
      desc: '',
      args: [],
    );
  }

  /// `Select New Address`
  String get selectnewaddress {
    return Intl.message(
      'Select New Address',
      name: 'selectnewaddress',
      desc: '',
      args: [],
    );
  }

  /// `Current Location`
  String get currentLocation {
    return Intl.message(
      'Current Location',
      name: 'currentLocation',
      desc: '',
      args: [],
    );
  }

  /// `What is you rate?`
  String get whatrate {
    return Intl.message(
      'What is you rate?',
      name: 'whatrate',
      desc: '',
      args: [],
    );
  }

  /// `Add New`
  String get addNew {
    return Intl.message(
      'Add New',
      name: 'addNew',
      desc: '',
      args: [],
    );
  }

  /// `phone number must be more than 10 and less than 15`
  String get phonemust {
    return Intl.message(
      'phone number must be more than 10 and less than 15',
      name: 'phonemust',
      desc: '',
      args: [],
    );
  }

  /// `Please share your opinion\nabout the product`
  String get plsshareopinion {
    return Intl.message(
      'Please share your opinion\nabout the product',
      name: 'plsshareopinion',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Shop`
  String get shop {
    return Intl.message(
      'Shop',
      name: 'shop',
      desc: '',
      args: [],
    );
  }

  /// `Auction`
  String get auction {
    return Intl.message(
      'Auction',
      name: 'auction',
      desc: '',
      args: [],
    );
  }

  /// `details`
  String get details {
    return Intl.message(
      'details',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changepass {
    return Intl.message(
      'Change Password',
      name: 'changepass',
      desc: '',
      args: [],
    );
  }

  /// `Favorite`
  String get favorite {
    return Intl.message(
      'Favorite',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Your review`
  String get yourReview {
    return Intl.message(
      'Your review',
      name: 'yourReview',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personalinfo {
    return Intl.message(
      'Personal Information',
      name: 'personalinfo',
      desc: '',
      args: [],
    );
  }

  /// `Orders Details`
  String get orders {
    return Intl.message(
      'Orders Details',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Order:`
  String get order {
    return Intl.message(
      'Order:',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Delivery:`
  String get delivery {
    return Intl.message(
      'Delivery:',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Summary:`
  String get summery {
    return Intl.message(
      'Summary:',
      name: 'summery',
      desc: '',
      args: [],
    );
  }

  /// `Submit Order`
  String get submitOrder {
    return Intl.message(
      'Submit Order',
      name: 'submitOrder',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Update & Change Password`
  String get changePasswordsub {
    return Intl.message(
      'Update & Change Password',
      name: 'changePasswordsub',
      desc: '',
      args: [],
    );
  }

  /// `Edit Avatar, name, email`
  String get edit {
    return Intl.message(
      'Edit Avatar, name, email',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `My Bag`
  String get mybag {
    return Intl.message(
      'My Bag',
      name: 'mybag',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `There is No Favorite yet!`
  String get notfavorite {
    return Intl.message(
      'There is No Favorite yet!',
      name: 'notfavorite',
      desc: '',
      args: [],
    );
  }

  /// `There is No Products in Bag yet!`
  String get notCart {
    return Intl.message(
      'There is No Products in Bag yet!',
      name: 'notCart',
      desc: '',
      args: [],
    );
  }

  /// `Total amount`
  String get totalAmount {
    return Intl.message(
      'Total amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `invite_your_friends`
  String get inviteYourFriends {
    return Intl.message(
      'invite_your_friends',
      name: 'inviteYourFriends',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `This email has been used before`
  String get badRequestError {
    return Intl.message(
      'This email has been used before',
      name: 'badRequestError',
      desc: '',
      args: [],
    );
  }

  /// `no_content`
  String get noContent {
    return Intl.message(
      'no_content',
      name: 'noContent',
      desc: '',
      args: [],
    );
  }

  /// `forbidden_error`
  String get forbiddenError {
    return Intl.message(
      'forbidden_error',
      name: 'forbiddenError',
      desc: '',
      args: [],
    );
  }

  /// `UNAUTHORIZED: Invalid Input Data`
  String get unauthorizedError {
    return Intl.message(
      'UNAUTHORIZED: Invalid Input Data',
      name: 'unauthorizedError',
      desc: '',
      args: [],
    );
  }

  /// `ERROR: Not Found`
  String get notFoundError {
    return Intl.message(
      'ERROR: Not Found',
      name: 'notFoundError',
      desc: '',
      args: [],
    );
  }

  /// `conflict_error`
  String get conflictError {
    return Intl.message(
      'conflict_error',
      name: 'conflictError',
      desc: '',
      args: [],
    );
  }

  /// `internal_server_error`
  String get internalServerError {
    return Intl.message(
      'internal_server_error',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `unknown_error`
  String get unknownError {
    return Intl.message(
      'unknown_error',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `timeout_error`
  String get timeoutError {
    return Intl.message(
      'timeout_error',
      name: 'timeoutError',
      desc: '',
      args: [],
    );
  }

  /// `Error In Fetching Data`
  String get defaultError {
    return Intl.message(
      'Error In Fetching Data',
      name: 'defaultError',
      desc: '',
      args: [],
    );
  }

  /// `cache_error`
  String get cacheError {
    return Intl.message(
      'cache_error',
      name: 'cacheError',
      desc: '',
      args: [],
    );
  }

  /// `Please Check Your Internet Connection`
  String get noInternetError {
    return Intl.message(
      'Please Check Your Internet Connection',
      name: 'noInternetError',
      desc: '',
      args: [],
    );
  }

  /// `Products Above`
  String get productsAbove {
    return Intl.message(
      'Products Above',
      name: 'productsAbove',
      desc: '',
      args: [],
    );
  }

  /// `Stars`
  String get stars {
    return Intl.message(
      'Stars',
      name: 'stars',
      desc: '',
      args: [],
    );
  }

  /// `All Products >>`
  String get allProducts {
    return Intl.message(
      'All Products >>',
      name: 'allProducts',
      desc: '',
      args: [],
    );
  }

  /// `Save Address`
  String get saveAddress {
    return Intl.message(
      'Save Address',
      name: 'saveAddress',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullName {
    return Intl.message(
      'Full name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `D. Rice`
  String get fullNameHint {
    return Intl.message(
      'D. Rice',
      name: 'fullNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `3 NewBridge Court `
  String get addressHint {
    return Intl.message(
      '3 NewBridge Court ',
      name: 'addressHint',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Chino Hills`
  String get cityHint {
    return Intl.message(
      'Chino Hills',
      name: 'cityHint',
      desc: '',
      args: [],
    );
  }

  /// `State/Province/Region`
  String get province {
    return Intl.message(
      'State/Province/Region',
      name: 'province',
      desc: '',
      args: [],
    );
  }

  /// `California`
  String get provinceHint {
    return Intl.message(
      'California',
      name: 'provinceHint',
      desc: '',
      args: [],
    );
  }

  /// `Zip Code (Postal Code)`
  String get zipCode {
    return Intl.message(
      'Zip Code (Postal Code)',
      name: 'zipCode',
      desc: '',
      args: [],
    );
  }

  /// `91709`
  String get zipCodeHint {
    return Intl.message(
      '91709',
      name: 'zipCodeHint',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `United States`
  String get countryHint {
    return Intl.message(
      'United States',
      name: 'countryHint',
      desc: '',
      args: [],
    );
  }

  /// `No reviews yet`
  String get notYetReview {
    return Intl.message(
      'No reviews yet',
      name: 'notYetReview',
      desc: '',
      args: [],
    );
  }

  /// `Go to cart`
  String get goToCart {
    return Intl.message(
      'Go to cart',
      name: 'goToCart',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get dateOfBirth {
    return Intl.message(
      'Date of birth',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `Now`
  String get now {
    return Intl.message(
      'Now',
      name: 'now',
      desc: '',
      args: [],
    );
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message(
      'Upcoming',
      name: 'upcoming',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Starting price`
  String get startingPrice {
    return Intl.message(
      'Starting price',
      name: 'startingPrice',
      desc: '',
      args: [],
    );
  }

  /// `Current Bid Price`
  String get currentBidPrice {
    return Intl.message(
      'Current Bid Price',
      name: 'currentBidPrice',
      desc: '',
      args: [],
    );
  }

  /// `Data loading ...`
  String get dataLoading {
    return Intl.message(
      'Data loading ...',
      name: 'dataLoading',
      desc: '',
      args: [],
    );
  }

  /// `There is no auctions yet!`
  String get notauction {
    return Intl.message(
      'There is no auctions yet!',
      name: 'notauction',
      desc: '',
      args: [],
    );
  }

  /// `There is no products yet!`
  String get noProducts {
    return Intl.message(
      'There is no products yet!',
      name: 'noProducts',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `There is no notification yet!`
  String get noNotification {
    return Intl.message(
      'There is no notification yet!',
      name: 'noNotification',
      desc: '',
      args: [],
    );
  }

  /// `No one has entered the auction yet!`
  String get noUserAuction {
    return Intl.message(
      'No one has entered the auction yet!',
      name: 'noUserAuction',
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
