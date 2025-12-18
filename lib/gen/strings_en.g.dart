///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsEn with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEn _root = this; // ignore: unused_field

	@override 
	TranslationsEn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEn(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsCommonEn common = _TranslationsCommonEn._(_root);
	@override late final _TranslationsTermsAgreementEn termsAgreement = _TranslationsTermsAgreementEn._(_root);
	@override late final _TranslationsDrawerEn drawer = _TranslationsDrawerEn._(_root);
	@override late final _TranslationsLoginEn login = _TranslationsLoginEn._(_root);
	@override late final _TranslationsFriendsEn friends = _TranslationsFriendsEn._(_root);
	@override late final _TranslationsFriendDetailEn friendDetail = _TranslationsFriendDetailEn._(_root);
	@override late final _TranslationsSearchEn search = _TranslationsSearchEn._(_root);
	@override late final _TranslationsProfileEn profile = _TranslationsProfileEn._(_root);
	@override late final _TranslationsEngageCardEn engageCard = _TranslationsEngageCardEn._(_root);
	@override late final _TranslationsQrScannerEn qrScanner = _TranslationsQrScannerEn._(_root);
	@override late final _TranslationsFavoritesEn favorites = _TranslationsFavoritesEn._(_root);
	@override late final _TranslationsNotificationsEn notifications = _TranslationsNotificationsEn._(_root);
	@override late final _TranslationsEventCalendarEn eventCalendar = _TranslationsEventCalendarEn._(_root);
	@override late final _TranslationsAvatarsEn avatars = _TranslationsAvatarsEn._(_root);
	@override late final _TranslationsWorldDetailEn worldDetail = _TranslationsWorldDetailEn._(_root);
	@override late final _TranslationsAvatarDetailEn avatarDetail = _TranslationsAvatarDetailEn._(_root);
	@override late final _TranslationsGroupsEn groups = _TranslationsGroupsEn._(_root);
	@override late final _TranslationsGroupDetailEn groupDetail = _TranslationsGroupDetailEn._(_root);
	@override late final _TranslationsInventoryEn inventory = _TranslationsInventoryEn._(_root);
	@override late final _TranslationsVrcnsyncEn vrcnsync = _TranslationsVrcnsyncEn._(_root);
	@override late final _TranslationsFeedbackEn feedback = _TranslationsFeedbackEn._(_root);
	@override late final _TranslationsSettingsEn settings = _TranslationsSettingsEn._(_root);
	@override late final _TranslationsCreditsEn credits = _TranslationsCreditsEn._(_root);
	@override late final _TranslationsDownloadEn download = _TranslationsDownloadEn._(_root);
	@override late final _TranslationsInstanceEn instance = _TranslationsInstanceEn._(_root);
	@override late final _TranslationsStatusEn status = _TranslationsStatusEn._(_root);
	@override late final _TranslationsLocationEn location = _TranslationsLocationEn._(_root);
	@override late final _TranslationsReminderEn reminder = _TranslationsReminderEn._(_root);
	@override late final _TranslationsFriendEn friend = _TranslationsFriendEn._(_root);
	@override late final _TranslationsEventCalendarFilterEn eventCalendarFilter = _TranslationsEventCalendarFilterEn._(_root);
}

// Path: common
class _TranslationsCommonEn implements TranslationsCommonJa {
	_TranslationsCommonEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'VRCN';
	@override String get ok => 'OK';
	@override String get cancel => 'Cancel';
	@override String get close => 'Close';
	@override String get save => 'Save';
	@override String get edit => 'Edit';
	@override String get delete => 'Delete';
	@override String get yes => 'Yes';
	@override String get no => 'No';
	@override String get loading => 'Loading...';
	@override String error({required Object error}) => 'An error occurred: ${error}';
	@override String get errorNomessage => 'An error occurred';
	@override String get retry => 'Retry';
	@override String get search => 'Search';
	@override String get settings => 'Settings';
	@override String get confirm => 'Confirm';
	@override String get agree => 'Agree';
	@override String get decline => 'Decline';
	@override String get username => 'Username';
	@override String get password => 'Password';
	@override String get login => 'Login';
	@override String get logout => 'Logout';
	@override String get share => 'Share';
}

// Path: termsAgreement
class _TranslationsTermsAgreementEn implements TranslationsTermsAgreementJa {
	_TranslationsTermsAgreementEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get welcomeTitle => 'Welcome to VRCN';
	@override String get welcomeMessage => 'Before using the app,\nplease review the Terms of Service and Privacy Policy.';
	@override String get termsTitle => 'Terms of Service';
	@override String get termsSubtitle => 'About the conditions for using the app';
	@override String get privacyTitle => 'Privacy Policy';
	@override String get privacySubtitle => 'About the handling of personal information';
	@override String agreeTerms({required Object title}) => 'I agree to the "${title}"';
	@override String get checkContent => 'Check Content';
	@override String get notice => 'This is an unofficial app for VRChat Inc.\nIt is not affiliated with VRChat Inc. in any way.';
}

// Path: drawer
class _TranslationsDrawerEn implements TranslationsDrawerJa {
	_TranslationsDrawerEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get home => 'Home';
	@override String get profile => 'Profile';
	@override String get favorite => 'Favorites';
	@override String get eventCalendar => 'Event Calendar';
	@override String get avatar => 'Avatars';
	@override String get group => 'Groups';
	@override String get inventory => 'Inventory';
	@override String get vrcnsync => 'VRCNSync (β)';
	@override String get review => 'Review';
	@override String get feedback => 'Feedback';
	@override String get settings => 'Settings';
	@override String get userLoading => 'Loading user information...';
	@override String get userError => 'Failed to load user information';
	@override String get retry => 'Retry';
	@override late final _TranslationsDrawerSectionEn section = _TranslationsDrawerSectionEn._(_root);
}

// Path: login
class _TranslationsLoginEn implements TranslationsLoginJa {
	_TranslationsLoginEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => 'Forgot your password?';
	@override String get createAccount => 'Sign up';
	@override String get subtitle => 'Login with your VRChat account';
	@override String get email => 'Email Address';
	@override String get emailHint => 'Enter email or username';
	@override String get passwordHint => 'Enter password';
	@override String get rememberMe => 'Remember me';
	@override String get loggingIn => 'Logging in...';
	@override String get errorEmptyEmail => 'Please enter your username or email address.';
	@override String get errorEmptyPassword => 'Please enter your password.';
	@override String get errorLoginFailed => 'Login failed. Please check your email and password.';
	@override String get twoFactorTitle => 'Two-Factor Authentication';
	@override String get twoFactorSubtitle => 'Please enter the authentication code.';
	@override String get twoFactorInstruction => 'Enter the 6-digit code from\nyour authenticator app.';
	@override String get twoFactorCodeHint => 'Authentication code';
	@override String get verify => 'Verify';
	@override String get verifying => 'Verifying...';
	@override String get errorEmpty2fa => 'Please enter the authentication code.';
	@override String get error2faFailed => 'Two-factor authentication failed. Please check if the code is correct.';
	@override String get backToLogin => 'Back to login';
	@override String get paste => 'Paste';
}

// Path: friends
class _TranslationsFriendsEn implements TranslationsFriendsJa {
	_TranslationsFriendsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Loading friends list...';
	@override String error({required Object error}) => 'Failed to load friends list: ${error}';
	@override String get notFound => 'No friends found.';
	@override String get private => 'Private';
	@override String get active => 'Active';
	@override String get offline => 'Offline';
	@override String get online => 'Online';
	@override String get groupTitle => 'Group by World';
	@override String get refresh => 'Refresh';
	@override String get searchHint => 'Search by friend\'s name';
	@override String get noResult => 'No matching friends found.';
}

// Path: friendDetail
class _TranslationsFriendDetailEn implements TranslationsFriendDetailJa {
	_TranslationsFriendDetailEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Loading user information...';
	@override String error({required Object error}) => 'Failed to load user information: ${error}';
	@override String get currentLocation => 'Current Location';
	@override String get basicInfo => 'Basic Info';
	@override String get userId => 'User ID';
	@override String get dateJoined => 'Date Joined';
	@override String get lastLogin => 'Last Login';
	@override String get bio => 'Bio';
	@override String get links => 'Links';
	@override String get loadingLinks => 'Loading links...';
	@override String get group => 'Groups';
	@override String get groupDetail => 'View Group Details';
	@override String groupCode({required Object code}) => 'Group Code: ${code}';
	@override String memberCount({required Object count}) => 'Members: ${count}';
	@override String get unknownGroup => 'Unknown Group';
	@override String get block => 'Block';
	@override String get mute => 'Mute';
	@override String get openWebsite => 'Open on Website';
	@override String get shareProfile => 'Share Profile';
	@override String confirmBlockTitle({required Object name}) => 'Block ${name}?';
	@override String get confirmBlockMessage => 'If you block this user, you will no longer receive friend requests or messages from them.';
	@override String confirmMuteTitle({required Object name}) => 'Mute ${name}?';
	@override String get confirmMuteMessage => 'If you mute this user, you will no longer hear their voice.';
	@override String get blockSuccess => 'Blocked';
	@override String get muteSuccess => 'Muted';
	@override String operationFailed({required Object error}) => 'Operation failed: ${error}';
}

// Path: search
class _TranslationsSearchEn implements TranslationsSearchJa {
	_TranslationsSearchEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get userTab => 'Users';
	@override String get worldTab => 'Worlds';
	@override String get avatarTab => 'Avatars';
	@override String get groupTab => 'Groups';
	@override late final _TranslationsSearchTabsEn tabs = _TranslationsSearchTabsEn._(_root);
}

