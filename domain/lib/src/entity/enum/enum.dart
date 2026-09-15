import 'package:flutter/material.dart';
import 'package:resources/resources.dart';
import 'package:shared/shared.dart';

enum InitialAppRoute {
  login,
  main,
}

enum Gender {
  male(ServerRequestResponseConstants.male),
  female(ServerRequestResponseConstants.female),
  other(ServerRequestResponseConstants.other),
  unknown(ServerRequestResponseConstants.unknown);

  const Gender(this.serverValue);
  final int serverValue;

  static const defaultValue = unknown;
}

enum LanguageCode {
  en(
    localeCode: LocaleConstants.en,
    serverValue: ServerRequestResponseConstants.en,
  ),
  ja(
    localeCode: LocaleConstants.ja,
    serverValue: ServerRequestResponseConstants.ja,
  );

  const LanguageCode({
    required this.localeCode,
    required this.serverValue,
  });
  final String localeCode;
  final String serverValue;

  static const defaultValue = en;
}

enum NotificationType {
  unknown,
  newPost,
  liked;

  static const defaultValue = unknown;
}

enum BottomTab {
  home(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_rounded)),
  favorite(icon: Icon(Icons.favorite_outline_rounded), activeIcon: Icon(Icons.favorite_rounded)),
  cart(icon: Icon(Icons.shopping_cart_outlined), activeIcon: Icon(Icons.shopping_cart)),
  myPage(icon: Icon(Icons.person_outline_rounded), activeIcon: Icon(Icons.person_rounded));

  const BottomTab({
    required this.icon,
    required this.activeIcon,
  });
  final Icon icon;
  final Icon activeIcon;

  String get title {
    switch (this) {
      case BottomTab.home:
        return S.current.home;
      case BottomTab.cart:
        return S.current.cart;
      case BottomTab.favorite:
        return S.current.favorite;
      case BottomTab.myPage:
        return S.current.myPage;
    }
  }
}
