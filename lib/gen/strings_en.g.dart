///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
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
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$common$en common = Translations$common$en._(_root);
	late final Translations$termsAgreement$en termsAgreement = Translations$termsAgreement$en._(_root);
	late final Translations$drawer$en drawer = Translations$drawer$en._(_root);
	late final Translations$login$en login = Translations$login$en._(_root);
	late final Translations$friends$en friends = Translations$friends$en._(_root);
	late final Translations$friendDetail$en friendDetail = Translations$friendDetail$en._(_root);
	late final Translations$search$en search = Translations$search$en._(_root);
	late final Translations$profile$en profile = Translations$profile$en._(_root);
	late final Translations$engageCard$en engageCard = Translations$engageCard$en._(_root);
	late final Translations$qrScanner$en qrScanner = Translations$qrScanner$en._(_root);
	late final Translations$favorites$en favorites = Translations$favorites$en._(_root);
	late final Translations$notifications$en notifications = Translations$notifications$en._(_root);
	late final Translations$eventCalendar$en eventCalendar = Translations$eventCalendar$en._(_root);
	late final Translations$avatars$en avatars = Translations$avatars$en._(_root);
	late final Translations$worldDetail$en worldDetail = Translations$worldDetail$en._(_root);
	late final Translations$avatarDetail$en avatarDetail = Translations$avatarDetail$en._(_root);
	late final Translations$groups$en groups = Translations$groups$en._(_root);
	late final Translations$groupDetail$en groupDetail = Translations$groupDetail$en._(_root);
	late final Translations$inventory$en inventory = Translations$inventory$en._(_root);
	late final Translations$feedback$en feedback = Translations$feedback$en._(_root);
	late final Translations$settings$en settings = Translations$settings$en._(_root);
	late final Translations$credits$en credits = Translations$credits$en._(_root);
	late final Translations$download$en download = Translations$download$en._(_root);
	late final Translations$instance$en instance = Translations$instance$en._(_root);
	late final Translations$status$en status = Translations$status$en._(_root);
	late final Translations$location$en location = Translations$location$en._(_root);
	late final Translations$reminder$en reminder = Translations$reminder$en._(_root);
	late final Translations$friend$en friend = Translations$friend$en._(_root);
	late final Translations$eventCalendarFilter$en eventCalendarFilter = Translations$eventCalendarFilter$en._(_root);
}

// Path: common
class Translations$common$en {
	Translations$common$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'VRCN'
	String get title => 'VRCN';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Yes'
	String get yes => 'Yes';

	/// en: 'No'
	String get no => 'No';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'An error occurred: ${error}'
	String error({required Object error}) => 'An error occurred: ${error}';

	/// en: 'An error occurred'
	String get errorNomessage => 'An error occurred';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Agree'
	String get agree => 'Agree';

	/// en: 'Decline'
	String get decline => 'Decline';

	/// en: 'Username'
	String get username => 'Username';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Login'
	String get login => 'Login';

	/// en: 'Logout'
	String get logout => 'Logout';

	/// en: 'Share'
	String get share => 'Share';
}

// Path: termsAgreement
class Translations$termsAgreement$en {
	Translations$termsAgreement$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome to VRCN'
	String get welcomeTitle => 'Welcome to VRCN';

	/// en: 'Before using the app, please review the Terms of Service and Privacy Policy.'
	String get welcomeMessage => 'Before using the app,\nplease review the Terms of Service and Privacy Policy.';

	/// en: 'Terms of Service'
	String get termsTitle => 'Terms of Service';

	/// en: 'About the conditions for using the app'
	String get termsSubtitle => 'About the conditions for using the app';

	/// en: 'Privacy Policy'
	String get privacyTitle => 'Privacy Policy';

	/// en: 'About the handling of personal information'
	String get privacySubtitle => 'About the handling of personal information';

	/// en: 'I agree to the "${title}"'
	String agreeTerms({required Object title}) => 'I agree to the "${title}"';

	/// en: 'Check Content'
	String get checkContent => 'Check Content';

	/// en: 'This is an unofficial app for VRChat Inc. It is not affiliated with VRChat Inc. in any way.'
	String get notice => 'This is an unofficial app for VRChat Inc.\nIt is not affiliated with VRChat Inc. in any way.';
}

// Path: drawer
class Translations$drawer$en {
	Translations$drawer$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: 'Favorites'
	String get favorite => 'Favorites';

	/// en: 'Event Calendar'
	String get eventCalendar => 'Event Calendar';

	/// en: 'Avatars'
	String get avatar => 'Avatars';

	/// en: 'Groups'
	String get group => 'Groups';

	/// en: 'Inventory'
	String get inventory => 'Inventory';

	/// en: 'Review'
	String get review => 'Review';

	/// en: 'Feedback'
	String get feedback => 'Feedback';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Loading user information...'
	String get userLoading => 'Loading user information...';

	/// en: 'Failed to load user information'
	String get userError => 'Failed to load user information';

	/// en: 'Retry'
	String get retry => 'Retry';

	late final Translations$drawer$section$en section = Translations$drawer$section$en._(_root);
}

// Path: login
class Translations$login$en {
	Translations$login$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Forgot your password?'
	String get forgotPassword => 'Forgot your password?';

	/// en: 'Sign up'
	String get createAccount => 'Sign up';

	/// en: 'Login with your VRChat account'
	String get subtitle => 'Login with your VRChat account';

	/// en: 'Email Address'
	String get email => 'Email Address';

	/// en: 'Enter email or username'
	String get emailHint => 'Enter email or username';

	/// en: 'Enter password'
	String get passwordHint => 'Enter password';

	/// en: 'Remember me'
	String get rememberMe => 'Remember me';

	/// en: 'Logging in...'
	String get loggingIn => 'Logging in...';

	/// en: 'Please enter your username or email address.'
	String get errorEmptyEmail => 'Please enter your username or email address.';

	/// en: 'Please enter your password.'
	String get errorEmptyPassword => 'Please enter your password.';

	/// en: 'Login failed. Please check your email and password.'
	String get errorLoginFailed => 'Login failed. Please check your email and password.';

	/// en: 'Two-Factor Authentication'
	String get twoFactorTitle => 'Two-Factor Authentication';

	/// en: 'Please enter the authentication code.'
	String get twoFactorSubtitle => 'Please enter the authentication code.';

	/// en: 'Enter the 6-digit code from your authenticator app.'
	String get twoFactorInstruction => 'Enter the 6-digit code from\nyour authenticator app.';

	/// en: 'Authentication code'
	String get twoFactorCodeHint => 'Authentication code';

	/// en: 'Verify'
	String get verify => 'Verify';

	/// en: 'Verifying...'
	String get verifying => 'Verifying...';

	/// en: 'Please enter the authentication code.'
	String get errorEmpty2fa => 'Please enter the authentication code.';

	/// en: 'Two-factor authentication failed. Please check if the code is correct.'
	String get error2faFailed => 'Two-factor authentication failed. Please check if the code is correct.';

	/// en: 'Back to login'
	String get backToLogin => 'Back to login';

	/// en: 'Paste'
	String get paste => 'Paste';
}

// Path: friends
class Translations$friends$en {
	Translations$friends$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading friends list...'
	String get loading => 'Loading friends list...';

