import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'package:scriber/main.dart' as app;
import 'package:scriber/src/utilities/constants/keys.dart';

void main() {
  patrolTest('instrumented tests', nativeAutomation: true, (tester) async {
    await showFirstFrame(tester);
    await findAndTapTermsAndConditionsHyperlink(tester);
    await findAndTapSignInButton(tester);
    await findAndTapCreateNoteButton(tester);
    await setTitleAndBodyTexts(tester, title: 'The Quick Brown Fox.', body: 'Jumps over the lazy dog.');
    await saveNote(tester);
    await viewNoteDetails(tester);
    await editNote(tester, title: 'The Quick Brown Fox and Hyaena.', body: 'Jumps over the lazy dog and cat.');
    await attempToExitWithoutSaving(tester);
    await discardUnsavedChanges(tester);
    await viewNoteDetails(tester);
    await editNote(tester, title: 'The Quick Brown Fox and Hyaena.', body: 'Jumps over the lazy dog and cat.');
    await attempToExitWithoutSaving(tester);
    await saveUnSavedChanges(tester);
    await searchForNote(tester);
    await deleteNote(tester);
    await showSettings(tester);
    await changeLanguageSettings(tester);
    await showSettings(tester);
    await changeThemeSettings(tester);
    await showSettings(tester);
    await showAboutScriber(tester);
    await signOutUser(tester);
  });
}

/// Mark: load plugins and wait for first frame to be rendered.
Future<void> showFirstFrame(PatrolTester t) async {
  await app.main();
  return await t.pump();
}

/// Mark: find and tap on the terms and conditions hyper link.
/// Press back to exit the browser after 7 seconds.
Future<void> findAndTapTermsAndConditionsHyperlink(PatrolTester t) async {
  final hyperlink = find.byKey(Keys.termsAndConditions);
  expect(hyperlink, findsOneWidget, reason: 'There must be T&C link for users to tap on and read before sigin.');
  await t.tap(hyperlink, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 7));
  return await t.native.pressBack();
}

/// Mark: find and tap the sign in with google button to login.
Future<void> findAndTapSignInButton(PatrolTester t) async {
  final button = find.byKey(Keys.signInButton);
  expect(button, findsOneWidget, reason: 'There must be a sign in button to start the login process.');
  return await t.tap(button, settlePolicy: SettlePolicy.trySettle);
}

/// Mark: find and tap the create note floating action button
/// to show the create note screen.
Future<void> findAndTapCreateNoteButton(PatrolTester t) async {
  final button = find.byType(FloatingActionButton);
  expect(button, findsOneWidget, reason: 'There must be a FAB to create a new note.');
  return await t.tap(button, settlePolicy: SettlePolicy.trySettle);
}

/// Mark: find and the title and body text fields and insert texts.
Future<void> setTitleAndBodyTexts(PatrolTester t, {required String title, required String body}) async {
  final titleTextField = find.byKey(Keys.titleTextField);
  final bodyTextField = find.byKey(Keys.bodyTextField);
  expect(titleTextField, findsOneWidget, reason: 'There must be a title TextField.');
  expect(bodyTextField, findsOneWidget, reason: 'There must be a body TextField.');

  await t.tap(titleTextField, settlePolicy: SettlePolicy.trySettle);
  await t.enterText(titleTextField, title, settlePolicy: SettlePolicy.trySettle);

  await t.tap(bodyTextField, settlePolicy: SettlePolicy.trySettle);
  await t.enterText(bodyTextField, body, settlePolicy: SettlePolicy.trySettle);
  return await Future.delayed(const Duration(seconds: 2));
}

/// Mark: find and tap the save icon button to save the note.
Future<void> saveNote(PatrolTester t) async {
  final saveButton = find.byKey(Keys.saveButton);
  expect(saveButton, findsOneWidget, reason: 'There must be a save button on the create note app bar.');
  await t.tap(saveButton, settlePolicy: SettlePolicy.trySettle);
  return await Future.delayed(const Duration(seconds: 2));
}

