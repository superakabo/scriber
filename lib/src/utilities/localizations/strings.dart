import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'strings_en.dart';
import 'strings_fr.dart';

/// Callers can lookup localized strings with an instance of Strings
/// returned by `Strings.of(context)`.
///
/// Applications need to include `Strings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localizations/strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Strings.localizationsDelegates,
///   supportedLocales: Strings.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Strings.supportedLocales
/// property.
abstract class Strings {
  Strings(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Strings? of(BuildContext context) {
    return Localizations.of<Strings>(context, Strings);
  }

  static const LocalizationsDelegate<Strings> delegate = _StringsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// Scriber
  ///
  /// In en, this message translates to:
  /// **'Scriber'**
  String get scriber;

  /// Oops
  ///
  /// In en, this message translates to:
  /// **'Oops'**
  String get oops;

  /// Your account has been disabled. Please contact Scriber support for assistance.
  ///
  /// In en, this message translates to:
  /// **'Your account has been disabled.\nPlease contact Scriber support for assistance.'**
  String get yourAccountHasBeenDisabled;

  /// Please check your internet connection and try again.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection and try again.'**
  String get pleaseCheckYourInternet;

  /// Please cross-check your email address and try again
  ///
  /// In en, this message translates to:
  /// **'Please cross-check your email address and try again.'**
  String get pleaseCrosscheckYourEmailAddress;

  /// Verification Cancelled.
  ///
  /// In en, this message translates to:
  /// **'Verification Cancelled.'**
  String get verificationCancelled;

  /// Sign in cancelled.
  ///
  /// In en, this message translates to:
  /// **'Sign in cancelled.'**
  String get signInCancelled;

  /// Sign in with Google
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get signinWithGoogle;

  /// Welcome
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Never miss an opportunity to jot down your thoughts with Scriber.
  ///
  /// In en, this message translates to:
  /// **'Never miss an opportunity to jot down your thoughts with Scriber.'**
  String get neverMissAnOpportunity;

  /// By continuing, you agree to our
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our'**
  String get byContinuingYouAgreeToOur;

  /// Terms and Conditions
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// OK
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Press the back key again to exit the app.
  ///
  /// In en, this message translates to:
  /// **'Press the back key again to exit the app.'**
  String get pressTheBackKey;

  /// Notes
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// Search
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Create your first note!
  ///
  /// In en, this message translates to:
  /// **'Create your first note!'**
  String get createYourFirstNote;

  /// Close
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Back
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Save
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Delete
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Sign out
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOut;

  /// Languages
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// Themes
  ///
  /// In en, this message translates to:
  /// **'Themes'**
  String get themes;

  /// Default Theme
  ///
  /// In en, this message translates to:
  /// **'Default Theme'**
  String get defaultTheme;

  /// Light Theme
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get lightTheme;

  /// Dark Theme
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// Switch between light and dark themes.
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark themes.'**
  String get switchBetweenLightAndDark;

  /// Default Language
  ///
  /// In en, this message translates to:
  /// **'Default Language'**
  String get defaultLanguage;

  /// English
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// French
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// Switch between English and French languages.
  ///
  /// In en, this message translates to:
  /// **'Switch between English and French languages.'**
  String get switchBetweenEnglishAndFrench;

  /// Title
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Type something...
  ///
  /// In en, this message translates to:
  /// **'Type something...'**
  String get typeSomething;

  /// Title cannot be empty.
  ///
  /// In en, this message translates to:
  /// **'Title cannot be empty.'**
  String get titleCannotBeEmpty;

  /// Body cannot be empty.
  ///
  /// In en, this message translates to:
  /// **'Body cannot be empty.'**
  String get bodyCannotBeEmpty;

  /// Delete Note
  ///
  /// In en, this message translates to:
  /// **'Delete Note'**
  String get deleteNote;

  /// This action is irreversible. Proceed?
  ///
  /// In en, this message translates to:
  /// **'This action is irreversible. Proceed?'**
  String get thisActionIsIrreversible;

  /// Yes, delete it.
  ///
  /// In en, this message translates to:
  /// **'Yes, delete it.'**
  String get yesDeleteIt;

  /// Cancel
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Unsaved Changes
  ///
  /// In en, this message translates to:
  /// **'Unsaved Changes'**
  String get unsavedChanges;

  /// Do you want to save your changes?
  ///
  /// In en, this message translates to:
  /// **'Do you want to save your changes?'**
  String get doYouWantToSaveYourChanges;

  /// Discard
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// Are your sure you want to discard your changes?
  ///
  /// In en, this message translates to:
  /// **'Are your sure you want to discard your changes?'**
  String get areYouSureYouWantToDiscard;
}

class _StringsDelegate extends LocalizationsDelegate<Strings> {
  const _StringsDelegate();

  @override
  Future<Strings> load(Locale locale) {
    return SynchronousFuture<Strings>(lookupStrings(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_StringsDelegate old) => false;
}

Strings lookupStrings(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return StringsEn();
    case 'fr': return StringsFr();
  }

  throw FlutterError(
    'Strings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