	/// en: 'Failed to load friends list: ${error}'
	String error({required Object error}) => 'Failed to load friends list: ${error}';

	/// en: 'No friends found.'
	String get notFound => 'No friends found.';

	/// en: 'Private'
	String get private => 'Private';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Offline'
	String get offline => 'Offline';

	/// en: 'Online'
	String get online => 'Online';

	/// en: 'Group by World'
	String get groupTitle => 'Group by World';

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Search by friend's name'
	String get searchHint => 'Search by friend\'s name';

	/// en: 'No matching friends found.'
	String get noResult => 'No matching friends found.';
}

// Path: friendDetail
class Translations$friendDetail$en {
	Translations$friendDetail$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading user information...'
	String get loading => 'Loading user information...';

	/// en: 'Failed to load user information: ${error}'
	String error({required Object error}) => 'Failed to load user information: ${error}';

	/// en: 'Current Location'
	String get currentLocation => 'Current Location';

	/// en: 'Basic Info'
	String get basicInfo => 'Basic Info';

	/// en: 'User ID'
	String get userId => 'User ID';

	/// en: 'Date Joined'
	String get dateJoined => 'Date Joined';

	/// en: 'Last Login'
	String get lastLogin => 'Last Login';

	/// en: 'Bio'
	String get bio => 'Bio';

	/// en: 'Links'
	String get links => 'Links';

	/// en: 'Loading links...'
	String get loadingLinks => 'Loading links...';

	/// en: 'Groups'
	String get group => 'Groups';

	/// en: 'View Group Details'
	String get groupDetail => 'View Group Details';

	/// en: 'Group Code: ${code}'
	String groupCode({required Object code}) => 'Group Code: ${code}';

	/// en: 'Members: ${count}'
	String memberCount({required Object count}) => 'Members: ${count}';

	/// en: 'Unknown Group'
	String get unknownGroup => 'Unknown Group';

	/// en: 'Block'
	String get block => 'Block';

	/// en: 'Mute'
	String get mute => 'Mute';

	/// en: 'Open on Website'
	String get openWebsite => 'Open on Website';

	/// en: 'Share Profile'
	String get shareProfile => 'Share Profile';

	/// en: 'Block ${name}?'
	String confirmBlockTitle({required Object name}) => 'Block ${name}?';

	/// en: 'If you block this user, you will no longer receive friend requests or messages from them.'
	String get confirmBlockMessage => 'If you block this user, you will no longer receive friend requests or messages from them.';

	/// en: 'Mute ${name}?'
	String confirmMuteTitle({required Object name}) => 'Mute ${name}?';

	/// en: 'If you mute this user, you will no longer hear their voice.'
	String get confirmMuteMessage => 'If you mute this user, you will no longer hear their voice.';

	/// en: 'Blocked'
	String get blockSuccess => 'Blocked';

	/// en: 'Muted'
	String get muteSuccess => 'Muted';

	/// en: 'Operation failed: ${error}'
	String operationFailed({required Object error}) => 'Operation failed: ${error}';
}

// Path: search
class Translations$search$en {
	Translations$search$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Users'
	String get userTab => 'Users';

	/// en: 'Worlds'
	String get worldTab => 'Worlds';

	/// en: 'Avatars'
	String get avatarTab => 'Avatars';

	/// en: 'Groups'
	String get groupTab => 'Groups';

	late final Translations$search$tabs$en tabs = Translations$search$tabs$en._(_root);
}

// Path: profile
class Translations$profile$en {
	Translations$profile$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Profile'
	String get title => 'Profile';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Loading profile information...'
	String get loading => 'Loading profile information...';

	/// en: 'Failed to load profile information: {error}'
	String get error => 'Failed to load profile information: {error}';

	/// en: 'Display Name'
	String get displayName => 'Display Name';

	/// en: 'Username'
	String get username => 'Username';

	/// en: 'User ID'
	String get userId => 'User ID';

	/// en: 'Engage Card'
	String get engageCard => 'Engage Card';

	/// en: 'Friend'
	String get frined => 'Friend';

	/// en: 'Date Joined'
	String get dateJoined => 'Date Joined';

	/// en: 'User Type'
	String get userType => 'User Type';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'Status Message'
	String get statusMessage => 'Status Message';

	/// en: 'Bio'
	String get bio => 'Bio';

	/// en: 'Links'
	String get links => 'Links';

	/// en: 'Groups'
	String get group => 'Groups';

	/// en: 'View Group Details'
	String get groupDetail => 'View Group Details';

	/// en: 'Current Avatar'
	String get avatar => 'Current Avatar';

	/// en: 'View Avatar Details'
	String get avatarDetail => 'View Avatar Details';

	/// en: 'Public'
	String get public => 'Public';

	/// en: 'Private'
	String get private => 'Private';

	/// en: 'Hidden'
	String get hidden => 'Hidden';

	/// en: 'Unknown'
	String get unknown => 'Unknown';

	/// en: 'Friends'
	String get friends => 'Friends';

	/// en: 'Loading links...'
	String get loadingLinks => 'Loading links...';

	/// en: 'Not in any groups'
	String get noGroup => 'Not in any groups';

	/// en: 'No bio available'
	String get noBio => 'No bio available';

	/// en: 'No links available'
	String get noLinks => 'No links available';

	/// en: 'Save Changes'
	String get save => 'Save Changes';

	/// en: 'Profile updated successfully.'
	String get saved => 'Profile updated successfully.';

	/// en: 'Failed to update: {error}'
	String get saveFailed => 'Failed to update: {error}';

	/// en: 'Discard changes?'
	String get discardTitle => 'Discard changes?';

	/// en: 'Changes made to your profile will not be saved.'
	String get discardContent => 'Changes made to your profile will not be saved.';

	/// en: 'Cancel'
	String get discardCancel => 'Cancel';

	/// en: 'Discard'
	String get discardOk => 'Discard';

	/// en: 'Basic Info'
	String get basic => 'Basic Info';

	/// en: 'Pronouns'
	String get pronouns => 'Pronouns';

	/// en: 'Add'
	String get addLink => 'Add';

	/// en: 'Remove'
	String get removeLink => 'Remove';

	/// en: 'Enter link (e.g., https://twitter.com/username)'
	String get linkHint => 'Enter link (e.g., https://twitter.com/username)';

	/// en: 'Links will be displayed on your profile and can be opened by tapping.'
	String get linksHint => 'Links will be displayed on your profile and can be opened by tapping.';

	/// en: 'Enter your current situation or a message.'
	String get statusMessageHint => 'Enter your current situation or a message.';

	/// en: 'Write something about yourself.'
	String get bioHint => 'Write something about yourself.';
}

// Path: engageCard
class Translations$engageCard$en {
	Translations$engageCard$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Select Background Image'
	String get pickBackground => 'Select Background Image';

	/// en: 'Remove Background Image'
	String get removeBackground => 'Remove Background Image';

	/// en: 'Scan QR Code'
	String get scanQr => 'Scan QR Code';

	/// en: 'Show Avatar'
	String get showAvatar => 'Show Avatar';

	/// en: 'Hide Avatar'
	String get hideAvatar => 'Hide Avatar';

	/// en: 'No background image selected. You can set one from the top right button.'
	String get noBackground => 'No background image selected.\nYou can set one from the top right button.';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Failed to load engage card information: ${error}'
	String error({required Object error}) => 'Failed to load engage card information: ${error}';