// Path: profile
class _TranslationsProfileEn implements TranslationsProfileJa {
	_TranslationsProfileEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Profile';
	@override String get edit => 'Edit';
	@override String get refresh => 'Refresh';
	@override String get loading => 'Loading profile information...';
	@override String get error => 'Failed to load profile information: {error}';
	@override String get displayName => 'Display Name';
	@override String get username => 'Username';
	@override String get userId => 'User ID';
	@override String get engageCard => 'Engage Card';
	@override String get frined => 'Friend';
	@override String get dateJoined => 'Date Joined';
	@override String get userType => 'User Type';
	@override String get status => 'Status';
	@override String get statusMessage => 'Status Message';
	@override String get bio => 'Bio';
	@override String get links => 'Links';
	@override String get group => 'Groups';
	@override String get groupDetail => 'View Group Details';
	@override String get avatar => 'Current Avatar';
	@override String get avatarDetail => 'View Avatar Details';
	@override String get public => 'Public';
	@override String get private => 'Private';
	@override String get hidden => 'Hidden';
	@override String get unknown => 'Unknown';
	@override String get friends => 'Friends';
	@override String get loadingLinks => 'Loading links...';
	@override String get noGroup => 'Not in any groups';
	@override String get noBio => 'No bio available';
	@override String get noLinks => 'No links available';
	@override String get save => 'Save Changes';
	@override String get saved => 'Profile updated successfully.';
	@override String get saveFailed => 'Failed to update: {error}';
	@override String get discardTitle => 'Discard changes?';
	@override String get discardContent => 'Changes made to your profile will not be saved.';
	@override String get discardCancel => 'Cancel';
	@override String get discardOk => 'Discard';
	@override String get basic => 'Basic Info';
	@override String get pronouns => 'Pronouns';
	@override String get addLink => 'Add';
	@override String get removeLink => 'Remove';
	@override String get linkHint => 'Enter link (e.g., https://twitter.com/username)';
	@override String get linksHint => 'Links will be displayed on your profile and can be opened by tapping.';
	@override String get statusMessageHint => 'Enter your current situation or a message.';
	@override String get bioHint => 'Write something about yourself.';
}

// Path: engageCard
class _TranslationsEngageCardEn implements TranslationsEngageCardJa {
	_TranslationsEngageCardEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get pickBackground => 'Select Background Image';
	@override String get removeBackground => 'Remove Background Image';
	@override String get scanQr => 'Scan QR Code';
	@override String get showAvatar => 'Show Avatar';
	@override String get hideAvatar => 'Hide Avatar';
	@override String get noBackground => 'No background image selected.\nYou can set one from the top right button.';
	@override String get loading => 'Loading...';
	@override String error({required Object error}) => 'Failed to load engage card information: ${error}';
	@override String get copyUserId => 'Copy User ID';
	@override String get copied => 'Copied';
}

// Path: qrScanner
class _TranslationsQrScannerEn implements TranslationsQrScannerJa {
	_TranslationsQrScannerEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'QR Code Scan';
	@override String get guide => 'Align the QR code within the frame.';
	@override String get loading => 'Initializing camera...';
	@override String error({required Object error}) => 'Failed to read QR code: ${error}';
	@override String get notFound => 'No valid user QR code found.';
}

// Path: favorites
class _TranslationsFavoritesEn implements TranslationsFavoritesJa {
	_TranslationsFavoritesEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Favorites';
	@override String get frined => 'Friend';
	@override String get friendsTab => 'Friends';
	@override String get worldsTab => 'Worlds';
	@override String get avatarsTab => 'Avatars';
	@override String get emptyFolderTitle => 'No favorite folders';
	@override String get emptyFolderDescription => 'Please create a favorite folder in VRChat.';
	@override String get emptyFriends => 'No friends in this folder.';
	@override String get emptyWorlds => 'No worlds in this folder.';
	@override String get emptyAvatars => 'No avatars in this folder.';
	@override String get emptyWorldsTabTitle => 'No favorite worlds';
	@override String get emptyWorldsTabDescription => 'You can add worlds to favorites from the world details screen.';
	@override String get emptyAvatarsTabTitle => 'No favorite avatars';
	@override String get emptyAvatarsTabDescription => 'You can add avatars to favorites from the avatar details screen.';
	@override String get loading => 'Loading favorites...';
	@override String get loadingFolder => 'Loading folder information...';
	@override String error({required Object error}) => 'Failed to load favorites: ${error}';
	@override String get errorFolder => 'Failed to get information.';
	@override String get remove => 'Remove from Favorites';
	@override String removeSuccess({required Object name}) => 'Removed ${name} from favorites.';
	@override String removeFailed({required Object error}) => 'Failed to remove: ${error}';
	@override String itemsCount({required Object count}) => '${count} items';
	@override String get public => 'Public';
	@override String get private => 'Private';
	@override String get hidden => 'Hidden';
	@override String get unknown => 'Unknown';
	@override String get loadingError => 'Loading Error';
}

// Path: notifications
class _TranslationsNotificationsEn implements TranslationsNotificationsJa {
	_TranslationsNotificationsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => 'No Notifications';
	@override String get emptyDescription => 'New notifications, like friend requests and invites,\nwill appear here.';
	@override String friendRequest({required Object userName}) => 'You have a friend request from ${userName}.';
	@override String invite({required Object worldName, required Object userName}) => 'You have an invite to ${worldName} from ${userName}.';
	@override String friendOnline({required Object userName}) => '${userName} is now online.';
	@override String friendOffline({required Object userName}) => '${userName} is now offline.';
	@override String friendActive({required Object userName}) => '${userName} is now active.';
	@override String friendAdd({required Object userName}) => '${userName} has been added to your friends.';
	@override String friendRemove({required Object userName}) => '${userName} has been removed from your friends.';
	@override String statusUpdate({required Object userName, required Object status, required Object world}) => '${userName}\'s status updated: ${status}${world}';
	@override String locationChange({required Object userName, required Object worldName}) => '${userName} moved to ${worldName}.';
	@override String userUpdate({required Object world}) => 'Your information has been updated${world}.';
	@override String myLocationChange({required Object worldName}) => 'You moved to: ${worldName}';
	@override String requestInvite({required Object userName}) => 'You have a request to join from ${userName}.';
	@override String votekick({required Object userName}) => 'There was a votekick from ${userName}.';
	@override String responseReceived({required Object userName}) => 'Received response for notification ID: ${userName}';
	@override String error({required Object worldName}) => 'Error: ${worldName}';
	@override String system({required Object extraData}) => 'System notification: ${extraData}';
	@override String secondsAgo({required Object seconds}) => '${seconds}s ago';
	@override String minutesAgo({required Object minutes}) => '${minutes}m ago';
	@override String hoursAgo({required Object hours}) => '${hours}h ago';
}

// Path: eventCalendar
class _TranslationsEventCalendarEn implements TranslationsEventCalendarJa {
	_TranslationsEventCalendarEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Event Calendar';
	@override String get filter => 'Filter Events';
	@override String get refresh => 'Refresh Events';
	@override String get loading => 'Loading events...';
	@override String error({required Object error}) => 'Failed to load events: ${error}';
	@override String filterActive({required Object count}) => 'Filter applied (${count} results)';
	@override String get clear => 'Clear';
	@override String get noEvents => 'No events match the criteria.';
	@override String get clearFilter => 'Clear Filter';
	@override String get today => 'Today';
	@override String get reminderSet => 'Set Reminder';
	@override String get reminderSetDone => 'Reminder Set';
	@override String get reminderDeleted => 'Reminder deleted.';
	@override String get eventName => 'Event Name';
	@override String get organizer => 'Organizer';
	@override String get description => 'Description';
	@override String get genre => 'Genre';
	@override String get condition => 'Participation Conditions';
	@override String get way => 'How to Join';
	@override String get note => 'Notes';
	@override String get quest => 'Quest Compatible';
	@override String reminderCount({required Object count}) => '${count}';
	@override String startToEnd({required Object start, required Object end}) => '${start} - ${end}';
}

// Path: avatars
class _TranslationsAvatarsEn implements TranslationsAvatarsJa {
	_TranslationsAvatarsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Avatars';
	@override String get searchHint => 'Search by avatar name, etc.';
	@override String get searchTooltip => 'Search';
	@override String get searchEmptyTitle => 'No search results found.';
	@override String get searchEmptyDescription => 'Please try a different search term.';
	@override String get emptyTitle => 'No avatars';
	@override String get emptyDescription => 'Please add an avatar or try again later.';
	@override String get refresh => 'Refresh';
	@override String get loading => 'Loading avatars...';
	@override String error({required Object error}) => 'Failed to load avatars: ${error}';
	@override String get current => 'In Use';
	@override String get public => 'Public';
	@override String get private => 'Private';
	@override String get hidden => 'Hidden';
	@override String get author => 'Author';
	@override String get sortUpdated => 'By Update Date';
	@override String get sortName => 'By Name';
	@override String get sortTooltip => 'Sort';
	@override String get viewModeTooltip => 'Toggle View Mode';
}

// Path: worldDetail
class _TranslationsWorldDetailEn implements TranslationsWorldDetailJa {
	_TranslationsWorldDetailEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Loading world information...';
	@override String error({required Object error}) => 'Failed to load world information: ${error}';
	@override String get share => 'Share This World';
	@override String get openInVRChat => 'Open on VRChat Official Website';
	@override String get report => 'Report This World';
	@override String get creator => 'Creator';
	@override String get created => 'Created';
	@override String get updated => 'Updated';
	@override String get favorites => 'Favorites';
	@override String get visits => 'Visits';
	@override String get occupants => 'Current Occupants';
	@override String get popularity => 'Popularity';
	@override String get description => 'Description';
	@override String get noDescription => 'No description available.';
	@override String get tags => 'Tags';
	@override String get joinPublic => 'Send Invite to Public Instance';
	@override String get favoriteAdded => 'Added to favorites.';
	@override String get favoriteRemoved => 'Removed from favorites.';
	@override String get unknown => 'Unknown';
}

// Path: avatarDetail
class _TranslationsAvatarDetailEn implements TranslationsAvatarDetailJa {
	_TranslationsAvatarDetailEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String changeSuccess({required Object name}) => 'Changed to avatar "${name}".';
	@override String changeFailed({required Object error}) => 'Failed to change avatar: ${error}';
	@override String get changing => 'Changing...';
	@override String get useThisAvatar => 'Use This Avatar';
	@override String get creator => 'Creator';
	@override String get created => 'Created';
	@override String get updated => 'Updated';
	@override String get description => 'Description';
	@override String get noDescription => 'No description available.';
	@override String get tags => 'Tags';
	@override String get addToFavorites => 'Add to Favorites';
	@override String get public => 'Public';
	@override String get private => 'Private';
	@override String get hidden => 'Hidden';
	@override String get unknown => 'Unknown';
	@override String get share => 'Share';
	@override String get loading => 'Loading avatar information...';
	@override String error({required Object error}) => 'Failed to load avatar information: ${error}';
}

// Path: groups
class _TranslationsGroupsEn implements TranslationsGroupsJa {
	_TranslationsGroupsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Groups';
	@override String get loadingUser => 'Loading user information...';
	@override String errorUser({required Object error}) => 'Failed to load user information: ${error}';
	@override String get loadingGroups => 'Loading group information...';
	@override String errorGroups({required Object error}) => 'Failed to load group information: ${error}';
	@override String get emptyTitle => 'You are not in any groups.';
	@override String get emptyDescription => 'You can join groups from the VRChat app or website.';
	@override String get searchGroups => 'Find Groups';
	@override String members({required Object count}) => '${count} members';
	@override String get showDetails => 'Show Details';
	@override String get unknownName => 'Unknown Name';
}