/// Mark: tap saved note and view it in detail.
Future<void> viewNoteDetails(PatrolTester t) async {
  final noteCard = find.byKey(Keys.noteCard);
  expect(noteCard, findsOneWidget, reason: 'We expect to see 1 note card since a note was just saved.');
  await t.tap(noteCard, settlePolicy: SettlePolicy.trySettle);
  return await Future.delayed(const Duration(seconds: 2));
}

/// Mark: tap the edit icon button and edit note.
Future<void> editNote(PatrolTester t, {required String title, required String body}) async {
  final editButton = find.byKey(Keys.editButton);
  expect(editButton, findsOneWidget, reason: 'There must be an edit button on the create app bar.');
  await t.tap(editButton, settlePolicy: SettlePolicy.trySettle);
  return await setTitleAndBodyTexts(t, title: title, body: body);
}

Future<void> attempToExitWithoutSaving(PatrolTester t) async {
  final backButton = find.byKey(Keys.backButton);
  expect(backButton, findsOneWidget, reason: 'There must be a back button on the create note app bar.');
  return await t.tap(backButton, settlePolicy: SettlePolicy.trySettle);
}

/// Mark: attempt to exit edit note mode without saving it to trigger
/// the unsaved changes prompt and tap the discard button to discard it.
Future<void> discardUnsavedChanges(PatrolTester t) async {
  final discardButton = find.byKey(Keys.bsNegativeButton);
  expect(discardButton, findsOneWidget, reason: 'There must be a discard button on the bottom sheet.');
  return await t.tap(discardButton, settlePolicy: SettlePolicy.trySettle);
}

/// Mark: attempt to exit edit note mode without saving it to trigger
/// the unsaved changes prompt and tap the save button to save it.
Future<void> saveUnSavedChanges(PatrolTester t) async {
  final saveChangesButton = find.byKey(Keys.bsPositiveButton);
  expect(saveChangesButton, findsOneWidget, reason: 'There must be a save button on the bottom sheet.');
  return await t.tap(saveChangesButton, settlePolicy: SettlePolicy.trySettle);
}