	/// en: 'Copy User ID'
	String get copyUserId => 'Copy User ID';

	/// en: 'Copied'
	String get copied => 'Copied';
}

// Path: qrScanner
class Translations$qrScanner$en {
	Translations$qrScanner$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'QR Code Scan'
	String get title => 'QR Code Scan';

	/// en: 'Align the QR code within the frame.'
	String get guide => 'Align the QR code within the frame.';

	/// en: 'Initializing camera...'
	String get loading => 'Initializing camera...';

	/// en: 'Failed to read QR code: ${error}'
	String error({required Object error}) => 'Failed to read QR code: ${error}';

	/// en: 'No valid user QR code found.'
	String get notFound => 'No valid user QR code found.';
}

// Path: favorites
class Translations$favorites$en {
	Translations$favorites$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Favorites'
	String get title => 'Favorites';

	/// en: 'Friend'
	String get frined => 'Friend';

	/// en: 'Friends'
	String get friendsTab => 'Friends';

	/// en: 'Worlds'
	String get worldsTab => 'Worlds';

	/// en: 'Avatars'
	String get avatarsTab => 'Avatars';

	/// en: 'No favorite folders'
	String get emptyFolderTitle => 'No favorite folders';

	/// en: 'Please create a favorite folder in VRChat.'
	String get emptyFolderDescription => 'Please create a favorite folder in VRChat.';

	/// en: 'No friends in this folder.'
	String get emptyFriends => 'No friends in this folder.';

	/// en: 'No worlds in this folder.'
	String get emptyWorlds => 'No worlds in this folder.';

	/// en: 'No avatars in this folder.'
	String get emptyAvatars => 'No avatars in this folder.';

	/// en: 'No favorite worlds'
	String get emptyWorldsTabTitle => 'No favorite worlds';

	/// en: 'You can add worlds to favorites from the world details screen.'
	String get emptyWorldsTabDescription => 'You can add worlds to favorites from the world details screen.';

	/// en: 'No favorite avatars'
	String get emptyAvatarsTabTitle => 'No favorite avatars';

	/// en: 'You can add avatars to favorites from the avatar details screen.'
	String get emptyAvatarsTabDescription => 'You can add avatars to favorites from the avatar details screen.';

	/// en: 'Loading favorites...'
	String get loading => 'Loading favorites...';

	/// en: 'Loading folder information...'
	String get loadingFolder => 'Loading folder information...';

	/// en: 'Failed to load favorites: ${error}'
	String error({required Object error}) => 'Failed to load favorites: ${error}';

	/// en: 'Failed to get information.'
	String get errorFolder => 'Failed to get information.';

	/// en: 'Remove from Favorites'
	String get remove => 'Remove from Favorites';

	/// en: 'Removed ${name} from favorites.'
	String removeSuccess({required Object name}) => 'Removed ${name} from favorites.';

	/// en: 'Failed to remove: ${error}'
	String removeFailed({required Object error}) => 'Failed to remove: ${error}';

	/// en: '${count} items'
	String itemsCount({required Object count}) => '${count} items';

	/// en: 'Public'
	String get public => 'Public';

	/// en: 'Private'
	String get private => 'Private';

	/// en: 'Hidden'
	String get hidden => 'Hidden';

	/// en: 'Unknown'
	String get unknown => 'Unknown';

	/// en: 'Loading Error'
	String get loadingError => 'Loading Error';
}

// Path: notifications
class Translations$notifications$en {
	Translations$notifications$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get title => 'Notifications';

	/// en: 'No Notifications'
	String get emptyTitle => 'No Notifications';

	/// en: 'New notifications, like friend requests and invites, will appear here.'
	String get emptyDescription => 'New notifications, like friend requests and invites,\nwill appear here.';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Unread (${count})'
	String unread({required Object count}) => 'Unread (${count})';

	/// en: 'Read'
	String get read => 'Read';

	/// en: 'Friend log'
	String get activity => 'Friend log';

	/// en: 'Online alerts'
	String get onlineAlerts => 'Online alerts';

	/// en: 'Mark all as read'
	String get markAllRead => 'Mark all as read';

	/// en: 'All notifications marked as read.'
	String get markAllReadDone => 'All notifications marked as read.';

	/// en: 'Delete notification?'
	String get deleteConfirmTitle => 'Delete notification?';

	/// en: 'No unread notifications'
	String get emptyUnread => 'No unread notifications';

	/// en: 'No read notifications'
	String get emptyRead => 'No read notifications';

	/// en: 'Friend online alerts'
	String get friendOnlineAlerts => 'Friend online alerts';

	/// en: '${count} selected'
	String selectedCount({required Object count}) => '${count} selected';

	/// en: 'You have a friend request from ${userName}.'
	String friendRequest({required Object userName}) => 'You have a friend request from ${userName}.';

	/// en: 'You have an invite to ${worldName} from ${userName}.'
	String invite({required Object worldName, required Object userName}) => 'You have an invite to ${worldName} from ${userName}.';

	/// en: '${userName} is now online.'
	String friendOnline({required Object userName}) => '${userName} is now online.';

	/// en: '${userName} is now offline.'
	String friendOffline({required Object userName}) => '${userName} is now offline.';

	/// en: '${userName} is now active.'
	String friendActive({required Object userName}) => '${userName} is now active.';

	/// en: '${userName} has been added to your friends.'
	String friendAdd({required Object userName}) => '${userName} has been added to your friends.';

	/// en: '${userName} has been removed from your friends.'
	String friendRemove({required Object userName}) => '${userName} has been removed from your friends.';

	/// en: '${userName}'s status updated: ${status}${world}'
	String statusUpdate({required Object userName, required Object status, required Object world}) => '${userName}\'s status updated: ${status}${world}';

	/// en: '${userName} moved to ${worldName}.'
	String locationChange({required Object userName, required Object worldName}) => '${userName} moved to ${worldName}.';

	/// en: 'Your information has been updated${world}.'
	String userUpdate({required Object world}) => 'Your information has been updated${world}.';

	/// en: 'You moved to: ${worldName}'
	String myLocationChange({required Object worldName}) => 'You moved to: ${worldName}';

	/// en: 'You have a request to join from ${userName}.'
	String requestInvite({required Object userName}) => 'You have a request to join from ${userName}.';

	/// en: 'There was a votekick from ${userName}.'
	String votekick({required Object userName}) => 'There was a votekick from ${userName}.';

	/// en: 'Received response for notification ID: ${userName}'
	String responseReceived({required Object userName}) => 'Received response for notification ID: ${userName}';

	/// en: 'Error: ${worldName}'
	String error({required Object worldName}) => 'Error: ${worldName}';

	/// en: 'System notification: ${extraData}'
	String system({required Object extraData}) => 'System notification: ${extraData}';

	/// en: '${seconds}s ago'
	String secondsAgo({required Object seconds}) => '${seconds}s ago';

	/// en: '${minutes}m ago'
	String minutesAgo({required Object minutes}) => '${minutes}m ago';

	/// en: '${hours}h ago'
	String hoursAgo({required Object hours}) => '${hours}h ago';
}

// Path: eventCalendar
class Translations$eventCalendar$en {
	Translations$eventCalendar$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Event Calendar'
	String get title => 'Event Calendar';