// Path: groupDetail
class _TranslationsGroupDetailEn implements TranslationsGroupDetailJa {
	_TranslationsGroupDetailEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Loading group information...';
	@override String error({required Object error}) => 'Failed to load group information: ${error}';
	@override String get share => 'Share Group Info';
	@override String get description => 'Description';
	@override String get roles => 'Roles';
	@override String get basicInfo => 'Basic Info';
	@override String get createdAt => 'Created At';
	@override String get owner => 'Owner';
	@override String get rules => 'Rules';
	@override String get languages => 'Languages';
	@override String memberCount({required Object count}) => '${count} Members';
	@override late final _TranslationsGroupDetailPrivacyEn privacy = _TranslationsGroupDetailPrivacyEn._(_root);
	@override late final _TranslationsGroupDetailRoleEn role = _TranslationsGroupDetailRoleEn._(_root);
}

// Path: inventory
class _TranslationsInventoryEn implements TranslationsInventoryJa {
	_TranslationsInventoryEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Inventory';
	@override String get gallery => 'Gallery';
	@override String get icon => 'Icon';
	@override String get emoji => 'Emoji';
	@override String get sticker => 'Sticker';
	@override String get print => 'Print';
	@override String get upload => 'Upload File';
	@override String get uploadGallery => 'Uploading gallery image...';
	@override String get uploadIcon => 'Uploading icon...';
	@override String get uploadEmoji => 'Uploading emoji...';
	@override String get uploadSticker => 'Uploading sticker...';
	@override String get uploadPrint => 'Uploading print image...';
	@override String get selectImage => 'Select Image';
	@override String get selectFromGallery => 'Select from Gallery';
	@override String get takePhoto => 'Take Photo with Camera';
	@override String get uploadSuccess => 'Upload complete.';
	@override String get uploadFailed => 'Upload failed.';
	@override String get uploadFailedFormat => 'There is a problem with the file format or size. Please select a PNG image under 1MB.';
	@override String get uploadFailedAuth => 'Authentication failed. Please log in again.';
	@override String get uploadFailedSize => 'File size is too large. Please select a smaller image.';
	@override String uploadFailedServer({required Object code}) => 'Server error occurred (${code})';
	@override String pickImageFailed({required Object error}) => 'Failed to select image: ${error}';
	@override late final _TranslationsInventoryTabsEn tabs = _TranslationsInventoryTabsEn._(_root);
}

// Path: vrcnsync
class _TranslationsVrcnsyncEn implements TranslationsVrcnsyncJa {
	_TranslationsVrcnsyncEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'VRCNSync (β)';
	@override String get betaTitle => 'Beta Feature';
	@override String get betaDescription => 'This feature is a beta version under development. Unexpected issues may occur.\nCurrently, it is only implemented locally, but a cloud version will be implemented if there is demand.';
	@override String get githubLink => 'VRCNSync GitHub Page';
	@override String get openGithub => 'Open GitHub Page';
	@override String get serverRunning => 'Server Running';
	@override String get serverStopped => 'Server Stopped';
	@override String get serverRunningDesc => 'Saves photos from your PC to the VRCN album.';
	@override String get serverStoppedDesc => 'The server is stopped.';
	@override String get photoSaved => 'Photo saved to VRCN album.';
	@override String get photoReceived => 'Photo received (failed to save to album).';
	@override String get openAlbum => 'Open Album';
	@override String get permissionErrorIos => 'Access to the photo library is required.';
	@override String get permissionErrorAndroid => 'Access to storage is required.';
	@override String get openSettings => 'Open Settings';
	@override String initError({required Object error}) => 'Initialization failed: ${error}';
	@override String get openPhotoAppError => 'Could not open the photo app.';
	@override String get serverInfo => 'Server Information';
	@override String ip({required Object ip}) => 'IP: ${ip}';
	@override String port({required Object port}) => 'Port: ${port}';
	@override String address({required Object ip, required Object port}) => '${ip}:${port}';
	@override String get autoSave => 'Received photos are automatically saved to the "VRCN" album.';
	@override String get usage => 'How to Use';
	@override List<dynamic> get usageSteps => [
		_TranslationsVrcnsync$usageSteps$0i0$En._(_root),
		_TranslationsVrcnsync$usageSteps$0i1$En._(_root),
		_TranslationsVrcnsync$usageSteps$0i2$En._(_root),
		_TranslationsVrcnsync$usageSteps$0i3$En._(_root),
	];
	@override String get stats => 'Connection Status';
	@override String get statServer => 'Server Status';
	@override String get statServerRunning => 'Running';
	@override String get statServerStopped => 'Stopped';
	@override String get statNetwork => 'Network';
	@override String get statNetworkConnected => 'Connected';
	@override String get statNetworkDisconnected => 'Disconnected';
}

// Path: feedback
class _TranslationsFeedbackEn implements TranslationsFeedbackJa {
	_TranslationsFeedbackEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Feedback';
	@override String get type => 'Feedback Type';
	@override Map<String, String> get types => {
		'bug': 'Bug Report',
		'feature': 'Feature Request',
		'improvement': 'Suggestion for Improvement',
		'other': 'Other',
	};
	@override String get inputTitle => 'Title *';
	@override String get inputTitleHint => 'Please be concise.';
	@override String get inputDescription => 'Description *';
	@override String get inputDescriptionHint => 'Please provide a detailed description...';
	@override String get cancel => 'Cancel';
	@override String get send => 'Send';
	@override String get sending => 'Sending...';
	@override String get required => 'Title and description are required.';
	@override String get success => 'Feedback sent. Thank you!';
	@override String get fail => 'Failed to send feedback.';
}

// Path: settings
class _TranslationsSettingsEn implements TranslationsSettingsJa {
	_TranslationsSettingsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get appearance => 'Appearance';
	@override String get language => 'Language';
	@override String get languageDescription => 'You can select the display language for the app.';
	@override String get appIcon => 'App Icon';
	@override String get appIconDescription => 'Change the app icon displayed on the home screen.';
	@override String get contentSettings => 'Content Settings';
	@override String get searchEnabled => 'Search feature enabled.';
	@override String get searchDisabled => 'Search feature disabled.';
	@override String get enableSearch => 'Enable Search';
	@override String get enableSearchDescription => 'Search results may include sexual or violent content.';
	@override String get apiSetting => 'Avatar Search API';
	@override String get apiSettingDescription => 'Set the API for the avatar search feature.';
	@override String get apiSettingSaveUrl => 'URL saved.';
	@override String get notSet => 'Not set (Avatar search feature cannot be used).';
	@override String get notifications => 'Notification Settings';
	@override String get eventReminder => 'Event Reminders';
	@override String get eventReminderDescription => 'Receive notifications before your scheduled events start.';
	@override String get manageReminders => 'Manage Set Reminders';
	@override String get manageRemindersDescription => 'Cancel or check your notifications.';
	@override String get dataStorage => 'Data and Storage';
	@override String get clearCache => 'Clear Cache';
	@override String get clearCacheSuccess => 'Cache cleared.';
	@override String get clearCacheError => 'An error occurred while clearing the cache.';
	@override String cacheSize({required Object size}) => 'Cache size: ${size}';
	@override String get calculatingCache => 'Calculating cache size...';
	@override String get cacheError => 'Could not get cache size.';
	@override String get confirmClearCache => 'Clearing the cache will delete temporarily saved images and data.\n\nYour account information and app settings will not be deleted.';
	@override String get appInfo => 'App Information';
	@override String get version => 'Version';
	@override String get packageName => 'Package Name';
	@override String get credit => 'Credits';
	@override String get creditDescription => 'Developer and contributor information.';
	@override String get contact => 'Contact';
	@override String get contactDescription => 'For bug reports and suggestions.';
	@override String get privacyPolicy => 'Privacy Policy';
	@override String get privacyPolicyDescription => 'About the handling of personal information.';
	@override String get termsOfService => 'Terms of Service';
	@override String get termsOfServiceDescription => 'Conditions for using the app.';
	@override String get openSource => 'Open Source Information';
	@override String get openSourceDescription => 'Licenses for libraries used.';
	@override String get github => 'GitHub Repository';
	@override String get githubDescription => 'View source code.';
	@override String get logoutConfirm => 'Are you sure you want to log out?';
	@override String logoutError({required Object error}) => 'An error occurred during logout: ${error}';
	@override String get iconChangeNotSupported => 'Changing the app icon is not supported on your device.';
	@override String get iconChangeFailed => 'Failed to change icon.';
	@override String get themeMode => 'Theme Mode';
	@override String get themeModeDescription => 'You can select the display theme of the app.';
	@override String get themeLight => 'Light';
	@override String get themeSystem => 'System';
	@override String get themeDark => 'Dark';
	@override String get appIconDefault => 'Default';
	@override String get appIconIcon => 'Icon';
	@override String get appIconLogo => 'Logo';
	@override String get delete => 'Delete';
}

// Path: credits
class _TranslationsCreditsEn implements TranslationsCreditsJa {
	_TranslationsCreditsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Credits';
	@override late final _TranslationsCreditsSectionEn section = _TranslationsCreditsSectionEn._(_root);
}

// Path: download
class _TranslationsDownloadEn implements TranslationsDownloadJa {
	_TranslationsDownloadEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get success => 'Download complete.';
	@override String failure({required Object error}) => 'Download failed: ${error}';
	@override String shareFailure({required Object error}) => 'Sharing failed: ${error}';
	@override String get permissionTitle => 'Permission Required';
	@override String permissionDenied({required Object permissionType}) => 'Permission to save to ${permissionType} has been denied.\nPlease enable the permission from the settings app.';
	@override String get permissionCancel => 'Cancel';
	@override String get permissionOpenSettings => 'Open Settings';
	@override String get permissionPhoto => 'Photos';
	@override String get permissionPhotoLibrary => 'Photo Library';
	@override String get permissionStorage => 'Storage';
	@override String get permissionPhotoRequired => 'Permission to save to photos is required.';
	@override String get permissionPhotoLibraryRequired => 'Permission to save to photo library is required.';
	@override String get permissionStorageRequired => 'Permission to access storage is required.';
	@override String permissionError({required Object error}) => 'An error occurred while checking permissions: ${error}';
	@override String downloading({required Object fileName}) => 'Downloading ${fileName}...';
	@override String sharing({required Object fileName}) => 'Preparing to share ${fileName}...';
}

// Path: instance
class _TranslationsInstanceEn implements TranslationsInstanceJa {
	_TranslationsInstanceEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsInstanceTypeEn type = _TranslationsInstanceTypeEn._(_root);
}