/// Mark: search for note using its keywords.
Future<void> searchForNote(PatrolTester t) async {
  final searchButton = find.byKey(Keys.searchButton);
  expect(searchButton, findsOneWidget, reason: 'There must be a search button on the notes app bar.');
  await t.tap(searchButton, settlePolicy: SettlePolicy.trySettle);

  final searchTextField = find.byKey(Keys.searchTextField);
  await t.tap(searchTextField, settlePolicy: SettlePolicy.trySettle);
  expect(searchTextField, findsOneWidget, reason: 'There must be a search bar field.');
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: search for non-existent mango keyword.
  await t.enterText(searchTextField, 'mango', settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: search for existent brown fox keywords.
  await t.enterText(searchTextField, 'brown fox', settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: clear search bar and show all notes.
  await t.enterText(searchTextField, '', settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: search for existent dog and cat keywords.
  await t.enterText(searchTextField, 'dog and cat', settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  final backButton = find.byKey(Keys.backButton);
  expect(backButton, findsOneWidget, reason: 'There must be a back button on the search notes app bar.');
  return await t.tap(backButton, settlePolicy: SettlePolicy.trySettle);
}

/// Mark: delete note from the database and memory.
Future<void> deleteNote(PatrolTester t) async {
  await viewNoteDetails(t);

  /// Mark: tap the delete button.
  final deleteButton = find.byKey(Keys.deleteButton);
  expect(deleteButton, findsOneWidget, reason: 'There must be a delete button on the preview note app bar.');
  await t.tap(deleteButton, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: cancel the delete prompt.
  final cancelButton = find.byKey(Keys.bsNegativeButton);
  expect(cancelButton, findsOneWidget, reason: 'There must be a cancel button on the bottom sheet.');
  await t.tap(cancelButton, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: show the delete prompt again.
  await t.tap(deleteButton, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: accept the delete prompt.
  final yesDeleteButton = find.byKey(Keys.bsPositiveButton);
  expect(yesDeleteButton, findsOneWidget, reason: 'There must be a yes, delete it button on the bottom sheet.');
  await t.tap(yesDeleteButton, settlePolicy: SettlePolicy.trySettle);
  return await Future.delayed(const Duration(seconds: 2));
}

/// Mark: navigate to the settings screen.
Future<void> showSettings(PatrolTester t) async {
  final settingsButton = find.byKey(Keys.settingsButton);
  expect(settingsButton, findsOneWidget, reason: 'There must be a settings button on the notes app bar.');
  await t.tap(settingsButton, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));
}

/// Mark: change the language locale from English to French and vice-versa.
Future<void> changeLanguageSettings(PatrolTester t) async {
  /// Mark: tap the languages list tile
  final languagesListTile = find.byKey(Keys.languagesListTile);
  expect(languagesListTile, findsOneWidget, reason: 'There must be a languages list tile under settings.');
  await t.tap(languagesListTile, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: tap the french language option.
  final frenchListTile = find.byKey(Keys.frenchListTile);
  expect(frenchListTile, findsOneWidget, reason: 'There must be an french option for languages.');
  await t.tap(frenchListTile, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: go back to showcase change of language to french.
  final backButton = find.byKey(Keys.backButton);
  expect(backButton, findsOneWidget, reason: 'There must be a back button on the settings app bar.');
  await t.tap(backButton, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: show the language options again.
  await showSettings(t);
  await t.tap(languagesListTile, settlePolicy: SettlePolicy.trySettle);

  /// Mark: tap the english language option to change the language back to english.
  final englishListTile = find.byKey(Keys.englishListTile);
  expect(englishListTile, findsOneWidget, reason: 'There must be an english option for languages.');
  await t.tap(englishListTile, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: go back to showcase change of language to english.
  await t.tap(backButton, settlePolicy: SettlePolicy.trySettle);
  return await Future.delayed(const Duration(seconds: 2));
}

/// Mark: change the theme from Dark to Light and vice-versa.
Future<void> changeThemeSettings(PatrolTester t) async {
  /// Mark: tap the themes list tile
  final themesListTile = find.byKey(Keys.themesListTile);
  expect(themesListTile, findsOneWidget, reason: 'There must be a themes list tile under settings.');
  await t.tap(themesListTile, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: tap the light theme option.
  final lightThemeListTile = find.byKey(Keys.lightThemeListTile);
  expect(lightThemeListTile, findsOneWidget, reason: 'There must be a light theme option for themes.');
  await t.tap(lightThemeListTile, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: go back to showcase change of theme to dark theme.
  final backButton = find.byKey(Keys.backButton);
  expect(backButton, findsOneWidget, reason: 'There must be a back button on the settings app bar.');
  await t.tap(backButton, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: show the themes options again.
  await showSettings(t);
  await t.tap(themesListTile, settlePolicy: SettlePolicy.trySettle);

  /// Mark: tap the light theme option to change the theme back to dark theme.
  final darkThemeListTile = find.byKey(Keys.darkThemeListTile);
  expect(darkThemeListTile, findsOneWidget, reason: 'There must be a dark theme option for themes.');
  await t.tap(darkThemeListTile, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  /// Mark: go back to showcase change of theme to dark.
  await t.tap(backButton, settlePolicy: SettlePolicy.trySettle);
  return await Future.delayed(const Duration(seconds: 2));
}

/// Mark: show the about Scriber screen
Future<void> showAboutScriber(PatrolTester t) async {
  /// Mark: tap the about scriber list tile.
  final aboutScriberListTile = find.byKey(Keys.aboutScriberListTile);
  expect(aboutScriberListTile, findsOneWidget, reason: 'There must be an about scriber list tile under settings.');
  await t.tap(aboutScriberListTile, settlePolicy: SettlePolicy.trySettle);
  await Future.delayed(const Duration(seconds: 2));

  final backButton = find.byKey(Keys.backButton);
  expect(backButton, findsOneWidget, reason: 'There must be a back button on the about scriber app bar.');
  return await t.tap(backButton, settlePolicy: SettlePolicy.trySettle);
}

/// Mark: sign user out the app and show the sign in with google screen.
Future<void> signOutUser(PatrolTester t) async {
  final signOutListTile = find.byKey(Keys.signOutListTile);
  expect(signOutListTile, findsOneWidget, reason: 'There must be a sign out list tile under settings.');
  await t.tap(signOutListTile, settlePolicy: SettlePolicy.trySettle);
  return await Future.delayed(const Duration(seconds: 2));
}