	/// en: 'Filter Events'
	String get filter => 'Filter Events';

	/// en: 'Refresh Events'
	String get refresh => 'Refresh Events';

	/// en: 'Loading events...'
	String get loading => 'Loading events...';

	/// en: 'Failed to load events: ${error}'
	String error({required Object error}) => 'Failed to load events: ${error}';

	/// en: 'Filter applied (${count} results)'
	String filterActive({required Object count}) => 'Filter applied (${count} results)';

	/// en: 'Clear'
	String get clear => 'Clear';

	/// en: 'No events match the criteria.'
	String get noEvents => 'No events match the criteria.';

	/// en: 'Clear Filter'
	String get clearFilter => 'Clear Filter';

	/// en: 'Today'
	String get today => 'Today';

	/// en: 'Set Reminder'
	String get reminderSet => 'Set Reminder';

	/// en: 'Reminder Set'
	String get reminderSetDone => 'Reminder Set';

	/// en: 'Reminder deleted.'
	String get reminderDeleted => 'Reminder deleted.';

	/// en: 'Event Name'
	String get eventName => 'Event Name';

	/// en: 'Organizer'
	String get organizer => 'Organizer';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Genre'
	String get genre => 'Genre';

	/// en: 'Participation Conditions'
	String get condition => 'Participation Conditions';

	/// en: 'How to Join'
	String get way => 'How to Join';

	/// en: 'Notes'
	String get note => 'Notes';

	/// en: 'Quest Compatible'
	String get quest => 'Quest Compatible';

	/// en: '${count}'
	String reminderCount({required Object count}) => '${count}';

	/// en: '${start} - ${end}'
	String startToEnd({required Object start, required Object end}) => '${start} - ${end}';
}

// Path: avatars
class Translations$avatars$en {
	Translations$avatars$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Avatars'
	String get title => 'Avatars';

	/// en: 'Search by avatar name, etc.'
	String get searchHint => 'Search by avatar name, etc.';

	/// en: 'Search'
	String get searchTooltip => 'Search';

	/// en: 'No search results found.'
	String get searchEmptyTitle => 'No search results found.';

	/// en: 'Please try a different search term.'
	String get searchEmptyDescription => 'Please try a different search term.';

	/// en: 'No avatars'
	String get emptyTitle => 'No avatars';

	/// en: 'Please add an avatar or try again later.'
	String get emptyDescription => 'Please add an avatar or try again later.';

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Loading avatars...'
	String get loading => 'Loading avatars...';

	/// en: 'Failed to load avatars: ${error}'
	String error({required Object error}) => 'Failed to load avatars: ${error}';

	/// en: 'In Use'
	String get current => 'In Use';

	/// en: 'Public'
	String get public => 'Public';

	/// en: 'Private'
	String get private => 'Private';

	/// en: 'Hidden'
	String get hidden => 'Hidden';

	/// en: 'Author'
	String get author => 'Author';

	/// en: 'By Update Date'
	String get sortUpdated => 'By Update Date';

	/// en: 'By Name'
	String get sortName => 'By Name';

	/// en: 'Sort'
	String get sortTooltip => 'Sort';

	/// en: 'Toggle View Mode'
	String get viewModeTooltip => 'Toggle View Mode';
}

// Path: worldDetail
class Translations$worldDetail$en {
	Translations$worldDetail$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading world information...'
	String get loading => 'Loading world information...';

	/// en: 'Failed to load world information: ${error}'
	String error({required Object error}) => 'Failed to load world information: ${error}';

	/// en: 'Share This World'
	String get share => 'Share This World';

	/// en: 'Open on VRChat Official Website'
	String get openInVRChat => 'Open on VRChat Official Website';

	/// en: 'Report This World'
	String get report => 'Report This World';

	/// en: 'Creator'
	String get creator => 'Creator';

	/// en: 'Created'
	String get created => 'Created';

	/// en: 'Updated'
	String get updated => 'Updated';

	/// en: 'Favorites'
	String get favorites => 'Favorites';

	/// en: 'Visits'
	String get visits => 'Visits';

	/// en: 'Current Occupants'
	String get occupants => 'Current Occupants';

	/// en: 'Popularity'
	String get popularity => 'Popularity';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'No description available.'
	String get noDescription => 'No description available.';

	/// en: 'Tags'
	String get tags => 'Tags';

	/// en: 'Send Invite to Public Instance'
	String get joinPublic => 'Send Invite to Public Instance';

	/// en: 'Added to favorites.'
	String get favoriteAdded => 'Added to favorites.';

	/// en: 'Removed from favorites.'
	String get favoriteRemoved => 'Removed from favorites.';

	/// en: 'Unknown'
	String get unknown => 'Unknown';
}

// Path: avatarDetail
class Translations$avatarDetail$en {
	Translations$avatarDetail$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Changed to avatar "${name}".'
	String changeSuccess({required Object name}) => 'Changed to avatar "${name}".';

	/// en: 'Failed to change avatar: ${error}'
	String changeFailed({required Object error}) => 'Failed to change avatar: ${error}';

	/// en: 'Changing...'
	String get changing => 'Changing...';

	/// en: 'Use This Avatar'
	String get useThisAvatar => 'Use This Avatar';

	/// en: 'Creator'
	String get creator => 'Creator';

	/// en: 'Created'
	String get created => 'Created';

	/// en: 'Updated'
	String get updated => 'Updated';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'No description available.'
	String get noDescription => 'No description available.';

	/// en: 'Tags'
	String get tags => 'Tags';

	/// en: 'Add to Favorites'
	String get addToFavorites => 'Add to Favorites';

	/// en: 'Public'
	String get public => 'Public';

	/// en: 'Private'
	String get private => 'Private';

	/// en: 'Hidden'
	String get hidden => 'Hidden';

	/// en: 'Unknown'
	String get unknown => 'Unknown';

	/// en: 'Share'
	String get share => 'Share';

	/// en: 'Loading avatar information...'
	String get loading => 'Loading avatar information...';

	/// en: 'Failed to load avatar information: ${error}'
	String error({required Object error}) => 'Failed to load avatar information: ${error}';
}

// Path: groups
class Translations$groups$en {
	Translations$groups$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Groups'
	String get title => 'Groups';

	/// en: 'Loading user information...'
	String get loadingUser => 'Loading user information...';

	/// en: 'Failed to load user information: ${error}'
	String errorUser({required Object error}) => 'Failed to load user information: ${error}';

	/// en: 'Loading group information...'
	String get loadingGroups => 'Loading group information...';

	/// en: 'Failed to load group information: ${error}'
	String errorGroups({required Object error}) => 'Failed to load group information: ${error}';

	/// en: 'You are not in any groups.'
	String get emptyTitle => 'You are not in any groups.';

	/// en: 'You can join groups from the VRChat app or website.'
	String get emptyDescription => 'You can join groups from the VRChat app or website.';

	/// en: 'Find Groups'
	String get searchGroups => 'Find Groups';

	/// en: '${count} members'
	String members({required Object count}) => '${count} members';

	/// en: 'Show Details'
	String get showDetails => 'Show Details';

	/// en: 'Unknown Name'
	String get unknownName => 'Unknown Name';
}