// Path: status
class _TranslationsStatusEn implements TranslationsStatusJa {
	_TranslationsStatusEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get active => 'Online';
	@override String get joinMe => 'Join Me';
	@override String get askMe => 'Ask Me';
	@override String get busy => 'Busy';
	@override String get offline => 'Offline';
	@override String get unknown => 'Unknown Status';
}

// Path: location
class _TranslationsLocationEn implements TranslationsLocationJa {
	_TranslationsLocationEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get private => 'Private';
	@override String playerCount({required Object userCount, required Object capacity}) => 'Players: ${userCount} / ${capacity}';
	@override String instanceType({required Object type}) => 'Instance Type: ${type}';
	@override String get noInfo => 'No location information available.';
	@override String get fetchError => 'Failed to get location information.';
	@override String get privateLocation => 'You are in a private location.';
	@override String get inviteSending => 'Sending invite...';
	@override String get inviteSent => 'Invite sent. You can join from your notifications.';
	@override String inviteFailed({required Object error}) => 'Failed to send invite: ${error}';
	@override String get inviteButton => 'Send Invite to Myself';
	@override String isPrivate({required Object number}) => '${number} in private';
	@override String isActive({required Object number}) => '${number} active';
	@override String isOffline({required Object number}) => '${number} offline';
	@override String isTraveling({required Object number}) => '${number} traveling';
	@override String isStaying({required Object number}) => '${number} staying';
}

// Path: reminder
class _TranslationsReminderEn implements TranslationsReminderJa {
	_TranslationsReminderEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => 'Set Reminder';
	@override String get alreadySet => 'Already Set';
	@override String get set => 'Set';
	@override String get cancel => 'Cancel';
	@override String get delete => 'Delete';
	@override String get deleteAll => 'Delete All Reminders';
	@override String get deleteAllConfirm => 'This will delete all set event reminders. This action cannot be undone.';
	@override String get deleted => 'Reminder deleted.';
	@override String get deletedAll => 'All reminders deleted.';
	@override String get noReminders => 'No reminders set.';
	@override String get setFromEvent => 'You can set notifications from the event page.';
	@override String eventStart({required Object time}) => 'Starts at ${time}';
	@override String notifyAt({required Object time, required Object label}) => '${time} (${label})';
	@override String get receiveNotification => 'When do you want to be notified?';
}

// Path: friend
class _TranslationsFriendEn implements TranslationsFriendJa {
	_TranslationsFriendEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get sortFilter => 'Sort & Filter';
	@override String get filter => 'Filter';
	@override String get filterAll => 'Show All';
	@override String get filterOnline => 'Online Only';
	@override String get filterOffline => 'Offline Only';
	@override String get filterFavorite => 'Favorites Only';
	@override String get sort => 'Sort';
	@override String get sortStatus => 'By Status';
	@override String get sortName => 'By Name';
	@override String get sortLastLogin => 'By Last Login';
	@override String get sortAsc => 'Ascending';
	@override String get sortDesc => 'Descending';
	@override String get close => 'Close';
}

// Path: eventCalendarFilter
class _TranslationsEventCalendarFilterEn implements TranslationsEventCalendarFilterJa {
	_TranslationsEventCalendarFilterEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get filterTitle => 'Filter Events';
	@override String get clear => 'Clear';
	@override String get keyword => 'Keyword Search';
	@override String get keywordHint => 'Event name, description, organizer, etc.';
	@override String get date => 'Filter by Date';
	@override String get dateHint => 'You can display events for a specific date range.';
	@override String get startDate => 'Start Date';
	@override String get endDate => 'End Date';
	@override String get select => 'Please select';
	@override String get time => 'Filter by Time';
	@override String get timeHint => 'You can display events held during a specific time frame.';
	@override String get startTime => 'Start Time';
	@override String get endTime => 'End Time';
	@override String get genre => 'Filter by Genre';
	@override String genreSelected({required Object count}) => '${count} genres selected';
	@override String get apply => 'Apply';
	@override String get filterSummary => 'Filters';
	@override String get filterNone => 'No filters are set.';
}

// Path: drawer.section
class _TranslationsDrawerSectionEn implements TranslationsDrawerSectionJa {
	_TranslationsDrawerSectionEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get content => 'Content';
	@override String get other => 'Other';
}

// Path: search.tabs
class _TranslationsSearchTabsEn implements TranslationsSearchTabsJa {
	_TranslationsSearchTabsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSearchTabsUserSearchEn userSearch = _TranslationsSearchTabsUserSearchEn._(_root);
	@override late final _TranslationsSearchTabsWorldSearchEn worldSearch = _TranslationsSearchTabsWorldSearchEn._(_root);
	@override late final _TranslationsSearchTabsGroupSearchEn groupSearch = _TranslationsSearchTabsGroupSearchEn._(_root);
	@override late final _TranslationsSearchTabsAvatarSearchEn avatarSearch = _TranslationsSearchTabsAvatarSearchEn._(_root);
}

// Path: groupDetail.privacy
class _TranslationsGroupDetailPrivacyEn implements TranslationsGroupDetailPrivacyJa {
	_TranslationsGroupDetailPrivacyEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get public => 'Public';
	@override String get private => 'Private';
	@override String get friends => 'Friends';
	@override String get invite => 'Invite';
	@override String get unknown => 'Unknown';
}

// Path: groupDetail.role
class _TranslationsGroupDetailRoleEn implements TranslationsGroupDetailRoleJa {
	_TranslationsGroupDetailRoleEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get admin => 'Admin';
	@override String get moderator => 'Moderator';
	@override String get member => 'Member';
	@override String get unknown => 'Unknown';
}

// Path: inventory.tabs
class _TranslationsInventoryTabsEn implements TranslationsInventoryTabsJa {
	_TranslationsInventoryTabsEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsInventoryTabsEmojiInventoryEn emojiInventory = _TranslationsInventoryTabsEmojiInventoryEn._(_root);
	@override late final _TranslationsInventoryTabsGalleryInventoryEn galleryInventory = _TranslationsInventoryTabsGalleryInventoryEn._(_root);
	@override late final _TranslationsInventoryTabsIconInventoryEn iconInventory = _TranslationsInventoryTabsIconInventoryEn._(_root);
	@override late final _TranslationsInventoryTabsPrintInventoryEn printInventory = _TranslationsInventoryTabsPrintInventoryEn._(_root);
	@override late final _TranslationsInventoryTabsStickerInventoryEn stickerInventory = _TranslationsInventoryTabsStickerInventoryEn._(_root);
}

// Path: vrcnsync.usageSteps.0
class _TranslationsVrcnsync$usageSteps$0i0$En implements TranslationsVrcnsync$usageSteps$0i0$Ja {
	_TranslationsVrcnsync$usageSteps$0i0$En._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Launch the VRCNSync app on your PC';
	@override String get desc => 'Please launch the VRCNSync app on your PC.';
}

// Path: vrcnsync.usageSteps.1
class _TranslationsVrcnsync$usageSteps$0i1$En implements TranslationsVrcnsync$usageSteps$0i1$Ja {
	_TranslationsVrcnsync$usageSteps$0i1$En._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Connect to the same WiFi network';
	@override String get desc => 'Please connect your PC and mobile device to the same WiFi network.';
}

// Path: vrcnsync.usageSteps.2
class _TranslationsVrcnsync$usageSteps$0i2$En implements TranslationsVrcnsync$usageSteps$0i2$Ja {
	_TranslationsVrcnsync$usageSteps$0i2$En._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Specify the mobile device as the destination';
	@override String get desc => 'Please specify the IP address and port above in the PC app.';
}

// Path: vrcnsync.usageSteps.3
class _TranslationsVrcnsync$usageSteps$0i3$En implements TranslationsVrcnsync$usageSteps$0i3$Ja {
	_TranslationsVrcnsync$usageSteps$0i3$En._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get title => 'Send photos';
	@override String get desc => 'When you send photos from your PC, they will be automatically saved to the VRCN album.';
}

// Path: credits.section
class _TranslationsCreditsSectionEn implements TranslationsCreditsSectionJa {
	_TranslationsCreditsSectionEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get development => 'Development';
	@override String get iconPeople => 'The Fun Icon People';
	@override String get testFeedback => 'Testing & Feedback';
	@override String get specialThanks => 'Special Thanks';
}

// Path: instance.type
class _TranslationsInstanceTypeEn implements TranslationsInstanceTypeJa {
	_TranslationsInstanceTypeEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get public => 'Public';
	@override String get hidden => 'Friend+';
	@override String get friends => 'Friends';
	@override String get private => 'Invite+';
	@override String get unknown => 'Unknown';
}

// Path: search.tabs.userSearch
class _TranslationsSearchTabsUserSearchEn implements TranslationsSearchTabsUserSearchJa {
	_TranslationsSearchTabsUserSearchEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => 'User Search';
	@override String get emptyDescription => 'You can search by username or ID.';
	@override String get searching => 'Searching...';
	@override String get noResults => 'No matching users found.';
	@override String error({required Object error}) => 'An error occurred during user search: ${error}';
	@override String get inputPlaceholder => 'Enter username or ID';
}

// Path: search.tabs.worldSearch
class _TranslationsSearchTabsWorldSearchEn implements TranslationsSearchTabsWorldSearchJa {
	_TranslationsSearchTabsWorldSearchEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => 'Explore Worlds';
	@override String get emptyDescription => 'Please enter a keyword to search.';
	@override String get searching => 'Searching...';
	@override String get noResults => 'No matching worlds found.';
	@override String noResultsWithQuery({required Object query}) => 'No worlds found matching "${query}"';
	@override String get noResultsHint => 'Try changing your search keywords.';
	@override String error({required Object error}) => 'An error occurred during world search: ${error}';
	@override String resultCount({required Object count}) => '${count} worlds found';
	@override String authorPrefix({required Object authorName}) => 'by ${authorName}';
	@override String get listView => 'List View';
	@override String get gridView => 'Grid View';
}

// Path: search.tabs.groupSearch
class _TranslationsSearchTabsGroupSearchEn implements TranslationsSearchTabsGroupSearchJa {
	_TranslationsSearchTabsGroupSearchEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => 'Search Groups';
	@override String get emptyDescription => 'Please enter a keyword to search.';
	@override String get searching => 'Searching...';
	@override String get noResults => 'No matching groups found.';
	@override String noResultsWithQuery({required Object query}) => 'No groups found matching "${query}"';
	@override String get noResultsHint => 'Try changing your search keywords.';
	@override String error({required Object error}) => 'An error occurred during group search: ${error}';
	@override String resultCount({required Object count}) => '${count} groups found';
	@override String get listView => 'List View';
	@override String get gridView => 'Grid View';
	@override String memberCount({required Object count}) => '${count} members';
}

