import 'strings.dart';

/// The translations for French (`fr`).
class StringsFr extends Strings {
  StringsFr([String locale = 'fr']) : super(locale);

  @override
  String get scriber => 'Scriber';

  @override
  String get oops => 'Oops';

  @override
  String get yourAccountHasBeenDisabled => 'Votre compte a été désactivé.\nVeuillez contacter l\'assistance Scriber pour obtenir de l\'aide.';

  @override
  String get pleaseCheckYourInternet => 'S\'il vous plaît, vérifiez votre connexion à internet et réessayez.';

  @override
  String get pleaseCrosscheckYourEmailAddress => 'Veuillez recouper votre adresse e-mail et réessayer.';

  @override
  String get verificationCancelled => 'Vérification annulée.';

  @override
  String get signInCancelled => 'Connexion annulée.';

  @override
  String get signinWithGoogle => 'Connectez-vous avec Google';

  @override
  String get welcome => 'Bienvenu';

  @override
  String get neverMissAnOpportunity => 'Ne manquez jamais une occasion de noter vos pensées avec Scriber.';

  @override
  String get byContinuingYouAgreeToOur => 'En continuant, vous acceptez nos';

  @override
  String get termsAndConditions => 'Termes et conditions';

  @override
  String get ok => 'D\'accord';

  @override
  String get pressTheBackKey => 'Appuyez à nouveau sur la touche de retour pour quitter l\'application.';

  @override
  String get notes => 'Remarques';

  @override
  String get search => 'Recherche';

  @override
  String get settings => 'Paramètres';

  @override
  String get createYourFirstNote => 'Créez votre première note!';

  @override
  String get close => 'Fermer';

  @override
  String get back => 'Dos';

  @override
  String get save => 'Sauvegarder';

  @override
  String get delete => 'Supprimer';

  @override
  String get edit => 'Modifier';

  @override
  String get signOut => 'Se déconnecter';

  @override
  String get languages => 'Langages';

  @override
  String get themes => 'Thèmes';

  @override
  String get defaultTheme => 'Thème par défaut';

  @override
  String get lightTheme => 'Thème Lumière';

  @override
  String get darkTheme => 'Thème sombre';

  @override
  String get switchBetweenLightAndDark => 'Basculez entre les thèmes clairs et sombres.';

  @override
  String get defaultLanguage => 'Langage par défaut';

  @override
  String get english => 'Anglais';

  @override
  String get french => 'Français';

  @override
  String get switchBetweenEnglishAndFrench => 'Basculer entre les langues anglaise et française.';

  @override
  String get title => 'Titre';

  @override
  String get typeSomething => 'Tapez quelque chose...';

  @override
  String get titleCannotBeEmpty => 'Le titre ne peut pas être vide.';

  @override
  String get bodyCannotBeEmpty => 'Le corps ne peut pas être vide.';

  @override
  String get createNote => 'Créer une note';

  @override
  String get deleteNote => 'Delete Note';

  @override
  String get thisActionIsIrreversible => 'Cette action est irréversible. Procéder?';

  @override
  String get yesDeleteIt => 'Oui, supprimez-le.';

  @override
  String get cancel => 'Annuler';

  @override
  String get unsavedChanges => 'Modifications non enregistrées';

  @override
  String get doYouWantToSaveYourChanges => 'Voulez-vous enregistrer vos modifications?';

  @override
  String get discard => 'Jeter';

  @override
  String get searchByTheKeyword => 'Recherche par mot clé...';

  @override
  String get noteNotFound => 'Remarque introuvable. Essayez un autre mot-clé.';

  @override
  String get aboutScriber => 'À propos de Scriber';

  @override
  String designedBy(String name) {
    return 'Conçu par: $name';
  }

  @override
  String redesignedBy(String name) {
    return 'Redessiné par: $name';
  }

  @override
  String illustrationsBy(String name) {
    return 'Illustrations par: $name';
  }

  @override
  String iconsBy(String name) {
    return 'Icônes par: $name';
  }

  @override
  String fontBy(String name) {
    return 'Police by: $name';
  }

  @override
  String madeWithFlutter(String name) {
    return 'Réalisé avec Flutter 💙 par: $name';
  }
}