// Path: groupDetail
class Translations$groupDetail$en {
	Translations$groupDetail$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading group information...'
	String get loading => 'Loading group information...';

	/// en: 'Failed to load group information: ${error}'
	String error({required Object error}) => 'Failed to load group information: ${error}';

	/// en: 'Share Group Info'
	String get share => 'Share Group Info';

	/// en: 'Description'
	String get description => 'Description';

	/// en: 'Roles'
	String get roles => 'Roles';

	/// en: 'Basic Info'
	String get basicInfo => 'Basic Info';

	/// en: 'Created At'
	String get createdAt => 'Created At';

	/// en: 'Owner'
	String get owner => 'Owner';

	/// en: 'Rules'
	String get rules => 'Rules';

	/// en: 'Languages'
	String get languages => 'Languages';

	/// en: '${count} Members'
	String memberCount({required Object count}) => '${count} Members';

	late final Translations$groupDetail$privacy$en privacy = Translations$groupDetail$privacy$en._(_root);
	late final Translations$groupDetail$role$en role = Translations$groupDetail$role$en._(_root);
}

// Path: inventory
class Translations$inventory$en {
	Translations$inventory$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Inventory'
	String get title => 'Inventory';

	/// en: 'Gallery'
	String get gallery => 'Gallery';

	/// en: 'Icon'
	String get icon => 'Icon';

	/// en: 'Emoji'
	String get emoji => 'Emoji';

	/// en: 'Sticker'
	String get sticker => 'Sticker';

	/// en: 'Print'
	String get print => 'Print';

	/// en: 'Items'
	String get item => 'Items';

	/// en: 'Upload File'
	String get upload => 'Upload File';

	/// en: 'Uploading gallery image...'
	String get uploadGallery => 'Uploading gallery image...';

	/// en: 'Uploading icon...'
	String get uploadIcon => 'Uploading icon...';

	/// en: 'Uploading emoji...'
	String get uploadEmoji => 'Uploading emoji...';

	/// en: 'Uploading sticker...'
	String get uploadSticker => 'Uploading sticker...';

	/// en: 'Uploading print image...'
	String get uploadPrint => 'Uploading print image...';

	/// en: 'Select Image'
	String get selectImage => 'Select Image';

	/// en: 'Select from Gallery'
	String get selectFromGallery => 'Select from Gallery';

	/// en: 'Take Photo with Camera'
	String get takePhoto => 'Take Photo with Camera';

	/// en: 'Upload complete.'
	String get uploadSuccess => 'Upload complete.';

	/// en: 'Upload failed.'
	String get uploadFailed => 'Upload failed.';

	/// en: 'There is a problem with the file format or size. Please select a PNG image under 1MB.'
	String get uploadFailedFormat => 'There is a problem with the file format or size. Please select a PNG image under 1MB.';

	/// en: 'Authentication failed. Please log in again.'
	String get uploadFailedAuth => 'Authentication failed. Please log in again.';

	/// en: 'File size is too large. Please select a smaller image.'
	String get uploadFailedSize => 'File size is too large. Please select a smaller image.';

	/// en: 'Server error occurred (${code})'
	String uploadFailedServer({required Object code}) => 'Server error occurred (${code})';

	/// en: 'Failed to select image: ${error}'
	String pickImageFailed({required Object error}) => 'Failed to select image: ${error}';

	late final Translations$inventory$tabs$en tabs = Translations$inventory$tabs$en._(_root);
}

// Path: feedback
class Translations$feedback$en {
	Translations$feedback$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Feedback'
	String get title => 'Feedback';

	/// en: 'Feedback Type'
	String get type => 'Feedback Type';

	Map<String, String> get types => {
		'bug': 'Bug Report',
		'feature': 'Feature Request',
		'improvement': 'Suggestion for Improvement',
		'other': 'Other',
	};

	/// en: 'Title *'
	String get inputTitle => 'Title *';

	/// en: 'Please be concise.'
	String get inputTitleHint => 'Please be concise.';

	/// en: 'Description *'
	String get inputDescription => 'Description *';

	/// en: 'Please provide a detailed description...'
	String get inputDescriptionHint => 'Please provide a detailed description...';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Send'
	String get send => 'Send';

	/// en: 'Sending...'
	String get sending => 'Sending...';

	/// en: 'Title and description are required.'
	String get required => 'Title and description are required.';

	/// en: 'Feedback sent. Thank you!'
	String get success => 'Feedback sent. Thank you!';

	/// en: 'Failed to send feedback.'
	String get fail => 'Failed to send feedback.';
}

// Path: settings
class Translations$settings$en {
	Translations$settings$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Appearance'
	String get appearance => 'Appearance';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'You can select the display language for the app.'
	String get languageDescription => 'You can select the display language for the app.';

	/// en: 'App Icon'
	String get appIcon => 'App Icon';

	/// en: 'Change the app icon displayed on the home screen.'
	String get appIconDescription => 'Change the app icon displayed on the home screen.';

	/// en: 'Content Settings'
	String get contentSettings => 'Content Settings';

	/// en: 'Search feature enabled.'
	String get searchEnabled => 'Search feature enabled.';

	/// en: 'Search feature disabled.'
	String get searchDisabled => 'Search feature disabled.';

	/// en: 'Enable Search'
	String get enableSearch => 'Enable Search';

	/// en: 'Search results may include sexual or violent content.'
	String get enableSearchDescription => 'Search results may include sexual or violent content.';

	/// en: 'Avatar Search API'
	String get apiSetting => 'Avatar Search API';

	/// en: 'Set the API for the avatar search feature.'
	String get apiSettingDescription => 'Set the API for the avatar search feature.';

	/// en: 'URL saved.'
	String get apiSettingSaveUrl => 'URL saved.';

	/// en: 'Not set (Avatar search feature cannot be used).'
	String get notSet => 'Not set (Avatar search feature cannot be used).';

	/// en: 'Notification Settings'
	String get notifications => 'Notification Settings';

	/// en: 'Event Reminders'
	String get eventReminder => 'Event Reminders';

	/// en: 'Receive notifications before your scheduled events start.'
	String get eventReminderDescription => 'Receive notifications before your scheduled events start.';

	/// en: 'Manage Set Reminders'
	String get manageReminders => 'Manage Set Reminders';

	/// en: 'Cancel or check your notifications.'
	String get manageRemindersDescription => 'Cancel or check your notifications.';

	/// en: 'Data and Storage'
	String get dataStorage => 'Data and Storage';

	/// en: 'Clear Cache'
	String get clearCache => 'Clear Cache';

	/// en: 'Cache cleared.'
	String get clearCacheSuccess => 'Cache cleared.';

	/// en: 'An error occurred while clearing the cache.'
	String get clearCacheError => 'An error occurred while clearing the cache.';

	/// en: 'Cache size: ${size}'
	String cacheSize({required Object size}) => 'Cache size: ${size}';

	/// en: 'Calculating cache size...'
	String get calculatingCache => 'Calculating cache size...';

	/// en: 'Could not get cache size.'
	String get cacheError => 'Could not get cache size.';

	/// en: 'Clearing the cache will delete temporarily saved images and data. Your account information and app settings will not be deleted.'
	String get confirmClearCache => 'Clearing the cache will delete temporarily saved images and data.\n\nYour account information and app settings will not be deleted.';