// Path: search.tabs.avatarSearch
class _TranslationsSearchTabsAvatarSearchEn implements TranslationsSearchTabsAvatarSearchJa {
	_TranslationsSearchTabsAvatarSearchEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get avatar => 'Avatar';
	@override String get emptyTitle => 'Search Avatars';
	@override String get emptyDescription => 'Please enter a keyword to search.';
	@override String get searching => 'Searching for avatars...';
	@override String get noResults => 'No search results found.';
	@override String get noResultsHint => 'Try another keyword.';
	@override String error({required Object error}) => 'An error occurred during avatar search: ${error}';
}

// Path: inventory.tabs.emojiInventory
class _TranslationsInventoryTabsEmojiInventoryEn implements TranslationsInventoryTabsEmojiInventoryJa {
	_TranslationsInventoryTabsEmojiInventoryEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Loading emojis...';
	@override String error({required Object error}) => 'Failed to load emojis: ${error}';
	@override String get emptyTitle => 'No emojis';
	@override String get emptyDescription => 'Emojis you upload in VRChat will appear here.';
	@override String get zoomHint => 'Double-tap to zoom';
}

// Path: inventory.tabs.galleryInventory
class _TranslationsInventoryTabsGalleryInventoryEn implements TranslationsInventoryTabsGalleryInventoryJa {
	_TranslationsInventoryTabsGalleryInventoryEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Loading gallery...';
	@override String error({required Object error}) => 'Failed to load gallery: ${error}';
	@override String get emptyTitle => 'No gallery';
	@override String get emptyDescription => 'Galleries you upload in VRChat will appear here.';
	@override String get zoomHint => 'Double-tap to zoom';
}

// Path: inventory.tabs.iconInventory
class _TranslationsInventoryTabsIconInventoryEn implements TranslationsInventoryTabsIconInventoryJa {
	_TranslationsInventoryTabsIconInventoryEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Loading icons...';
	@override String error({required Object error}) => 'Failed to load icons: ${error}';
	@override String get emptyTitle => 'No icons';
	@override String get emptyDescription => 'Icons you upload in VRChat will appear here.';
	@override String get zoomHint => 'Double-tap to zoom';
}

// Path: inventory.tabs.printInventory
class _TranslationsInventoryTabsPrintInventoryEn implements TranslationsInventoryTabsPrintInventoryJa {
	_TranslationsInventoryTabsPrintInventoryEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Loading prints...';
	@override String error({required Object error}) => 'Failed to load prints: ${error}';
	@override String get emptyTitle => 'No prints';
	@override String get emptyDescription => 'Prints you upload in VRChat will appear here.';
	@override String get zoomHint => 'Double-tap to zoom';
}

// Path: inventory.tabs.stickerInventory
class _TranslationsInventoryTabsStickerInventoryEn implements TranslationsInventoryTabsStickerInventoryJa {
	_TranslationsInventoryTabsStickerInventoryEn._(this._root);

	final TranslationsEn _root; // ignore: unused_field

