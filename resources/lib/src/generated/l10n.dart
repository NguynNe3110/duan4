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
  S([String? locale]);

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
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
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you machine_learning S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Fake Login`
  String get fakeLogin {
    return Intl.message('Fake Login', name: 'fakeLogin', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `unknownException ({errorCode})`
  String unknownException(Object errorCode) {
    return Intl.message(
      'unknownException ($errorCode)',
      name: 'unknownException',
      desc: '',
      args: [errorCode],
    );
  }

  /// `parseException`
  String get parseException {
    return Intl.message(
      'parseException',
      name: 'parseException',
      desc: '',
      args: [],
    );
  }

  /// `cancellationException`
  String get cancellationException {
    return Intl.message(
      'cancellationException',
      name: 'cancellationException',
      desc: '',
      args: [],
    );
  }

  /// `noInternetException`
  String get noInternetException {
    return Intl.message(
      'noInternetException',
      name: 'noInternetException',
      desc: '',
      args: [],
    );
  }

  /// `timeoutException`
  String get timeoutException {
    return Intl.message(
      'timeoutException',
      name: 'timeoutException',
      desc: '',
      args: [],
    );
  }

  /// `badCertificateException`
  String get badCertificateException {
    return Intl.message(
      'badCertificateException',
      name: 'badCertificateException',
      desc: '',
      args: [],
    );
  }

  /// `Can not connect to this host`
  String get canNotConnectToHost {
    return Intl.message(
      'Can not connect to this host',
      name: 'canNotConnectToHost',
      desc: '',
      args: [],
    );
  }

  /// `tokenExpired`
  String get tokenExpired {
    return Intl.message(
      'tokenExpired',
      name: 'tokenExpired',
      desc: '',
      args: [],
    );
  }

  /// `emptyEmail`
  String get emptyEmail {
    return Intl.message('emptyEmail', name: 'emptyEmail', desc: '', args: []);
  }

  /// `invalidEmail`
  String get invalidEmail {
    return Intl.message(
      'invalidEmail',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `invalidPassword`
  String get invalidPassword {
    return Intl.message(
      'invalidPassword',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `invalidUserName`
  String get invalidUserName {
    return Intl.message(
      'invalidUserName',
      name: 'invalidUserName',
      desc: '',
      args: [],
    );
  }

  /// `invalidPhoneNumber`
  String get invalidPhoneNumber {
    return Intl.message(
      'invalidPhoneNumber',
      name: 'invalidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `invalidDateTime`
  String get invalidDateTime {
    return Intl.message(
      'invalidDateTime',
      name: 'invalidDateTime',
      desc: '',
      args: [],
    );
  }

  /// `passwordsAreNotMatch`
  String get passwordsAreNotMatch {
    return Intl.message(
      'passwordsAreNotMatch',
      name: 'passwordsAreNotMatch',
      desc: '',
      args: [],
    );
  }

  String get noItemSelected {
    return Intl.message(
      'noItemSelected',
      name: 'noItemSelected',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message('OK', name: 'ok', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Search`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Search`
  String get favorite {
    return Intl.message('Favorite', name: 'favorite', desc: '', args: []);
  }

  /// `My Page`
  String get myPage {
    return Intl.message('My Page', name: 'myPage', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message('Dark Theme', name: 'darkTheme', desc: '', args: []);
  }

  /// `Japanese`
  String get japanese {
    return Intl.message('Japanese', name: 'japanese', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ja'),
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