	/// en: 'App Information'
	String get appInfo => 'App Information';

	/// en: 'Version'
	String get version => 'Version';

	/// en: 'Package Name'
	String get packageName => 'Package Name';

	/// en: 'Credits'
	String get credit => 'Credits';

	/// en: 'Developer and contributor information.'
	String get creditDescription => 'Developer and contributor information.';

	/// en: 'Contact'
	String get contact => 'Contact';

	/// en: 'For bug reports and suggestions.'
	String get contactDescription => 'For bug reports and suggestions.';

	/// en: 'Privacy Policy'
	String get privacyPolicy => 'Privacy Policy';

	/// en: 'About the handling of personal information.'
	String get privacyPolicyDescription => 'About the handling of personal information.';

	/// en: 'Terms of Service'
	String get termsOfService => 'Terms of Service';

	/// en: 'Conditions for using the app.'
	String get termsOfServiceDescription => 'Conditions for using the app.';

	/// en: 'Open Source Information'
	String get openSource => 'Open Source Information';

	/// en: 'Licenses for libraries used.'
	String get openSourceDescription => 'Licenses for libraries used.';

	/// en: 'GitHub Repository'
	String get github => 'GitHub Repository';

	/// en: 'View source code.'
	String get githubDescription => 'View source code.';

	/// en: 'Are you sure you want to log out?'
	String get logoutConfirm => 'Are you sure you want to log out?';

	/// en: 'An error occurred during logout: ${error}'
	String logoutError({required Object error}) => 'An error occurred during logout: ${error}';

	/// en: 'Changing the app icon is not supported on your device.'
	String get iconChangeNotSupported => 'Changing the app icon is not supported on your device.';

	/// en: 'Failed to change icon.'
	String get iconChangeFailed => 'Failed to change icon.';

	/// en: 'Theme Mode'
	String get themeMode => 'Theme Mode';

	/// en: 'You can select the display theme of the app.'
	String get themeModeDescription => 'You can select the display theme of the app.';

	/// en: 'Light'
	String get themeLight => 'Light';

	/// en: 'System'
	String get themeSystem => 'System';

	/// en: 'Dark'
	String get themeDark => 'Dark';

	/// en: 'Default'
	String get appIconDefault => 'Default';

	/// en: 'Icon'
	String get appIconIcon => 'Icon';

	/// en: 'Logo'
	String get appIconLogo => 'Logo';

	/// en: 'Delete'
	String get delete => 'Delete';
}

// Path: credits
class Translations$credits$en {
	Translations$credits$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Credits'
	String get title => 'Credits';

	late final Translations$credits$section$en section = Translations$credits$section$en._(_root);
}

// Path: download
class Translations$download$en {
	Translations$download$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sharing failed: ${error}'
	String shareFailure({required Object error}) => 'Sharing failed: ${error}';

	/// en: 'Preparing to share ${fileName}...'
	String sharing({required Object fileName}) => 'Preparing to share ${fileName}...';
}

// Path: instance
class Translations$instance$en {
	Translations$instance$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$instance$type$en type = Translations$instance$type$en._(_root);
}

// Path: status
class Translations$status$en {
	Translations$status$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Online'
	String get active => 'Online';

	/// en: 'Join Me'
	String get joinMe => 'Join Me';

	/// en: 'Ask Me'
	String get askMe => 'Ask Me';

	/// en: 'Busy'
	String get busy => 'Busy';

	/// en: 'Offline'
	String get offline => 'Offline';

	/// en: 'Unknown Status'
	String get unknown => 'Unknown Status';
}

// Path: location
class Translations$location$en {
	Translations$location$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Private'
	String get private => 'Private';

	/// en: 'Players: ${userCount} / ${capacity}'
	String playerCount({required Object userCount, required Object capacity}) => 'Players: ${userCount} / ${capacity}';

	/// en: 'Instance Type: ${type}'
	String instanceType({required Object type}) => 'Instance Type: ${type}';

	/// en: 'No location information available.'
	String get noInfo => 'No location information available.';

	/// en: 'Failed to get location information.'
	String get fetchError => 'Failed to get location information.';

	/// en: 'You are in a private location.'
	String get privateLocation => 'You are in a private location.';

	/// en: 'Sending invite...'
	String get inviteSending => 'Sending invite...';

	/// en: 'Invite sent. You can join from your notifications.'
	String get inviteSent => 'Invite sent. You can join from your notifications.';

	/// en: 'Failed to send invite: ${error}'
	String inviteFailed({required Object error}) => 'Failed to send invite: ${error}';

	/// en: 'Send Invite to Myself'
	String get inviteButton => 'Send Invite to Myself';

	/// en: '${number} in private'
	String isPrivate({required Object number}) => '${number} in private';

	/// en: '${number} active'
	String isActive({required Object number}) => '${number} active';

	/// en: '${number} offline'
	String isOffline({required Object number}) => '${number} offline';

	/// en: '${number} traveling'
	String isTraveling({required Object number}) => '${number} traveling';

	/// en: '${number} staying'
	String isStaying({required Object number}) => '${number} staying';
}

// Path: reminder
class Translations$reminder$en {
	Translations$reminder$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Set Reminder'
	String get dialogTitle => 'Set Reminder';

	/// en: 'Already Set'
	String get alreadySet => 'Already Set';

	/// en: 'Set'
	String get set => 'Set';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Delete All Reminders'
	String get deleteAll => 'Delete All Reminders';

	/// en: 'This will delete all set event reminders. This action cannot be undone.'
	String get deleteAllConfirm => 'This will delete all set event reminders. This action cannot be undone.';

	/// en: 'Reminder deleted.'
	String get deleted => 'Reminder deleted.';

	/// en: 'All reminders deleted.'
	String get deletedAll => 'All reminders deleted.';

	/// en: 'No reminders set.'
	String get noReminders => 'No reminders set.';

	/// en: 'You can set notifications from the event page.'
	String get setFromEvent => 'You can set notifications from the event page.';

	/// en: 'Starts at ${time}'
	String eventStart({required Object time}) => 'Starts at ${time}';

	/// en: '${time} (${label})'
	String notifyAt({required Object time, required Object label}) => '${time} (${label})';

	/// en: 'When do you want to be notified?'
	String get receiveNotification => 'When do you want to be notified?';
}

// Path: friend
class Translations$friend$en {
	Translations$friend$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Sort & Filter'
	String get sortFilter => 'Sort & Filter';

	/// en: 'Filter'
	String get filter => 'Filter';

	/// en: 'Show All'
	String get filterAll => 'Show All';

	/// en: 'Online Only'
	String get filterOnline => 'Online Only';

	/// en: 'Offline Only'
	String get filterOffline => 'Offline Only';

	/// en: 'Favorites Only'
	String get filterFavorite => 'Favorites Only';

	/// en: 'Sort'
	String get sort => 'Sort';

	/// en: 'By Status'
	String get sortStatus => 'By Status';

	/// en: 'By Name'
	String get sortName => 'By Name';

	/// en: 'By Last Login'
	String get sortLastLogin => 'By Last Login';

	/// en: 'Ascending'
	String get sortAsc => 'Ascending';

	/// en: 'Descending'
	String get sortDesc => 'Descending';

	/// en: 'Close'
	String get close => 'Close';
}