	// Translations
	@override String get loading => 'Loading stickers...';
	@override String error({required Object error}) => 'Failed to load stickers: ${error}';
	@override String get emptyTitle => 'No stickers';
	@override String get emptyDescription => 'Stickers you upload in VRChat will appear here.';
	@override String get zoomHint => 'Double-tap to zoom';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.title' => 'VRCN',
			'common.ok' => 'OK',
			'common.cancel' => 'Cancel',
			'common.close' => 'Close',
			'common.save' => 'Save',
			'common.edit' => 'Edit',
			'common.delete' => 'Delete',
			'common.yes' => 'Yes',
			'common.no' => 'No',
			'common.loading' => 'Loading...',
			'common.error' => ({required Object error}) => 'An error occurred: ${error}',
			'common.errorNomessage' => 'An error occurred',
			'common.retry' => 'Retry',
			'common.search' => 'Search',
			'common.settings' => 'Settings',
			'common.confirm' => 'Confirm',
			'common.agree' => 'Agree',
			'common.decline' => 'Decline',
			'common.username' => 'Username',
			'common.password' => 'Password',
			'common.login' => 'Login',
			'common.logout' => 'Logout',
			'common.share' => 'Share',
			'termsAgreement.welcomeTitle' => 'Welcome to VRCN',
			'termsAgreement.welcomeMessage' => 'Before using the app,\nplease review the Terms of Service and Privacy Policy.',
			'termsAgreement.termsTitle' => 'Terms of Service',
			'termsAgreement.termsSubtitle' => 'About the conditions for using the app',
			'termsAgreement.privacyTitle' => 'Privacy Policy',
			'termsAgreement.privacySubtitle' => 'About the handling of personal information',
			'termsAgreement.agreeTerms' => ({required Object title}) => 'I agree to the "${title}"',
			'termsAgreement.checkContent' => 'Check Content',
			'termsAgreement.notice' => 'This is an unofficial app for VRChat Inc.\nIt is not affiliated with VRChat Inc. in any way.',
			'drawer.home' => 'Home',
			'drawer.profile' => 'Profile',
			'drawer.favorite' => 'Favorites',
			'drawer.eventCalendar' => 'Event Calendar',
			'drawer.avatar' => 'Avatars',
			'drawer.group' => 'Groups',
			'drawer.inventory' => 'Inventory',
			'drawer.vrcnsync' => 'VRCNSync (β)',
			'drawer.review' => 'Review',
			'drawer.feedback' => 'Feedback',
			'drawer.settings' => 'Settings',
			'drawer.userLoading' => 'Loading user information...',
			'drawer.userError' => 'Failed to load user information',
			'drawer.retry' => 'Retry',
			'drawer.section.content' => 'Content',
			'drawer.section.other' => 'Other',
			'login.forgotPassword' => 'Forgot your password?',
			'login.createAccount' => 'Sign up',
			'login.subtitle' => 'Login with your VRChat account',
			'login.email' => 'Email Address',
			'login.emailHint' => 'Enter email or username',
			'login.passwordHint' => 'Enter password',
			'login.rememberMe' => 'Remember me',
			'login.loggingIn' => 'Logging in...',
			'login.errorEmptyEmail' => 'Please enter your username or email address.',
			'login.errorEmptyPassword' => 'Please enter your password.',
			'login.errorLoginFailed' => 'Login failed. Please check your email and password.',
			'login.twoFactorTitle' => 'Two-Factor Authentication',
			'login.twoFactorSubtitle' => 'Please enter the authentication code.',
			'login.twoFactorInstruction' => 'Enter the 6-digit code from\nyour authenticator app.',
			'login.twoFactorCodeHint' => 'Authentication code',
			'login.verify' => 'Verify',
			'login.verifying' => 'Verifying...',
			'login.errorEmpty2fa' => 'Please enter the authentication code.',
			'login.error2faFailed' => 'Two-factor authentication failed. Please check if the code is correct.',
			'login.backToLogin' => 'Back to login',
			'login.paste' => 'Paste',
			'friends.loading' => 'Loading friends list...',
			'friends.error' => ({required Object error}) => 'Failed to load friends list: ${error}',
			'friends.notFound' => 'No friends found.',
			'friends.private' => 'Private',
			'friends.active' => 'Active',
			'friends.offline' => 'Offline',
			'friends.online' => 'Online',
			'friends.groupTitle' => 'Group by World',
			'friends.refresh' => 'Refresh',
			'friends.searchHint' => 'Search by friend\'s name',
			'friends.noResult' => 'No matching friends found.',
			'friendDetail.loading' => 'Loading user information...',
			'friendDetail.error' => ({required Object error}) => 'Failed to load user information: ${error}',
			'friendDetail.currentLocation' => 'Current Location',
			'friendDetail.basicInfo' => 'Basic Info',
			'friendDetail.userId' => 'User ID',
			'friendDetail.dateJoined' => 'Date Joined',
			'friendDetail.lastLogin' => 'Last Login',
			'friendDetail.bio' => 'Bio',
			'friendDetail.links' => 'Links',
			'friendDetail.loadingLinks' => 'Loading links...',
			'friendDetail.group' => 'Groups',
			'friendDetail.groupDetail' => 'View Group Details',
			'friendDetail.groupCode' => ({required Object code}) => 'Group Code: ${code}',
			'friendDetail.memberCount' => ({required Object count}) => 'Members: ${count}',
			'friendDetail.unknownGroup' => 'Unknown Group',
			'friendDetail.block' => 'Block',
			'friendDetail.mute' => 'Mute',
			'friendDetail.openWebsite' => 'Open on Website',
			'friendDetail.shareProfile' => 'Share Profile',
			'friendDetail.confirmBlockTitle' => ({required Object name}) => 'Block ${name}?',
			'friendDetail.confirmBlockMessage' => 'If you block this user, you will no longer receive friend requests or messages from them.',
			'friendDetail.confirmMuteTitle' => ({required Object name}) => 'Mute ${name}?',
			'friendDetail.confirmMuteMessage' => 'If you mute this user, you will no longer hear their voice.',
			'friendDetail.blockSuccess' => 'Blocked',
			'friendDetail.muteSuccess' => 'Muted',
			'friendDetail.operationFailed' => ({required Object error}) => 'Operation failed: ${error}',
			'search.userTab' => 'Users',
			'search.worldTab' => 'Worlds',
			'search.avatarTab' => 'Avatars',
			'search.groupTab' => 'Groups',
			'search.tabs.userSearch.emptyTitle' => 'User Search',
			'search.tabs.userSearch.emptyDescription' => 'You can search by username or ID.',
			'search.tabs.userSearch.searching' => 'Searching...',
			'search.tabs.userSearch.noResults' => 'No matching users found.',
			'search.tabs.userSearch.error' => ({required Object error}) => 'An error occurred during user search: ${error}',
			'search.tabs.userSearch.inputPlaceholder' => 'Enter username or ID',
			'search.tabs.worldSearch.emptyTitle' => 'Explore Worlds',
			'search.tabs.worldSearch.emptyDescription' => 'Please enter a keyword to search.',
			'search.tabs.worldSearch.searching' => 'Searching...',
			'search.tabs.worldSearch.noResults' => 'No matching worlds found.',
			'search.tabs.worldSearch.noResultsWithQuery' => ({required Object query}) => 'No worlds found matching "${query}"',
			'search.tabs.worldSearch.noResultsHint' => 'Try changing your search keywords.',
			'search.tabs.worldSearch.error' => ({required Object error}) => 'An error occurred during world search: ${error}',
			'search.tabs.worldSearch.resultCount' => ({required Object count}) => '${count} worlds found',
			'search.tabs.worldSearch.authorPrefix' => ({required Object authorName}) => 'by ${authorName}',
			'search.tabs.worldSearch.listView' => 'List View',
			'search.tabs.worldSearch.gridView' => 'Grid View',
			'search.tabs.groupSearch.emptyTitle' => 'Search Groups',
			'search.tabs.groupSearch.emptyDescription' => 'Please enter a keyword to search.',
			'search.tabs.groupSearch.searching' => 'Searching...',
			'search.tabs.groupSearch.noResults' => 'No matching groups found.',
			'search.tabs.groupSearch.noResultsWithQuery' => ({required Object query}) => 'No groups found matching "${query}"',
			'search.tabs.groupSearch.noResultsHint' => 'Try changing your search keywords.',
			'search.tabs.groupSearch.error' => ({required Object error}) => 'An error occurred during group search: ${error}',
			'search.tabs.groupSearch.resultCount' => ({required Object count}) => '${count} groups found',
			'search.tabs.groupSearch.listView' => 'List View',
			'search.tabs.groupSearch.gridView' => 'Grid View',
			'search.tabs.groupSearch.memberCount' => ({required Object count}) => '${count} members',
			'search.tabs.avatarSearch.avatar' => 'Avatar',
			'search.tabs.avatarSearch.emptyTitle' => 'Search Avatars',
			'search.tabs.avatarSearch.emptyDescription' => 'Please enter a keyword to search.',
			'search.tabs.avatarSearch.searching' => 'Searching for avatars...',
			'search.tabs.avatarSearch.noResults' => 'No search results found.',
			'search.tabs.avatarSearch.noResultsHint' => 'Try another keyword.',
			'search.tabs.avatarSearch.error' => ({required Object error}) => 'An error occurred during avatar search: ${error}',
			'profile.title' => 'Profile',
			'profile.edit' => 'Edit',
			'profile.refresh' => 'Refresh',
			'profile.loading' => 'Loading profile information...',
			'profile.error' => 'Failed to load profile information: {error}',
			'profile.displayName' => 'Display Name',
			'profile.username' => 'Username',
			'profile.userId' => 'User ID',
			'profile.engageCard' => 'Engage Card',
			'profile.frined' => 'Friend',
			'profile.dateJoined' => 'Date Joined',
			'profile.userType' => 'User Type',
			'profile.status' => 'Status',
			'profile.statusMessage' => 'Status Message',
			'profile.bio' => 'Bio',
			'profile.links' => 'Links',
			'profile.group' => 'Groups',
			'profile.groupDetail' => 'View Group Details',
			'profile.avatar' => 'Current Avatar',
			'profile.avatarDetail' => 'View Avatar Details',
			'profile.public' => 'Public',
			'profile.private' => 'Private',
			'profile.hidden' => 'Hidden',
			'profile.unknown' => 'Unknown',
			'profile.friends' => 'Friends',
			'profile.loadingLinks' => 'Loading links...',
			'profile.noGroup' => 'Not in any groups',
			'profile.noBio' => 'No bio available',
			'profile.noLinks' => 'No links available',
			'profile.save' => 'Save Changes',
			'profile.saved' => 'Profile updated successfully.',
			'profile.saveFailed' => 'Failed to update: {error}',
			'profile.discardTitle' => 'Discard changes?',
			'profile.discardContent' => 'Changes made to your profile will not be saved.',
			'profile.discardCancel' => 'Cancel',
			'profile.discardOk' => 'Discard',
			'profile.basic' => 'Basic Info',
			'profile.pronouns' => 'Pronouns',
			'profile.addLink' => 'Add',
			'profile.removeLink' => 'Remove',
			'profile.linkHint' => 'Enter link (e.g., https://twitter.com/username)',
			'profile.linksHint' => 'Links will be displayed on your profile and can be opened by tapping.',
			'profile.statusMessageHint' => 'Enter your current situation or a message.',
			'profile.bioHint' => 'Write something about yourself.',
			'engageCard.pickBackground' => 'Select Background Image',
			'engageCard.removeBackground' => 'Remove Background Image',
			'engageCard.scanQr' => 'Scan QR Code',
			'engageCard.showAvatar' => 'Show Avatar',
			'engageCard.hideAvatar' => 'Hide Avatar',
			'engageCard.noBackground' => 'No background image selected.\nYou can set one from the top right button.',
			'engageCard.loading' => 'Loading...',
			'engageCard.error' => ({required Object error}) => 'Failed to load engage card information: ${error}',
			'engageCard.copyUserId' => 'Copy User ID',
			'engageCard.copied' => 'Copied',
			'qrScanner.title' => 'QR Code Scan',
			'qrScanner.guide' => 'Align the QR code within the frame.',
			'qrScanner.loading' => 'Initializing camera...',
			'qrScanner.error' => ({required Object error}) => 'Failed to read QR code: ${error}',
			'qrScanner.notFound' => 'No valid user QR code found.',
			'favorites.title' => 'Favorites',
			'favorites.frined' => 'Friend',
			'favorites.friendsTab' => 'Friends',
			'favorites.worldsTab' => 'Worlds',
			'favorites.avatarsTab' => 'Avatars',
			'favorites.emptyFolderTitle' => 'No favorite folders',
			'favorites.emptyFolderDescription' => 'Please create a favorite folder in VRChat.',
			'favorites.emptyFriends' => 'No friends in this folder.',
			'favorites.emptyWorlds' => 'No worlds in this folder.',
			'favorites.emptyAvatars' => 'No avatars in this folder.',
			'favorites.emptyWorldsTabTitle' => 'No favorite worlds',
			'favorites.emptyWorldsTabDescription' => 'You can add worlds to favorites from the world details screen.',
			'favorites.emptyAvatarsTabTitle' => 'No favorite avatars',
			'favorites.emptyAvatarsTabDescription' => 'You can add avatars to favorites from the avatar details screen.',
			'favorites.loading' => 'Loading favorites...',
			'favorites.loadingFolder' => 'Loading folder information...',
			'favorites.error' => ({required Object error}) => 'Failed to load favorites: ${error}',
			'favorites.errorFolder' => 'Failed to get information.',
			'favorites.remove' => 'Remove from Favorites',
			'favorites.removeSuccess' => ({required Object name}) => 'Removed ${name} from favorites.',
			'favorites.removeFailed' => ({required Object error}) => 'Failed to remove: ${error}',
			'favorites.itemsCount' => ({required Object count}) => '${count} items',
			'favorites.public' => 'Public',
			'favorites.private' => 'Private',
			'favorites.hidden' => 'Hidden',
			'favorites.unknown' => 'Unknown',
			'favorites.loadingError' => 'Loading Error',
			'notifications.emptyTitle' => 'No Notifications',
			'notifications.emptyDescription' => 'New notifications, like friend requests and invites,\nwill appear here.',
			'notifications.friendRequest' => ({required Object userName}) => 'You have a friend request from ${userName}.',
			'notifications.invite' => ({required Object worldName, required Object userName}) => 'You have an invite to ${worldName} from ${userName}.',
			'notifications.friendOnline' => ({required Object userName}) => '${userName} is now online.',
			'notifications.friendOffline' => ({required Object userName}) => '${userName} is now offline.',
			'notifications.friendActive' => ({required Object userName}) => '${userName} is now active.',
			'notifications.friendAdd' => ({required Object userName}) => '${userName} has been added to your friends.',
			'notifications.friendRemove' => ({required Object userName}) => '${userName} has been removed from your friends.',
			'notifications.statusUpdate' => ({required Object userName, required Object status, required Object world}) => '${userName}\'s status updated: ${status}${world}',
			'notifications.locationChange' => ({required Object userName, required Object worldName}) => '${userName} moved to ${worldName}.',
			'notifications.userUpdate' => ({required Object world}) => 'Your information has been updated${world}.',
			'notifications.myLocationChange' => ({required Object worldName}) => 'You moved to: ${worldName}',
			'notifications.requestInvite' => ({required Object userName}) => 'You have a request to join from ${userName}.',
			'notifications.votekick' => ({required Object userName}) => 'There was a votekick from ${userName}.',
			'notifications.responseReceived' => ({required Object userName}) => 'Received response for notification ID: ${userName}',
			'notifications.error' => ({required Object worldName}) => 'Error: ${worldName}',
			'notifications.system' => ({required Object extraData}) => 'System notification: ${extraData}',
			'notifications.secondsAgo' => ({required Object seconds}) => '${seconds}s ago',
			'notifications.minutesAgo' => ({required Object minutes}) => '${minutes}m ago',
			'notifications.hoursAgo' => ({required Object hours}) => '${hours}h ago',
			'eventCalendar.title' => 'Event Calendar',
			'eventCalendar.filter' => 'Filter Events',
			'eventCalendar.refresh' => 'Refresh Events',
			'eventCalendar.loading' => 'Loading events...',
			'eventCalendar.error' => ({required Object error}) => 'Failed to load events: ${error}',
			'eventCalendar.filterActive' => ({required Object count}) => 'Filter applied (${count} results)',
			'eventCalendar.clear' => 'Clear',
			'eventCalendar.noEvents' => 'No events match the criteria.',
			'eventCalendar.clearFilter' => 'Clear Filter',
			'eventCalendar.today' => 'Today',
			'eventCalendar.reminderSet' => 'Set Reminder',
			'eventCalendar.reminderSetDone' => 'Reminder Set',
			'eventCalendar.reminderDeleted' => 'Reminder deleted.',
			'eventCalendar.eventName' => 'Event Name',
			'eventCalendar.organizer' => 'Organizer',
			'eventCalendar.description' => 'Description',
			'eventCalendar.genre' => 'Genre',
			'eventCalendar.condition' => 'Participation Conditions',
			'eventCalendar.way' => 'How to Join',
			'eventCalendar.note' => 'Notes',
			'eventCalendar.quest' => 'Quest Compatible',
			'eventCalendar.reminderCount' => ({required Object count}) => '${count}',
			'eventCalendar.startToEnd' => ({required Object start, required Object end}) => '${start} - ${end}',
			'avatars.title' => 'Avatars',
			'avatars.searchHint' => 'Search by avatar name, etc.',
			'avatars.searchTooltip' => 'Search',
			'avatars.searchEmptyTitle' => 'No search results found.',
			'avatars.searchEmptyDescription' => 'Please try a different search term.',
			'avatars.emptyTitle' => 'No avatars',
			'avatars.emptyDescription' => 'Please add an avatar or try again later.',
			'avatars.refresh' => 'Refresh',
			'avatars.loading' => 'Loading avatars...',
			'avatars.error' => ({required Object error}) => 'Failed to load avatars: ${error}',
			'avatars.current' => 'In Use',
			'avatars.public' => 'Public',
			'avatars.private' => 'Private',
			'avatars.hidden' => 'Hidden',
			'avatars.author' => 'Author',
			'avatars.sortUpdated' => 'By Update Date',
			'avatars.sortName' => 'By Name',
			'avatars.sortTooltip' => 'Sort',
			'avatars.viewModeTooltip' => 'Toggle View Mode',
			'worldDetail.loading' => 'Loading world information...',
			'worldDetail.error' => ({required Object error}) => 'Failed to load world information: ${error}',
			'worldDetail.share' => 'Share This World',
			'worldDetail.openInVRChat' => 'Open on VRChat Official Website',
			'worldDetail.report' => 'Report This World',
			'worldDetail.creator' => 'Creator',
			'worldDetail.created' => 'Created',
			'worldDetail.updated' => 'Updated',
			'worldDetail.favorites' => 'Favorites',
			'worldDetail.visits' => 'Visits',
			'worldDetail.occupants' => 'Current Occupants',
			'worldDetail.popularity' => 'Popularity',
			'worldDetail.description' => 'Description',
			'worldDetail.noDescription' => 'No description available.',
			'worldDetail.tags' => 'Tags',
			'worldDetail.joinPublic' => 'Send Invite to Public Instance',
			'worldDetail.favoriteAdded' => 'Added to favorites.',
			'worldDetail.favoriteRemoved' => 'Removed from favorites.',
			'worldDetail.unknown' => 'Unknown',
			'avatarDetail.changeSuccess' => ({required Object name}) => 'Changed to avatar "${name}".',
			'avatarDetail.changeFailed' => ({required Object error}) => 'Failed to change avatar: ${error}',
			'avatarDetail.changing' => 'Changing...',
			'avatarDetail.useThisAvatar' => 'Use This Avatar',
			'avatarDetail.creator' => 'Creator',
			'avatarDetail.created' => 'Created',
			'avatarDetail.updated' => 'Updated',
			'avatarDetail.description' => 'Description',
			'avatarDetail.noDescription' => 'No description available.',
			'avatarDetail.tags' => 'Tags',
			'avatarDetail.addToFavorites' => 'Add to Favorites',
			'avatarDetail.public' => 'Public',
			'avatarDetail.private' => 'Private',
			'avatarDetail.hidden' => 'Hidden',
			'avatarDetail.unknown' => 'Unknown',
			'avatarDetail.share' => 'Share',
			'avatarDetail.loading' => 'Loading avatar information...',
			'avatarDetail.error' => ({required Object error}) => 'Failed to load avatar information: ${error}',
			'groups.title' => 'Groups',
			'groups.loadingUser' => 'Loading user information...',
			'groups.errorUser' => ({required Object error}) => 'Failed to load user information: ${error}',
			'groups.loadingGroups' => 'Loading group information...',
			'groups.errorGroups' => ({required Object error}) => 'Failed to load group information: ${error}',
			'groups.emptyTitle' => 'You are not in any groups.',
			'groups.emptyDescription' => 'You can join groups from the VRChat app or website.',
			'groups.searchGroups' => 'Find Groups',
			'groups.members' => ({required Object count}) => '${count} members',
			'groups.showDetails' => 'Show Details',
			'groups.unknownName' => 'Unknown Name',
			'groupDetail.loading' => 'Loading group information...',
			'groupDetail.error' => ({required Object error}) => 'Failed to load group information: ${error}',
			'groupDetail.share' => 'Share Group Info',
			'groupDetail.description' => 'Description',
			'groupDetail.roles' => 'Roles',
			'groupDetail.basicInfo' => 'Basic Info',
			'groupDetail.createdAt' => 'Created At',
			'groupDetail.owner' => 'Owner',
			'groupDetail.rules' => 'Rules',
			'groupDetail.languages' => 'Languages',
			'groupDetail.memberCount' => ({required Object count}) => '${count} Members',
			'groupDetail.privacy.public' => 'Public',
			'groupDetail.privacy.private' => 'Private',
			'groupDetail.privacy.friends' => 'Friends',
			'groupDetail.privacy.invite' => 'Invite',
			'groupDetail.privacy.unknown' => 'Unknown',
			'groupDetail.role.admin' => 'Admin',
			'groupDetail.role.moderator' => 'Moderator',
			'groupDetail.role.member' => 'Member',
			'groupDetail.role.unknown' => 'Unknown',
			'inventory.title' => 'Inventory',
			'inventory.gallery' => 'Gallery',
			'inventory.icon' => 'Icon',
			'inventory.emoji' => 'Emoji',
			'inventory.sticker' => 'Sticker',
			'inventory.print' => 'Print',
			'inventory.upload' => 'Upload File',
			'inventory.uploadGallery' => 'Uploading gallery image...',
			'inventory.uploadIcon' => 'Uploading icon...',
			'inventory.uploadEmoji' => 'Uploading emoji...',
			'inventory.uploadSticker' => 'Uploading sticker...',
			'inventory.uploadPrint' => 'Uploading print image...',
			'inventory.selectImage' => 'Select Image',
			'inventory.selectFromGallery' => 'Select from Gallery',
			'inventory.takePhoto' => 'Take Photo with Camera',
			'inventory.uploadSuccess' => 'Upload complete.',
			'inventory.uploadFailed' => 'Upload failed.',
			'inventory.uploadFailedFormat' => 'There is a problem with the file format or size. Please select a PNG image under 1MB.',
			'inventory.uploadFailedAuth' => 'Authentication failed. Please log in again.',
			'inventory.uploadFailedSize' => 'File size is too large. Please select a smaller image.',
			'inventory.uploadFailedServer' => ({required Object code}) => 'Server error occurred (${code})',
			'inventory.pickImageFailed' => ({required Object error}) => 'Failed to select image: ${error}',
			'inventory.tabs.emojiInventory.loading' => 'Loading emojis...',
			'inventory.tabs.emojiInventory.error' => ({required Object error}) => 'Failed to load emojis: ${error}',
			'inventory.tabs.emojiInventory.emptyTitle' => 'No emojis',
			'inventory.tabs.emojiInventory.emptyDescription' => 'Emojis you upload in VRChat will appear here.',
			'inventory.tabs.emojiInventory.zoomHint' => 'Double-tap to zoom',
			'inventory.tabs.galleryInventory.loading' => 'Loading gallery...',
			'inventory.tabs.galleryInventory.error' => ({required Object error}) => 'Failed to load gallery: ${error}',
			'inventory.tabs.galleryInventory.emptyTitle' => 'No gallery',
			'inventory.tabs.galleryInventory.emptyDescription' => 'Galleries you upload in VRChat will appear here.',
			'inventory.tabs.galleryInventory.zoomHint' => 'Double-tap to zoom',
			'inventory.tabs.iconInventory.loading' => 'Loading icons...',
			'inventory.tabs.iconInventory.error' => ({required Object error}) => 'Failed to load icons: ${error}',
			'inventory.tabs.iconInventory.emptyTitle' => 'No icons',
			'inventory.tabs.iconInventory.emptyDescription' => 'Icons you upload in VRChat will appear here.',
			'inventory.tabs.iconInventory.zoomHint' => 'Double-tap to zoom',
			'inventory.tabs.printInventory.loading' => 'Loading prints...',
			'inventory.tabs.printInventory.error' => ({required Object error}) => 'Failed to load prints: ${error}',
			'inventory.tabs.printInventory.emptyTitle' => 'No prints',
			'inventory.tabs.printInventory.emptyDescription' => 'Prints you upload in VRChat will appear here.',
			'inventory.tabs.printInventory.zoomHint' => 'Double-tap to zoom',
			'inventory.tabs.stickerInventory.loading' => 'Loading stickers...',
			'inventory.tabs.stickerInventory.error' => ({required Object error}) => 'Failed to load stickers: ${error}',
			'inventory.tabs.stickerInventory.emptyTitle' => 'No stickers',
			'inventory.tabs.stickerInventory.emptyDescription' => 'Stickers you upload in VRChat will appear here.',
			'inventory.tabs.stickerInventory.zoomHint' => 'Double-tap to zoom',
			'vrcnsync.title' => 'VRCNSync (β)',
			'vrcnsync.betaTitle' => 'Beta Feature',
			'vrcnsync.betaDescription' => 'This feature is a beta version under development. Unexpected issues may occur.\nCurrently, it is only implemented locally, but a cloud version will be implemented if there is demand.',
			'vrcnsync.githubLink' => 'VRCNSync GitHub Page',
			'vrcnsync.openGithub' => 'Open GitHub Page',
			'vrcnsync.serverRunning' => 'Server Running',
			'vrcnsync.serverStopped' => 'Server Stopped',
			'vrcnsync.serverRunningDesc' => 'Saves photos from your PC to the VRCN album.',
			'vrcnsync.serverStoppedDesc' => 'The server is stopped.',
			'vrcnsync.photoSaved' => 'Photo saved to VRCN album.',
			'vrcnsync.photoReceived' => 'Photo received (failed to save to album).',
			'vrcnsync.openAlbum' => 'Open Album',
			'vrcnsync.permissionErrorIos' => 'Access to the photo library is required.',
			'vrcnsync.permissionErrorAndroid' => 'Access to storage is required.',
			'vrcnsync.openSettings' => 'Open Settings',
			'vrcnsync.initError' => ({required Object error}) => 'Initialization failed: ${error}',
			'vrcnsync.openPhotoAppError' => 'Could not open the photo app.',
			'vrcnsync.serverInfo' => 'Server Information',
			'vrcnsync.ip' => ({required Object ip}) => 'IP: ${ip}',
			'vrcnsync.port' => ({required Object port}) => 'Port: ${port}',
			'vrcnsync.address' => ({required Object ip, required Object port}) => '${ip}:${port}',
			'vrcnsync.autoSave' => 'Received photos are automatically saved to the "VRCN" album.',
			'vrcnsync.usage' => 'How to Use',
			'vrcnsync.usageSteps.0.title' => 'Launch the VRCNSync app on your PC',
			'vrcnsync.usageSteps.0.desc' => 'Please launch the VRCNSync app on your PC.',
			'vrcnsync.usageSteps.1.title' => 'Connect to the same WiFi network',
			'vrcnsync.usageSteps.1.desc' => 'Please connect your PC and mobile device to the same WiFi network.',
			'vrcnsync.usageSteps.2.title' => 'Specify the mobile device as the destination',
			'vrcnsync.usageSteps.2.desc' => 'Please specify the IP address and port above in the PC app.',
			'vrcnsync.usageSteps.3.title' => 'Send photos',
			'vrcnsync.usageSteps.3.desc' => 'When you send photos from your PC, they will be automatically saved to the VRCN album.',
			'vrcnsync.stats' => 'Connection Status',
			'vrcnsync.statServer' => 'Server Status',
			'vrcnsync.statServerRunning' => 'Running',
			'vrcnsync.statServerStopped' => 'Stopped',
			'vrcnsync.statNetwork' => 'Network',
			'vrcnsync.statNetworkConnected' => 'Connected',
			'vrcnsync.statNetworkDisconnected' => 'Disconnected',
			'feedback.title' => 'Feedback',
			'feedback.type' => 'Feedback Type',
			'feedback.types.bug' => 'Bug Report',
			'feedback.types.feature' => 'Feature Request',
			'feedback.types.improvement' => 'Suggestion for Improvement',
			'feedback.types.other' => 'Other',
			'feedback.inputTitle' => 'Title *',
			'feedback.inputTitleHint' => 'Please be concise.',
			'feedback.inputDescription' => 'Description *',
			'feedback.inputDescriptionHint' => 'Please provide a detailed description...',
			'feedback.cancel' => 'Cancel',
			'feedback.send' => 'Send',
			'feedback.sending' => 'Sending...',
			'feedback.required' => 'Title and description are required.',
			'feedback.success' => 'Feedback sent. Thank you!',
			'feedback.fail' => 'Failed to send feedback.',
			'settings.appearance' => 'Appearance',
			'settings.language' => 'Language',
			'settings.languageDescription' => 'You can select the display language for the app.',
			'settings.appIcon' => 'App Icon',
			'settings.appIconDescription' => 'Change the app icon displayed on the home screen.',
			'settings.contentSettings' => 'Content Settings',
			'settings.searchEnabled' => 'Search feature enabled.',
			'settings.searchDisabled' => 'Search feature disabled.',
			'settings.enableSearch' => 'Enable Search',
			'settings.enableSearchDescription' => 'Search results may include sexual or violent content.',
			'settings.apiSetting' => 'Avatar Search API',
			'settings.apiSettingDescription' => 'Set the API for the avatar search feature.',
			'settings.apiSettingSaveUrl' => 'URL saved.',
			'settings.notSet' => 'Not set (Avatar search feature cannot be used).',
			'settings.notifications' => 'Notification Settings',
			'settings.eventReminder' => 'Event Reminders',
			'settings.eventReminderDescription' => 'Receive notifications before your scheduled events start.',
			'settings.manageReminders' => 'Manage Set Reminders',
			'settings.manageRemindersDescription' => 'Cancel or check your notifications.',
			'settings.dataStorage' => 'Data and Storage',
			'settings.clearCache' => 'Clear Cache',
			'settings.clearCacheSuccess' => 'Cache cleared.',
			'settings.clearCacheError' => 'An error occurred while clearing the cache.',
			'settings.cacheSize' => ({required Object size}) => 'Cache size: ${size}',
			'settings.calculatingCache' => 'Calculating cache size...',
			'settings.cacheError' => 'Could not get cache size.',
			'settings.confirmClearCache' => 'Clearing the cache will delete temporarily saved images and data.\n\nYour account information and app settings will not be deleted.',
			'settings.appInfo' => 'App Information',
			'settings.version' => 'Version',
			'settings.packageName' => 'Package Name',
			'settings.credit' => 'Credits',
			'settings.creditDescription' => 'Developer and contributor information.',
			'settings.contact' => 'Contact',
			'settings.contactDescription' => 'For bug reports and suggestions.',
			'settings.privacyPolicy' => 'Privacy Policy',
			'settings.privacyPolicyDescription' => 'About the handling of personal information.',
			'settings.termsOfService' => 'Terms of Service',
			'settings.termsOfServiceDescription' => 'Conditions for using the app.',
			'settings.openSource' => 'Open Source Information',
			'settings.openSourceDescription' => 'Licenses for libraries used.',
			'settings.github' => 'GitHub Repository',
			'settings.githubDescription' => 'View source code.',
			'settings.logoutConfirm' => 'Are you sure you want to log out?',
			'settings.logoutError' => ({required Object error}) => 'An error occurred during logout: ${error}',
			'settings.iconChangeNotSupported' => 'Changing the app icon is not supported on your device.',
			'settings.iconChangeFailed' => 'Failed to change icon.',
			'settings.themeMode' => 'Theme Mode',
			'settings.themeModeDescription' => 'You can select the display theme of the app.',
			'settings.themeLight' => 'Light',
			_ => null,
		} ?? switch (path) {
			'settings.themeSystem' => 'System',
			'settings.themeDark' => 'Dark',
			'settings.appIconDefault' => 'Default',
			'settings.appIconIcon' => 'Icon',
			'settings.appIconLogo' => 'Logo',
			'settings.delete' => 'Delete',
			'credits.title' => 'Credits',
			'credits.section.development' => 'Development',
			'credits.section.iconPeople' => 'The Fun Icon People',
			'credits.section.testFeedback' => 'Testing & Feedback',
			'credits.section.specialThanks' => 'Special Thanks',
			'download.success' => 'Download complete.',
			'download.failure' => ({required Object error}) => 'Download failed: ${error}',
			'download.shareFailure' => ({required Object error}) => 'Sharing failed: ${error}',
			'download.permissionTitle' => 'Permission Required',
			'download.permissionDenied' => ({required Object permissionType}) => 'Permission to save to ${permissionType} has been denied.\nPlease enable the permission from the settings app.',
			'download.permissionCancel' => 'Cancel',
			'download.permissionOpenSettings' => 'Open Settings',
			'download.permissionPhoto' => 'Photos',
			'download.permissionPhotoLibrary' => 'Photo Library',
			'download.permissionStorage' => 'Storage',
			'download.permissionPhotoRequired' => 'Permission to save to photos is required.',
			'download.permissionPhotoLibraryRequired' => 'Permission to save to photo library is required.',
			'download.permissionStorageRequired' => 'Permission to access storage is required.',
			'download.permissionError' => ({required Object error}) => 'An error occurred while checking permissions: ${error}',
			'download.downloading' => ({required Object fileName}) => 'Downloading ${fileName}...',
			'download.sharing' => ({required Object fileName}) => 'Preparing to share ${fileName}...',
			'instance.type.public' => 'Public',
			'instance.type.hidden' => 'Friend+',
			'instance.type.friends' => 'Friends',
			'instance.type.private' => 'Invite+',
			'instance.type.unknown' => 'Unknown',
			'status.active' => 'Online',
			'status.joinMe' => 'Join Me',
			'status.askMe' => 'Ask Me',
			'status.busy' => 'Busy',
			'status.offline' => 'Offline',
			'status.unknown' => 'Unknown Status',
			'location.private' => 'Private',
			'location.playerCount' => ({required Object userCount, required Object capacity}) => 'Players: ${userCount} / ${capacity}',
			'location.instanceType' => ({required Object type}) => 'Instance Type: ${type}',
			'location.noInfo' => 'No location information available.',
			'location.fetchError' => 'Failed to get location information.',
			'location.privateLocation' => 'You are in a private location.',
			'location.inviteSending' => 'Sending invite...',
			'location.inviteSent' => 'Invite sent. You can join from your notifications.',
			'location.inviteFailed' => ({required Object error}) => 'Failed to send invite: ${error}',
			'location.inviteButton' => 'Send Invite to Myself',
			'location.isPrivate' => ({required Object number}) => '${number} in private',
			'location.isActive' => ({required Object number}) => '${number} active',
			'location.isOffline' => ({required Object number}) => '${number} offline',
			'location.isTraveling' => ({required Object number}) => '${number} traveling',
			'location.isStaying' => ({required Object number}) => '${number} staying',
			'reminder.dialogTitle' => 'Set Reminder',
			'reminder.alreadySet' => 'Already Set',
			'reminder.set' => 'Set',
			'reminder.cancel' => 'Cancel',
			'reminder.delete' => 'Delete',
			'reminder.deleteAll' => 'Delete All Reminders',
			'reminder.deleteAllConfirm' => 'This will delete all set event reminders. This action cannot be undone.',
			'reminder.deleted' => 'Reminder deleted.',
			'reminder.deletedAll' => 'All reminders deleted.',
			'reminder.noReminders' => 'No reminders set.',
			'reminder.setFromEvent' => 'You can set notifications from the event page.',
			'reminder.eventStart' => ({required Object time}) => 'Starts at ${time}',
			'reminder.notifyAt' => ({required Object time, required Object label}) => '${time} (${label})',
			'reminder.receiveNotification' => 'When do you want to be notified?',
			'friend.sortFilter' => 'Sort & Filter',
			'friend.filter' => 'Filter',
			'friend.filterAll' => 'Show All',
			'friend.filterOnline' => 'Online Only',
			'friend.filterOffline' => 'Offline Only',
			'friend.filterFavorite' => 'Favorites Only',
			'friend.sort' => 'Sort',
			'friend.sortStatus' => 'By Status',
			'friend.sortName' => 'By Name',
			'friend.sortLastLogin' => 'By Last Login',
			'friend.sortAsc' => 'Ascending',
			'friend.sortDesc' => 'Descending',
			'friend.close' => 'Close',
			'eventCalendarFilter.filterTitle' => 'Filter Events',
			'eventCalendarFilter.clear' => 'Clear',
			'eventCalendarFilter.keyword' => 'Keyword Search',
			'eventCalendarFilter.keywordHint' => 'Event name, description, organizer, etc.',
			'eventCalendarFilter.date' => 'Filter by Date',
			'eventCalendarFilter.dateHint' => 'You can display events for a specific date range.',
			'eventCalendarFilter.startDate' => 'Start Date',
			'eventCalendarFilter.endDate' => 'End Date',
			'eventCalendarFilter.select' => 'Please select',
			'eventCalendarFilter.time' => 'Filter by Time',
			'eventCalendarFilter.timeHint' => 'You can display events held during a specific time frame.',
			'eventCalendarFilter.startTime' => 'Start Time',
			'eventCalendarFilter.endTime' => 'End Time',
			'eventCalendarFilter.genre' => 'Filter by Genre',
			'eventCalendarFilter.genreSelected' => ({required Object count}) => '${count} genres selected',
			'eventCalendarFilter.apply' => 'Apply',
			'eventCalendarFilter.filterSummary' => 'Filters',
			'eventCalendarFilter.filterNone' => 'No filters are set.',
			_ => null,
		};
	}
}
