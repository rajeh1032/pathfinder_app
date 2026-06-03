-----------------------

flutter clean
flutter pub get
-----------------------

code generation :
 flutter pub run build_runner build
flutter pub run build_runner build --delete-conflicting-outputs
flutter pub run build_runner watch
------------------

easy_localization: "ملفات الترجمة "
flutter pub run easy_localization:generate -S assets/translations
flutter pub run easy_localization:generate -S assets/translations -f keys -o locale_keys.g.dart
flutter pub run easy_localization:generate -S assets/translations -f keys -O lib/generated -o locale_keys.g.dart