// Path: eventCalendarFilter
class Translations$eventCalendarFilter$en {
	Translations$eventCalendarFilter$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Filter Events'
	String get filterTitle => 'Filter Events';

	/// en: 'Clear'
	String get clear => 'Clear';

	/// en: 'Keyword Search'
	String get keyword => 'Keyword Search';

	/// en: 'Event name, description, organizer, etc.'
	String get keywordHint => 'Event name, description, organizer, etc.';

	/// en: 'Filter by Date'
	String get date => 'Filter by Date';

	/// en: 'You can display events for a specific date range.'
	String get dateHint => 'You can display events for a specific date range.';

	/// en: 'Start Date'
	String get startDate => 'Start Date';

	/// en: 'End Date'
	String get endDate => 'End Date';

	/// en: 'Please select'
	String get select => 'Please select';

	/// en: 'Filter by Time'
	String get time => 'Filter by Time';

	/// en: 'You can display events held during a specific time frame.'
	String get timeHint => 'You can display events held during a specific time frame.';

	/// en: 'Start Time'
	String get startTime => 'Start Time';

	/// en: 'End Time'
	String get endTime => 'End Time';

	/// en: 'Filter by Genre'
	String get genre => 'Filter by Genre';

	/// en: '${count} genres selected'
	String genreSelected({required Object count}) => '${count} genres selected';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'Filters'
	String get filterSummary => 'Filters';

	/// en: 'No filters are set.'
	String get filterNone => 'No filters are set.';
}

// Path: drawer.section
class Translations$drawer$section$en {
	Translations$drawer$section$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Content'
	String get content => 'Content';

	/// en: 'Other'
	String get other => 'Other';
}

// Path: search.tabs
class Translations$search$tabs$en {
	Translations$search$tabs$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$search$tabs$userSearch$en userSearch = Translations$search$tabs$userSearch$en._(_root);
	late final Translations$search$tabs$worldSearch$en worldSearch = Translations$search$tabs$worldSearch$en._(_root);
	late final Translations$search$tabs$groupSearch$en groupSearch = Translations$search$tabs$groupSearch$en._(_root);
	late final Translations$search$tabs$avatarSearch$en avatarSearch = Translations$search$tabs$avatarSearch$en._(_root);
}

// Path: groupDetail.privacy
class Translations$groupDetail$privacy$en {
	Translations$groupDetail$privacy$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Public'
	String get public => 'Public';

	/// en: 'Private'
	String get private => 'Private';

	/// en: 'Friends'
	String get friends => 'Friends';

	/// en: 'Invite'
	String get invite => 'Invite';

	/// en: 'Unknown'
	String get unknown => 'Unknown';
}

// Path: groupDetail.role
class Translations$groupDetail$role$en {
	Translations$groupDetail$role$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Admin'
	String get admin => 'Admin';

	/// en: 'Moderator'
	String get moderator => 'Moderator';

	/// en: 'Member'
	String get member => 'Member';

	/// en: 'Unknown'
	String get unknown => 'Unknown';
}

// Path: inventory.tabs
class Translations$inventory$tabs$en {
	Translations$inventory$tabs$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$inventory$tabs$emojiInventory$en emojiInventory = Translations$inventory$tabs$emojiInventory$en._(_root);
	late final Translations$inventory$tabs$galleryInventory$en galleryInventory = Translations$inventory$tabs$galleryInventory$en._(_root);
	late final Translations$inventory$tabs$iconInventory$en iconInventory = Translations$inventory$tabs$iconInventory$en._(_root);
	late final Translations$inventory$tabs$printInventory$en printInventory = Translations$inventory$tabs$printInventory$en._(_root);
	late final Translations$inventory$tabs$stickerInventory$en stickerInventory = Translations$inventory$tabs$stickerInventory$en._(_root);
	late final Translations$inventory$tabs$inventoryItem$en inventoryItem = Translations$inventory$tabs$inventoryItem$en._(_root);
}

// Path: credits.section
class Translations$credits$section$en {
	Translations$credits$section$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Development'
	String get development => 'Development';

	/// en: 'The Fun Icon People'
	String get iconPeople => 'The Fun Icon People';

	/// en: 'Testing & Feedback'
	String get testFeedback => 'Testing & Feedback';

	/// en: 'Special Thanks'
	String get specialThanks => 'Special Thanks';
}

// Path: instance.type
class Translations$instance$type$en {
	Translations$instance$type$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Public'
	String get public => 'Public';

	/// en: 'Friend+'
	String get hidden => 'Friend+';

	/// en: 'Friends'
	String get friends => 'Friends';

	/// en: 'Invite+'
	String get private => 'Invite+';

	/// en: 'Unknown'
	String get unknown => 'Unknown';
}

// Path: search.tabs.userSearch
class Translations$search$tabs$userSearch$en {
	Translations$search$tabs$userSearch$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'User Search'
	String get emptyTitle => 'User Search';

	/// en: 'You can search by username or ID.'
	String get emptyDescription => 'You can search by username or ID.';

	/// en: 'Searching...'
	String get searching => 'Searching...';

	/// en: 'No matching users found.'
	String get noResults => 'No matching users found.';

	/// en: 'An error occurred during user search: ${error}'
	String error({required Object error}) => 'An error occurred during user search: ${error}';

	/// en: 'Enter username or ID'
	String get inputPlaceholder => 'Enter username or ID';
}

// Path: search.tabs.worldSearch
class Translations$search$tabs$worldSearch$en {
	Translations$search$tabs$worldSearch$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Explore Worlds'
	String get emptyTitle => 'Explore Worlds';

	/// en: 'Please enter a keyword to search.'
	String get emptyDescription => 'Please enter a keyword to search.';

	/// en: 'Searching...'
	String get searching => 'Searching...';

	/// en: 'No matching worlds found.'
	String get noResults => 'No matching worlds found.';

	/// en: 'No worlds found matching "${query}"'
	String noResultsWithQuery({required Object query}) => 'No worlds found matching "${query}"';

	/// en: 'Try changing your search keywords.'
	String get noResultsHint => 'Try changing your search keywords.';

	/// en: 'An error occurred during world search: ${error}'
	String error({required Object error}) => 'An error occurred during world search: ${error}';

	/// en: '${count} worlds found'
	String resultCount({required Object count}) => '${count} worlds found';

	/// en: 'by ${authorName}'
	String authorPrefix({required Object authorName}) => 'by ${authorName}';

	/// en: 'List View'
	String get listView => 'List View';

	/// en: 'Grid View'
	String get gridView => 'Grid View';
}

// Path: search.tabs.groupSearch
class Translations$search$tabs$groupSearch$en {
	Translations$search$tabs$groupSearch$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Search Groups'
	String get emptyTitle => 'Search Groups';

	/// en: 'Please enter a keyword to search.'
	String get emptyDescription => 'Please enter a keyword to search.';

	/// en: 'Searching...'
	String get searching => 'Searching...';

	/// en: 'No matching groups found.'
	String get noResults => 'No matching groups found.';

	/// en: 'No groups found matching "${query}"'
	String noResultsWithQuery({required Object query}) => 'No groups found matching "${query}"';

	/// en: 'Try changing your search keywords.'
	String get noResultsHint => 'Try changing your search keywords.';

	/// en: 'An error occurred during group search: ${error}'
	String error({required Object error}) => 'An error occurred during group search: ${error}';

	/// en: '${count} groups found'
	String resultCount({required Object count}) => '${count} groups found';

	/// en: 'List View'
	String get listView => 'List View';

	/// en: 'Grid View'
	String get gridView => 'Grid View';

	/// en: '${count} members'
	String memberCount({required Object count}) => '${count} members';
}

// Path: search.tabs.avatarSearch
class Translations$search$tabs$avatarSearch$en {
	Translations$search$tabs$avatarSearch$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Avatar'
	String get avatar => 'Avatar';

	/// en: 'Search Avatars'
	String get emptyTitle => 'Search Avatars';

	/// en: 'Please enter a keyword to search.'
	String get emptyDescription => 'Please enter a keyword to search.';

	/// en: 'Searching for avatars...'
	String get searching => 'Searching for avatars...';

	/// en: 'No search results found.'
	String get noResults => 'No search results found.';

	/// en: 'Try another keyword.'
	String get noResultsHint => 'Try another keyword.';

	/// en: 'An error occurred during avatar search: ${error}'
	String error({required Object error}) => 'An error occurred during avatar search: ${error}';
}

// Path: inventory.tabs.emojiInventory
class Translations$inventory$tabs$emojiInventory$en {
	Translations$inventory$tabs$emojiInventory$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading emojis...'
	String get loading => 'Loading emojis...';

	/// en: 'Failed to load emojis: ${error}'
	String error({required Object error}) => 'Failed to load emojis: ${error}';

	/// en: 'No emojis'
	String get emptyTitle => 'No emojis';

	/// en: 'Emojis you upload in VRChat will appear here.'
	String get emptyDescription => 'Emojis you upload in VRChat will appear here.';

	/// en: 'Double-tap to zoom'
	String get zoomHint => 'Double-tap to zoom';
}

// Path: inventory.tabs.galleryInventory
class Translations$inventory$tabs$galleryInventory$en {
	Translations$inventory$tabs$galleryInventory$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading gallery...'
	String get loading => 'Loading gallery...';

	/// en: 'Failed to load gallery: ${error}'
	String error({required Object error}) => 'Failed to load gallery: ${error}';

	/// en: 'No gallery'
	String get emptyTitle => 'No gallery';

	/// en: 'Galleries you upload in VRChat will appear here.'
	String get emptyDescription => 'Galleries you upload in VRChat will appear here.';

	/// en: 'Double-tap to zoom'
	String get zoomHint => 'Double-tap to zoom';
}

// Path: inventory.tabs.iconInventory
class Translations$inventory$tabs$iconInventory$en {
	Translations$inventory$tabs$iconInventory$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading icons...'
	String get loading => 'Loading icons...';

	/// en: 'Failed to load icons: ${error}'
	String error({required Object error}) => 'Failed to load icons: ${error}';

	/// en: 'No icons'
	String get emptyTitle => 'No icons';

	/// en: 'Icons you upload in VRChat will appear here.'
	String get emptyDescription => 'Icons you upload in VRChat will appear here.';

	/// en: 'Double-tap to zoom'
	String get zoomHint => 'Double-tap to zoom';
}

// Path: inventory.tabs.printInventory
class Translations$inventory$tabs$printInventory$en {
	Translations$inventory$tabs$printInventory$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading prints...'
	String get loading => 'Loading prints...';

	/// en: 'Failed to load prints: ${error}'
	String error({required Object error}) => 'Failed to load prints: ${error}';

	/// en: 'No prints'
	String get emptyTitle => 'No prints';

	/// en: 'Prints you upload in VRChat will appear here.'
	String get emptyDescription => 'Prints you upload in VRChat will appear here.';

	/// en: 'Double-tap to zoom'
	String get zoomHint => 'Double-tap to zoom';
}

// Path: inventory.tabs.stickerInventory
class Translations$inventory$tabs$stickerInventory$en {
	Translations$inventory$tabs$stickerInventory$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading stickers...'
	String get loading => 'Loading stickers...';

	/// en: 'Failed to load stickers: ${error}'
	String error({required Object error}) => 'Failed to load stickers: ${error}';

	/// en: 'No stickers'
	String get emptyTitle => 'No stickers';

	/// en: 'Stickers you upload in VRChat will appear here.'
	String get emptyDescription => 'Stickers you upload in VRChat will appear here.';

	/// en: 'Double-tap to zoom'
	String get zoomHint => 'Double-tap to zoom';
}

// Path: inventory.tabs.inventoryItem
class Translations$inventory$tabs$inventoryItem$en {
	Translations$inventory$tabs$inventoryItem$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Loading inventory...'
	String get loading => 'Loading inventory...';

	/// en: 'Failed to load inventory: ${error}'
	String error({required Object error}) => 'Failed to load inventory: ${error}';

	/// en: 'No inventory items'
	String get emptyTitle => 'No inventory items';

	/// en: 'Spawn'
	String get spawn => 'Spawn';

	/// en: 'Unequip'
	String get unequip => 'Unequip';

	/// en: 'Equipped: ${slot}'
	String equipped({required Object slot}) => 'Equipped: ${slot}';

	/// en: '${name} spawned'
	String spawned({required Object name}) => '${name} spawned';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
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
			'notifications.title' => 'Notifications',
			'notifications.emptyTitle' => 'No Notifications',
			'notifications.emptyDescription' => 'New notifications, like friend requests and invites,\nwill appear here.',
			'notifications.all' => 'All',
			'notifications.unread' => ({required Object count}) => 'Unread (${count})',
			'notifications.read' => 'Read',
			'notifications.activity' => 'Friend log',
			'notifications.onlineAlerts' => 'Online alerts',
			'notifications.markAllRead' => 'Mark all as read',
			'notifications.markAllReadDone' => 'All notifications marked as read.',
			'notifications.deleteConfirmTitle' => 'Delete notification?',
			'notifications.emptyUnread' => 'No unread notifications',
			'notifications.emptyRead' => 'No read notifications',
			'notifications.friendOnlineAlerts' => 'Friend online alerts',
			'notifications.selectedCount' => ({required Object count}) => '${count} selected',
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
			'inventory.item' => 'Items',
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
			'inventory.tabs.inventoryItem.loading' => 'Loading inventory...',
			'inventory.tabs.inventoryItem.error' => ({required Object error}) => 'Failed to load inventory: ${error}',
			'inventory.tabs.inventoryItem.emptyTitle' => 'No inventory items',
			'inventory.tabs.inventoryItem.spawn' => 'Spawn',
			'inventory.tabs.inventoryItem.unequip' => 'Unequip',
			'inventory.tabs.inventoryItem.equipped' => ({required Object slot}) => 'Equipped: ${slot}',
			'inventory.tabs.inventoryItem.spawned' => ({required Object name}) => '${name} spawned',
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
			'download.shareFailure' => ({required Object error}) => 'Sharing failed: ${error}',
			'download.sharing' => ({required Object fileName}) => 'Preparing to share ${fileName}...',
			'instance.type.public' => 'Public',
			'instance.type.hidden' => 'Friend+',
			'instance.type.friends' => 'Friends',
			'instance.type.private' => 'Invite+',
			'instance.type.unknown' => 'Unknown',
			_ => null,
		} ?? switch (path) {
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
