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
class TranslationsZhTw with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhTw({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhTw,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-TW>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhTw _root = this; // ignore: unused_field

	@override 
	TranslationsZhTw $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhTw(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsCommonZhTw common = _TranslationsCommonZhTw._(_root);
	@override late final _TranslationsTermsAgreementZhTw termsAgreement = _TranslationsTermsAgreementZhTw._(_root);
	@override late final _TranslationsDrawerZhTw drawer = _TranslationsDrawerZhTw._(_root);
	@override late final _TranslationsLoginZhTw login = _TranslationsLoginZhTw._(_root);
	@override late final _TranslationsFriendsZhTw friends = _TranslationsFriendsZhTw._(_root);
	@override late final _TranslationsFriendDetailZhTw friendDetail = _TranslationsFriendDetailZhTw._(_root);
	@override late final _TranslationsSearchZhTw search = _TranslationsSearchZhTw._(_root);
	@override late final _TranslationsProfileZhTw profile = _TranslationsProfileZhTw._(_root);
	@override late final _TranslationsEngageCardZhTw engageCard = _TranslationsEngageCardZhTw._(_root);
	@override late final _TranslationsQrScannerZhTw qrScanner = _TranslationsQrScannerZhTw._(_root);
	@override late final _TranslationsFavoritesZhTw favorites = _TranslationsFavoritesZhTw._(_root);
	@override late final _TranslationsNotificationsZhTw notifications = _TranslationsNotificationsZhTw._(_root);
	@override late final _TranslationsEventCalendarZhTw eventCalendar = _TranslationsEventCalendarZhTw._(_root);
	@override late final _TranslationsAvatarsZhTw avatars = _TranslationsAvatarsZhTw._(_root);
	@override late final _TranslationsWorldDetailZhTw worldDetail = _TranslationsWorldDetailZhTw._(_root);
	@override late final _TranslationsAvatarDetailZhTw avatarDetail = _TranslationsAvatarDetailZhTw._(_root);
	@override late final _TranslationsGroupsZhTw groups = _TranslationsGroupsZhTw._(_root);
	@override late final _TranslationsGroupDetailZhTw groupDetail = _TranslationsGroupDetailZhTw._(_root);
	@override late final _TranslationsInventoryZhTw inventory = _TranslationsInventoryZhTw._(_root);
	@override late final _TranslationsVrcnsyncZhTw vrcnsync = _TranslationsVrcnsyncZhTw._(_root);
	@override late final _TranslationsFeedbackZhTw feedback = _TranslationsFeedbackZhTw._(_root);
	@override late final _TranslationsSettingsZhTw settings = _TranslationsSettingsZhTw._(_root);
	@override late final _TranslationsCreditsZhTw credits = _TranslationsCreditsZhTw._(_root);
	@override late final _TranslationsDownloadZhTw download = _TranslationsDownloadZhTw._(_root);
	@override late final _TranslationsInstanceZhTw instance = _TranslationsInstanceZhTw._(_root);
	@override late final _TranslationsStatusZhTw status = _TranslationsStatusZhTw._(_root);
	@override late final _TranslationsLocationZhTw location = _TranslationsLocationZhTw._(_root);
	@override late final _TranslationsReminderZhTw reminder = _TranslationsReminderZhTw._(_root);
	@override late final _TranslationsFriendZhTw friend = _TranslationsFriendZhTw._(_root);
	@override late final _TranslationsEventCalendarFilterZhTw eventCalendarFilter = _TranslationsEventCalendarFilterZhTw._(_root);
}

// Path: common
class _TranslationsCommonZhTw implements TranslationsCommonJa {
	_TranslationsCommonZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => 'VRCN';
	@override String get ok => '確定';
	@override String get cancel => '取消';
	@override String get close => '關閉';
	@override String get save => '儲存';
	@override String get edit => '編輯';
	@override String get delete => '刪除';
	@override String get yes => '是';
	@override String get no => '否';
	@override String get loading => '載入中...';
	@override String error({required Object error}) => '發生錯誤：${error}';
	@override String get errorNomessage => '發生錯誤';
	@override String get retry => '重試';
	@override String get search => '搜尋';
	@override String get settings => '設定';
	@override String get confirm => '確認';
	@override String get agree => '同意';
	@override String get decline => '不同意';
	@override String get username => '使用者名稱';
	@override String get password => '密碼';
	@override String get login => '登入';
	@override String get logout => '登出';
	@override String get share => '分享';
}

// Path: termsAgreement
class _TranslationsTermsAgreementZhTw implements TranslationsTermsAgreementJa {
	_TranslationsTermsAgreementZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get welcomeTitle => '歡迎來到 VRCN';
	@override String get welcomeMessage => '在使用本應用程式前\n請先閱讀服務條款與隱私權政策';
	@override String get termsTitle => '服務條款';
	@override String get termsSubtitle => '關於本應用程式的使用條款';
	@override String get privacyTitle => '隱私權政策';
	@override String get privacySubtitle => '關於個人資訊的處理方式';
	@override String agreeTerms({required Object title}) => '同意「${title}」';
	@override String get checkContent => '查看內容';
	@override String get notice => '本應用程式為 VRChat Inc. 的非官方應用程式。\n與 VRChat Inc. 無任何關聯。';
}

// Path: drawer
class _TranslationsDrawerZhTw implements TranslationsDrawerJa {
	_TranslationsDrawerZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get home => '主頁';
	@override String get profile => '個人資料';
	@override String get favorite => '我的最愛';
	@override String get eventCalendar => '活動日曆';
	@override String get avatar => '虛擬化身';
	@override String get group => '群組';
	@override String get inventory => '物品欄';
	@override String get vrcnsync => 'VRCNSync (β)';
	@override String get review => '評價';
	@override String get feedback => '意見回饋';
	@override String get settings => '設定';
	@override String get userLoading => '正在載入使用者資訊...';
	@override String get userError => '獲取使用者資訊失敗';
	@override String get retry => '重試';
	@override late final _TranslationsDrawerSectionZhTw section = _TranslationsDrawerSectionZhTw._(_root);
}

// Path: login
class _TranslationsLoginZhTw implements TranslationsLoginJa {
	_TranslationsLoginZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => '忘記密碼？';
	@override String get createAccount => '註冊';
	@override String get subtitle => '使用您的 VRChat 帳號資訊登入';
	@override String get email => '電子郵件地址';
	@override String get emailHint => '輸入電子郵件或使用者名稱';
	@override String get passwordHint => '輸入密碼';
	@override String get rememberMe => '保持登入狀態';
	@override String get loggingIn => '登入中...';
	@override String get errorEmptyEmail => '請輸入使用者名稱或電子郵件地址';
	@override String get errorEmptyPassword => '請輸入密碼';
	@override String get errorLoginFailed => '登入失敗。請檢查您的電子郵件地址和密碼。';
	@override String get twoFactorTitle => '兩步驟驗證';
	@override String get twoFactorSubtitle => '請輸入驗證碼';
	@override String get twoFactorInstruction => '請輸入驗證應用程式中顯示的\n6 位數驗證碼';
	@override String get twoFactorCodeHint => '驗證碼';
	@override String get verify => '驗證';
	@override String get verifying => '驗證中...';
	@override String get errorEmpty2fa => '請輸入驗證碼';
	@override String get error2faFailed => '兩步驟驗證失敗。請確認驗證碼是否正確。';
	@override String get backToLogin => '返回登入畫面';
	@override String get paste => '貼上';
}

// Path: friends
class _TranslationsFriendsZhTw implements TranslationsFriendsJa {
	_TranslationsFriendsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在載入好友資訊...';
	@override String error({required Object error}) => '獲取好友資訊失敗：${error}';
	@override String get notFound => '找不到好友';
	@override String get private => '私人';
	@override String get active => '在線';
	@override String get offline => '離線';
	@override String get online => '線上';
	@override String get groupTitle => '按世界分組';
	@override String get refresh => '重新整理';
	@override String get searchHint => '按好友名稱搜尋';
	@override String get noResult => '找不到符合的好友';
}

// Path: friendDetail
class _TranslationsFriendDetailZhTw implements TranslationsFriendDetailJa {
	_TranslationsFriendDetailZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在載入使用者資訊...';
	@override String error({required Object error}) => '獲取使用者資訊失敗：${error}';
	@override String get currentLocation => '目前位置';
	@override String get basicInfo => '基本資訊';
	@override String get userId => '使用者ID';
	@override String get dateJoined => '註冊日期';
	@override String get lastLogin => '最後登入';
	@override String get bio => '個人簡介';
	@override String get links => '連結';
	@override String get loadingLinks => '正在載入連結資訊...';
	@override String get group => '所屬群組';
	@override String get groupDetail => '顯示群組詳細資訊';
	@override String groupCode({required Object code}) => '群組代碼：${code}';
	@override String memberCount({required Object count}) => '成員數：${count}人';
	@override String get unknownGroup => '未知的群組';
	@override String get block => '封鎖';
	@override String get mute => '靜音';
	@override String get openWebsite => '在網站上開啟';
	@override String get shareProfile => '分享個人資料';
	@override String confirmBlockTitle({required Object name}) => '要封鎖 ${name} 嗎？';
	@override String get confirmBlockMessage => '封鎖後，您將不會再收到此使用者的好友邀請或訊息。';
	@override String confirmMuteTitle({required Object name}) => '要將 ${name} 靜音嗎？';
	@override String get confirmMuteMessage => '靜音後，您將聽不到此使用者的聲音。';
	@override String get blockSuccess => '已封鎖';
	@override String get muteSuccess => '已靜音';
	@override String operationFailed({required Object error}) => '操作失敗：${error}';
}

// Path: search
class _TranslationsSearchZhTw implements TranslationsSearchJa {
	_TranslationsSearchZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get userTab => '使用者';
	@override String get worldTab => '世界';
	@override String get avatarTab => '虛擬化身';
	@override String get groupTab => '群組';
	@override late final _TranslationsSearchTabsZhTw tabs = _TranslationsSearchTabsZhTw._(_root);
}

// Path: profile
class _TranslationsProfileZhTw implements TranslationsProfileJa {
	_TranslationsProfileZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '個人資料';
	@override String get edit => '編輯';
	@override String get refresh => '重新整理';
	@override String get loading => '正在載入個人資料...';
	@override String get error => '獲取個人資料失敗：{error}';
	@override String get displayName => '顯示名稱';
	@override String get username => '使用者名稱';
	@override String get userId => '使用者ID';
	@override String get engageCard => '互動名片';
	@override String get frined => '好友';
	@override String get dateJoined => '註冊日期';
	@override String get userType => '使用者類型';
	@override String get status => '狀態';
	@override String get statusMessage => '狀態訊息';
	@override String get bio => '個人簡介';
	@override String get links => '連結';
	@override String get group => '所屬群組';
	@override String get groupDetail => '顯示群組詳細資訊';
	@override String get avatar => '目前的虛擬化身';
	@override String get avatarDetail => '顯示虛擬化身詳細資訊';
	@override String get public => '公開';
	@override String get private => '私人';
	@override String get hidden => '隱藏';
	@override String get unknown => '未知';
	@override String get friends => '好友';
	@override String get loadingLinks => '正在載入連結資訊...';
	@override String get noGroup => '沒有所屬群組';
	@override String get noBio => '沒有個人簡介';
	@override String get noLinks => '沒有連結';
	@override String get save => '儲存變更';
	@override String get saved => '個人資料已更新';
	@override String get saveFailed => '更新失敗：{error}';
	@override String get discardTitle => '要捨棄變更嗎？';
	@override String get discardContent => '您對個人資料所做的變更將不會被儲存。';
	@override String get discardCancel => '取消';
	@override String get discardOk => '捨棄';
	@override String get basic => '基本資訊';
	@override String get pronouns => '代名詞';
	@override String get addLink => '新增';
	@override String get removeLink => '移除';
	@override String get linkHint => '輸入連結（例如：https://twitter.com/username）';
	@override String get linksHint => '連結將顯示在您的個人資料上，點擊即可開啟';
	@override String get statusMessageHint => '輸入您目前的狀況或訊息';
	@override String get bioHint => '寫一些關於您自己的事吧';
}

// Path: engageCard
class _TranslationsEngageCardZhTw implements TranslationsEngageCardJa {
	_TranslationsEngageCardZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get pickBackground => '選擇背景圖片';
	@override String get removeBackground => '移除背景圖片';
	@override String get scanQr => '掃描 QR Code';
	@override String get showAvatar => '顯示虛擬化身';
	@override String get hideAvatar => '隱藏虛擬化身';
	@override String get noBackground => '尚未選擇背景圖片\n可從右上角按鈕進行設定';
	@override String get loading => '載入中...';
	@override String error({required Object error}) => '獲取互動名片資訊失敗：${error}';
	@override String get copyUserId => '複製使用者ID';
	@override String get copied => '已複製';
}

// Path: qrScanner
class _TranslationsQrScannerZhTw implements TranslationsQrScannerJa {
	_TranslationsQrScannerZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '掃描 QR Code';
	@override String get guide => '請將 QR Code 對準框內';
	@override String get loading => '正在初始化相機...';
	@override String error({required Object error}) => '讀取 QR Code 失敗：${error}';
	@override String get notFound => '找不到有效的使用者 QR Code';
}

// Path: favorites
class _TranslationsFavoritesZhTw implements TranslationsFavoritesJa {
	_TranslationsFavoritesZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '我的最愛';
	@override String get frined => '好友';
	@override String get friendsTab => '好友';
	@override String get worldsTab => '世界';
	@override String get avatarsTab => '虛擬化身';
	@override String get emptyFolderTitle => '沒有最愛資料夾';
	@override String get emptyFolderDescription => '請在 VRChat 內建立最愛資料夾';
	@override String get emptyFriends => '此資料夾中沒有好友';
	@override String get emptyWorlds => '此資料夾中沒有世界';
	@override String get emptyAvatars => '此資料夾中沒有虛擬化身';
	@override String get emptyWorldsTabTitle => '沒有最愛的世界';
	@override String get emptyWorldsTabDescription => '您可以從世界詳細資訊畫面將世界加入最愛';
	@override String get emptyAvatarsTabTitle => '沒有最愛的虛擬化身';
	@override String get emptyAvatarsTabDescription => '您可以從虛擬化身詳細資訊畫面將其加入最愛';
	@override String get loading => '正在載入最愛項目...';
	@override String get loadingFolder => '正在載入資料夾資訊...';
	@override String error({required Object error}) => '載入最愛項目失敗：${error}';
	@override String get errorFolder => '獲取資訊失敗';
	@override String get remove => '從最愛中移除';
	@override String removeSuccess({required Object name}) => '已將 ${name} 從最愛中移除';
	@override String removeFailed({required Object error}) => '移除失敗：${error}';
	@override String itemsCount({required Object count}) => '${count} 個項目';
	@override String get public => '公開';
	@override String get private => '私人';
	@override String get hidden => '隱藏';
	@override String get unknown => '未知';
	@override String get loadingError => '載入錯誤';
}

// Path: notifications
class _TranslationsNotificationsZhTw implements TranslationsNotificationsJa {
	_TranslationsNotificationsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => '沒有通知';
	@override String get emptyDescription => '好友請求、邀請等\n新通知將會顯示在此處';
	@override String friendRequest({required Object userName}) => '您收到了來自 ${userName} 的好友請求';
	@override String invite({required Object userName, required Object worldName}) => '您收到了 ${userName} 邀請您前往 ${worldName} 的邀請';
	@override String friendOnline({required Object userName}) => '${userName} 已上線';
	@override String friendOffline({required Object userName}) => '${userName} 已離線';
	@override String friendActive({required Object userName}) => '${userName} 變為在線';
	@override String friendAdd({required Object userName}) => '${userName} 已被加為好友';
	@override String friendRemove({required Object userName}) => '${userName} 已被從好友中移除';
	@override String statusUpdate({required Object userName, required Object status, required Object world}) => '${userName} 的狀態已更新：${status}${world}';
	@override String locationChange({required Object userName, required Object worldName}) => '${userName} 已移動至 ${worldName}';
	@override String userUpdate({required Object world}) => '您的資訊已更新${world}';
	@override String myLocationChange({required Object worldName}) => '您的移動：${worldName}';
	@override String requestInvite({required Object userName}) => '您收到了來自 ${userName} 的加入請求';
	@override String votekick({required Object userName}) => '來自 ${userName} 的投票踢除';
	@override String responseReceived({required Object userName}) => '已收到通知ID:${userName}的回應';
	@override String error({required Object worldName}) => '錯誤：${worldName}';
	@override String system({required Object extraData}) => '系統通知：${extraData}';
	@override String secondsAgo({required Object seconds}) => '${seconds}秒前';
	@override String minutesAgo({required Object minutes}) => '${minutes}分鐘前';
	@override String hoursAgo({required Object hours}) => '${hours}小時前';
}

// Path: eventCalendar
class _TranslationsEventCalendarZhTw implements TranslationsEventCalendarJa {
	_TranslationsEventCalendarZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '活動日曆';
	@override String get filter => '篩選活動';
	@override String get refresh => '更新活動資訊';
	@override String get loading => '正在獲取活動資訊...';
	@override String error({required Object error}) => '獲取活動資訊失敗：${error}';
	@override String filterActive({required Object count}) => '篩選條件已啟用（${count}筆）';
	@override String get clear => '清除';
	@override String get noEvents => '沒有符合條件的活動';
	@override String get clearFilter => '清除篩選';
	@override String get today => '今天';
	@override String get reminderSet => '設定提醒';
	@override String get reminderSetDone => '已設定提醒';
	@override String get reminderDeleted => '已刪除提醒';
	@override String get eventName => '活動名稱';
	@override String get organizer => '主辦方';
	@override String get description => '說明';
	@override String get genre => '類型';
	@override String get condition => '參加條件';
	@override String get way => '參加方法';
	@override String get note => '備註';
	@override String get quest => '支援 Quest';
	@override String reminderCount({required Object count}) => '${count}筆';
	@override String startToEnd({required Object start, required Object end}) => '${start}～${end}';
}

// Path: avatars
class _TranslationsAvatarsZhTw implements TranslationsAvatarsJa {
	_TranslationsAvatarsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '虛擬化身';
	@override String get searchHint => '按虛擬化身名稱等搜尋';
	@override String get searchTooltip => '搜尋';
	@override String get searchEmptyTitle => '找不到搜尋結果';
	@override String get searchEmptyDescription => '請嘗試其他搜尋關鍵字';
	@override String get emptyTitle => '沒有虛擬化身';
	@override String get emptyDescription => '請新增虛擬化身或稍後再試';
	@override String get refresh => '重新整理';
	@override String get loading => '正在載入虛擬化身...';
	@override String error({required Object error}) => '獲取虛擬化身資訊失敗：${error}';
	@override String get current => '使用中';
	@override String get public => '公開';
	@override String get private => '私人';
	@override String get hidden => '隱藏';
	@override String get author => '作者';
	@override String get sortUpdated => '按更新時間';
	@override String get sortName => '按名稱';
	@override String get sortTooltip => '排序';
	@override String get viewModeTooltip => '切換顯示模式';
}

// Path: worldDetail
class _TranslationsWorldDetailZhTw implements TranslationsWorldDetailJa {
	_TranslationsWorldDetailZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在載入世界資訊...';
	@override String error({required Object error}) => '獲取世界資訊失敗：${error}';
	@override String get share => '分享這個世界';
	@override String get openInVRChat => '在 VRChat 官網開啟';
	@override String get report => '檢舉這個世界';
	@override String get creator => '建立者';
	@override String get created => '建立時間';
	@override String get updated => '更新時間';
	@override String get favorites => '最愛數';
	@override String get visits => '訪問次數';
	@override String get occupants => '目前人數';
	@override String get popularity => '評價';
	@override String get description => '說明';
	@override String get noDescription => '沒有說明';
	@override String get tags => '標籤';
	@override String get joinPublic => '以公開方式傳送邀請';
	@override String get favoriteAdded => '已加入最愛';
	@override String get favoriteRemoved => '已從最愛中移除';
	@override String get unknown => '未知';
}

// Path: avatarDetail
class _TranslationsAvatarDetailZhTw implements TranslationsAvatarDetailJa {
	_TranslationsAvatarDetailZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String changeSuccess({required Object name}) => '已變更為虛擬化身「${name}」';
	@override String changeFailed({required Object error}) => '變更虛擬化身失敗：${error}';
	@override String get changing => '變更中...';
	@override String get useThisAvatar => '使用此虛擬化身';
	@override String get creator => '建立者';
	@override String get created => '建立時間';
	@override String get updated => '更新時間';
	@override String get description => '說明';
	@override String get noDescription => '沒有說明';
	@override String get tags => '標籤';
	@override String get addToFavorites => '加入最愛';
	@override String get public => '公開';
	@override String get private => '私人';
	@override String get hidden => '隱藏';
	@override String get unknown => '未知';
	@override String get share => '分享';
	@override String get loading => '正在載入虛擬化身資訊...';
	@override String error({required Object error}) => '獲取虛擬化身資訊失敗：${error}';
}

// Path: groups
class _TranslationsGroupsZhTw implements TranslationsGroupsJa {
	_TranslationsGroupsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '群組';
	@override String get loadingUser => '正在載入使用者資訊...';
	@override String errorUser({required Object error}) => '獲取使用者資訊失敗：${error}';
	@override String get loadingGroups => '正在載入群組資訊...';
	@override String errorGroups({required Object error}) => '獲取群組資訊失敗：${error}';
	@override String get emptyTitle => '您尚未加入任何群組';
	@override String get emptyDescription => '您可以從 VRChat 應用程式或網站加入群組';
	@override String get searchGroups => '尋找群組';
	@override String members({required Object count}) => '${count} 位成員';
	@override String get showDetails => '顯示詳細資訊';
	@override String get unknownName => '名稱不明';
}

// Path: groupDetail
class _TranslationsGroupDetailZhTw implements TranslationsGroupDetailJa {
	_TranslationsGroupDetailZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在載入群組資訊...';
	@override String error({required Object error}) => '獲取群組資訊失敗：${error}';
	@override String get share => '分享群組資訊';
	@override String get description => '說明';
	@override String get roles => '角色';
	@override String get basicInfo => '基本資訊';
	@override String get createdAt => '建立日期';
	@override String get owner => '擁有者';
	@override String get rules => '規則';
	@override String get languages => '語言';
	@override String memberCount({required Object count}) => '${count} 位成員';
	@override late final _TranslationsGroupDetailPrivacyZhTw privacy = _TranslationsGroupDetailPrivacyZhTw._(_root);
	@override late final _TranslationsGroupDetailRoleZhTw role = _TranslationsGroupDetailRoleZhTw._(_root);
}

// Path: inventory
class _TranslationsInventoryZhTw implements TranslationsInventoryJa {
	_TranslationsInventoryZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '物品欄';
	@override String get gallery => '圖片庫';
	@override String get icon => '圖示';
	@override String get emoji => '表情符號';
	@override String get sticker => '貼圖';
	@override String get print => '列印圖';
	@override String get upload => '上傳檔案';
	@override String get uploadGallery => '正在上傳圖片庫圖片...';
	@override String get uploadIcon => '正在上傳圖示...';
	@override String get uploadEmoji => '正在上傳表情符號...';
	@override String get uploadSticker => '正在上傳貼圖...';
	@override String get uploadPrint => '正在上傳列印圖...';
	@override String get selectImage => '選擇圖片';
	@override String get selectFromGallery => '從圖片庫選擇';
	@override String get takePhoto => '使用相機拍攝';
	@override String get uploadSuccess => '上傳完成';
	@override String get uploadFailed => '上傳失敗';
	@override String get uploadFailedFormat => '檔案格式或大小有問題。請選擇 PNG 格式且小於 1MB 的圖片。';
	@override String get uploadFailedAuth => '驗證失敗。請重新登入。';
	@override String get uploadFailedSize => '檔案大小過大。請選擇較小的圖片。';
	@override String uploadFailedServer({required Object code}) => '發生伺服器錯誤 (${code})';
	@override String pickImageFailed({required Object error}) => '選擇圖片失敗：${error}';
	@override late final _TranslationsInventoryTabsZhTw tabs = _TranslationsInventoryTabsZhTw._(_root);
}

// Path: vrcnsync
class _TranslationsVrcnsyncZhTw implements TranslationsVrcnsyncJa {
	_TranslationsVrcnsyncZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => 'VRCNSync (β)';
	@override String get betaTitle => 'Beta 版功能';
	@override String get betaDescription => '此功能為開發中的 Beta 版，可能會發生非預期的問題。\n目前僅實作本機版本，若有雲端版需求將會實作。';
	@override String get githubLink => 'VRCNSync 的 GitHub 頁面';
	@override String get openGithub => '開啟 GitHub 頁面';
	@override String get serverRunning => '伺服器執行中';
	@override String get serverStopped => '伺服器已停止';
	@override String get serverRunningDesc => '將來自 PC 的照片儲存到 VRCN 相簿';
	@override String get serverStoppedDesc => '伺服器已停止';
	@override String get photoSaved => '照片已儲存至 VRCN 相簿';
	@override String get photoReceived => '已接收照片（儲存至相簿失敗）';
	@override String get openAlbum => '開啟相簿';
	@override String get permissionErrorIos => '需要存取照片圖庫的權限';
	@override String get permissionErrorAndroid => '需要存取儲存空間的權限';
	@override String get openSettings => '開啟設定';
	@override String initError({required Object error}) => '初始化失敗：${error}';
	@override String get openPhotoAppError => '無法開啟相簿應用程式';
	@override String get serverInfo => '伺服器資訊';
	@override String ip({required Object ip}) => 'IP: ${ip}';
	@override String port({required Object port}) => '連接埠: ${port}';
	@override String address({required Object ip, required Object port}) => '${ip}:${port}';
	@override String get autoSave => '接收到的照片將自動儲存到「VRCN」相簿';
	@override String get usage => '使用方法';
	@override List<dynamic> get usageSteps => [
		_TranslationsVrcnsync$usageSteps$0i0$ZhTw._(_root),
		_TranslationsVrcnsync$usageSteps$0i1$ZhTw._(_root),
		_TranslationsVrcnsync$usageSteps$0i2$ZhTw._(_root),
		_TranslationsVrcnsync$usageSteps$0i3$ZhTw._(_root),
	];
	@override String get stats => '連線狀態';
	@override String get statServer => '伺服器狀態';
	@override String get statServerRunning => '執行中';
	@override String get statServerStopped => '已停止';
	@override String get statNetwork => '網路';
	@override String get statNetworkConnected => '已連線';
	@override String get statNetworkDisconnected => '未連線';
}

// Path: feedback
class _TranslationsFeedbackZhTw implements TranslationsFeedbackJa {
	_TranslationsFeedbackZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '意見回饋';
	@override String get type => '回饋類型';
	@override Map<String, String> get types => {
		'bug': '錯誤回報',
		'feature': '功能請求',
		'improvement': '改善建議',
		'other': '其他',
	};
	@override String get inputTitle => '標題 *';
	@override String get inputTitleHint => '請簡潔地描述';
	@override String get inputDescription => '詳細說明 *';
	@override String get inputDescriptionHint => '請提供詳細說明...';
	@override String get cancel => '取消';
	@override String get send => '傳送';
	@override String get sending => '傳送中...';
	@override String get required => '標題和詳細說明為必填項目';
	@override String get success => '意見回饋已成功傳送，感謝您！';
	@override String get fail => '傳送意見回饋失敗';
}

// Path: settings
class _TranslationsSettingsZhTw implements TranslationsSettingsJa {
	_TranslationsSettingsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get appearance => '外觀';
	@override String get language => '語言';
	@override String get languageDescription => '您可以選擇應用程式的顯示語言';
	@override String get appIcon => '應用程式圖示';
	@override String get appIconDescription => '變更顯示在主畫面的應用程式圖示';
	@override String get contentSettings => '內容設定';
	@override String get searchEnabled => '搜尋功能已啟用';
	@override String get searchDisabled => '搜尋功能已停用';
	@override String get enableSearch => '啟用搜尋功能';
	@override String get enableSearchDescription => '搜尋結果中可能包含色情或暴力內容。';
	@override String get apiSetting => '虛擬化身搜尋 API';
	@override String get apiSettingDescription => '設定虛擬化身搜尋功能的 API';
	@override String get apiSettingSaveUrl => 'URL 已儲存';
	@override String get notSet => '未設定（虛擬化身搜尋功能無法使用）';
	@override String get notifications => '通知設定';
	@override String get eventReminder => '活動提醒';
	@override String get eventReminderDescription => '在設定的活動開始前接收通知';
	@override String get manageReminders => '管理已設定的提醒';
	@override String get manageRemindersDescription => '可以取消或確認通知';
	@override String get dataStorage => '資料與儲存空間';
	@override String get clearCache => '清除快取';
	@override String get clearCacheSuccess => '已清除快取';
	@override String get clearCacheError => '清除快取時發生錯誤';
	@override String cacheSize({required Object size}) => '快取大小：${size}';
	@override String get calculatingCache => '正在計算快取大小...';
	@override String get cacheError => '無法取得快取大小';
	@override String get confirmClearCache => '清除快取將會刪除暫時儲存的圖片和資料。\n\n帳號資訊和應用程式設定不會被刪除。';
	@override String get appInfo => '應用程式資訊';
	@override String get version => '版本';
	@override String get packageName => '套件名稱';
	@override String get credit => '製作群';
	@override String get creditDescription => '開發者與貢獻者資訊';
	@override String get contact => '聯絡我們';
	@override String get contactDescription => '問題回報與意見';
	@override String get privacyPolicy => '隱私權政策';
	@override String get privacyPolicyDescription => '關於個人資訊的處理方式';
	@override String get termsOfService => '服務條款';
	@override String get termsOfServiceDescription => '應用程式的使用條款';
	@override String get openSource => '開源軟體資訊';
	@override String get openSourceDescription => '所使用函式庫等的授權';
	@override String get github => 'GitHub 儲存庫';
	@override String get githubDescription => '查看原始碼';
	@override String get logoutConfirm => '確定要登出嗎？';
	@override String logoutError({required Object error}) => '登出時發生錯誤：${error}';
	@override String get iconChangeNotSupported => '您的裝置不支援變更應用程式圖示';
	@override String get iconChangeFailed => '變更圖示失敗';
	@override String get themeMode => '主題模式';
	@override String get themeModeDescription => '選擇應用程式的顯示主題';
	@override String get themeLight => '淺色';
	@override String get themeSystem => '系統';
	@override String get themeDark => '深色';
	@override String get appIconDefault => '預設';
	@override String get appIconIcon => '圖示';
	@override String get appIconLogo => '標誌';
	@override String get delete => '刪除';
}

// Path: credits
class _TranslationsCreditsZhTw implements TranslationsCreditsJa {
	_TranslationsCreditsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '製作群';
	@override late final _TranslationsCreditsSectionZhTw section = _TranslationsCreditsSectionZhTw._(_root);
}

// Path: download
class _TranslationsDownloadZhTw implements TranslationsDownloadJa {
	_TranslationsDownloadZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get success => '下載完成';
	@override String failure({required Object error}) => '下載失敗：${error}';
	@override String shareFailure({required Object error}) => '分享失敗：${error}';
	@override String get permissionTitle => '需要權限';
	@override String permissionDenied({required Object permissionType}) => '已拒絕存取 ${permissionType} 的權限。\n請從設定應用程式中啟用權限。';
	@override String get permissionCancel => '取消';
	@override String get permissionOpenSettings => '開啟設定';
	@override String get permissionPhoto => '照片';
	@override String get permissionPhotoLibrary => '照片圖庫';
	@override String get permissionStorage => '儲存空間';
	@override String get permissionPhotoRequired => '需要存取照片的權限';
	@override String get permissionPhotoLibraryRequired => '需要存取照片圖庫的權限';
	@override String get permissionStorageRequired => '需要存取儲存空間的權限';
	@override String permissionError({required Object error}) => '檢查權限時發生錯誤：${error}';
	@override String downloading({required Object fileName}) => '正在下載 ${fileName}...';
	@override String sharing({required Object fileName}) => '正在準備分享 ${fileName}...';
}

// Path: instance
class _TranslationsInstanceZhTw implements TranslationsInstanceJa {
	_TranslationsInstanceZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsInstanceTypeZhTw type = _TranslationsInstanceTypeZhTw._(_root);
}

// Path: status
class _TranslationsStatusZhTw implements TranslationsStatusJa {
	_TranslationsStatusZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get active => '線上';
	@override String get joinMe => '歡迎加入';
	@override String get askMe => '歡迎詢問';
	@override String get busy => '忙碌中';
	@override String get offline => '離線';
	@override String get unknown => '狀態不明';
}

// Path: location
class _TranslationsLocationZhTw implements TranslationsLocationJa {
	_TranslationsLocationZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get private => '私人';
	@override String playerCount({required Object userCount, required Object capacity}) => '玩家數：${userCount} / ${capacity}';
	@override String instanceType({required Object type}) => '房間類型：${type}';
	@override String get noInfo => '沒有位置資訊';
	@override String get fetchError => '獲取位置資訊失敗';
	@override String get privateLocation => '正在私人場所';
	@override String get inviteSending => '正在傳送邀請...';
	@override String get inviteSent => '已傳送邀請。您可以從通知加入';
	@override String inviteFailed({required Object error}) => '傳送邀請失敗：${error}';
	@override String get inviteButton => '向自己傳送邀請';
	@override String isPrivate({required Object number}) => '${number}人私密';
	@override String isActive({required Object number}) => '${number}人線上';
	@override String isOffline({required Object number}) => '${number}人離線';
	@override String isTraveling({required Object number}) => '${number}人移動中';
	@override String isStaying({required Object number}) => '${number}人停留中';
}

// Path: reminder
class _TranslationsReminderZhTw implements TranslationsReminderJa {
	_TranslationsReminderZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => '設定提醒';
	@override String get alreadySet => '已設定';
	@override String get set => '設定';
	@override String get cancel => '取消';
	@override String get delete => '刪除';
	@override String get deleteAll => '刪除所有提醒';
	@override String get deleteAllConfirm => '您確定要刪除所有已設定的活動提醒嗎？此操作無法復原。';
	@override String get deleted => '已刪除提醒';
	@override String get deletedAll => '已刪除所有提醒';
	@override String get noReminders => '沒有已設定的提醒';
	@override String get setFromEvent => '您可以從活動頁面設定通知';
	@override String eventStart({required Object time}) => '${time} 開始';
	@override String notifyAt({required Object time, required Object label}) => '${time} (${label})';
	@override String get receiveNotification => '您想在何時收到通知？';
}

// Path: friend
class _TranslationsFriendZhTw implements TranslationsFriendJa {
	_TranslationsFriendZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get sortFilter => '排序與篩選';
	@override String get filter => '篩選';
	@override String get filterAll => '顯示全部';
	@override String get filterOnline => '僅線上';
	@override String get filterOffline => '僅離線';
	@override String get filterFavorite => '僅最愛';
	@override String get sort => '排序';
	@override String get sortStatus => '按上線狀態';
	@override String get sortName => '按名稱';
	@override String get sortLastLogin => '按最後登入時間';
	@override String get sortAsc => '遞增';
	@override String get sortDesc => '遞減';
	@override String get close => '關閉';
}

// Path: eventCalendarFilter
class _TranslationsEventCalendarFilterZhTw implements TranslationsEventCalendarFilterJa {
	_TranslationsEventCalendarFilterZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get filterTitle => '篩選活動';
	@override String get clear => '清除';
	@override String get keyword => '關鍵字搜尋';
	@override String get keywordHint => '活動名稱、說明、主辦方等';
	@override String get date => '按日期篩選';
	@override String get dateHint => '可顯示特定日期範圍的活動';
	@override String get startDate => '開始日期';
	@override String get endDate => '結束日期';
	@override String get select => '請選擇';
	@override String get time => '按時段篩選';
	@override String get timeHint => '可顯示在特定時段舉行的活動';
	@override String get startTime => '開始時間';
	@override String get endTime => '結束時間';
	@override String get genre => '按類型篩選';
	@override String genreSelected({required Object count}) => '已選擇 ${count} 個類型';
	@override String get apply => '套用';
	@override String get filterSummary => '篩選條件';
	@override String get filterNone => '未設定篩選條件';
}

// Path: drawer.section
class _TranslationsDrawerSectionZhTw implements TranslationsDrawerSectionJa {
	_TranslationsDrawerSectionZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get content => '內容';
	@override String get other => '其他';
}

// Path: search.tabs
class _TranslationsSearchTabsZhTw implements TranslationsSearchTabsJa {
	_TranslationsSearchTabsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSearchTabsUserSearchZhTw userSearch = _TranslationsSearchTabsUserSearchZhTw._(_root);
	@override late final _TranslationsSearchTabsWorldSearchZhTw worldSearch = _TranslationsSearchTabsWorldSearchZhTw._(_root);
	@override late final _TranslationsSearchTabsGroupSearchZhTw groupSearch = _TranslationsSearchTabsGroupSearchZhTw._(_root);
	@override late final _TranslationsSearchTabsAvatarSearchZhTw avatarSearch = _TranslationsSearchTabsAvatarSearchZhTw._(_root);
}

// Path: groupDetail.privacy
class _TranslationsGroupDetailPrivacyZhTw implements TranslationsGroupDetailPrivacyJa {
	_TranslationsGroupDetailPrivacyZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get public => '公開';
	@override String get private => '私人';
	@override String get friends => '好友';
	@override String get invite => '邀請制';
	@override String get unknown => '未知';
}

// Path: groupDetail.role
class _TranslationsGroupDetailRoleZhTw implements TranslationsGroupDetailRoleJa {
	_TranslationsGroupDetailRoleZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get admin => '管理員';
	@override String get moderator => '版主';
	@override String get member => '成員';
	@override String get unknown => '未知';
}

// Path: inventory.tabs
class _TranslationsInventoryTabsZhTw implements TranslationsInventoryTabsJa {
	_TranslationsInventoryTabsZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsInventoryTabsEmojiInventoryZhTw emojiInventory = _TranslationsInventoryTabsEmojiInventoryZhTw._(_root);
	@override late final _TranslationsInventoryTabsGalleryInventoryZhTw galleryInventory = _TranslationsInventoryTabsGalleryInventoryZhTw._(_root);
	@override late final _TranslationsInventoryTabsIconInventoryZhTw iconInventory = _TranslationsInventoryTabsIconInventoryZhTw._(_root);
	@override late final _TranslationsInventoryTabsPrintInventoryZhTw printInventory = _TranslationsInventoryTabsPrintInventoryZhTw._(_root);
	@override late final _TranslationsInventoryTabsStickerInventoryZhTw stickerInventory = _TranslationsInventoryTabsStickerInventoryZhTw._(_root);
}

// Path: vrcnsync.usageSteps.0
class _TranslationsVrcnsync$usageSteps$0i0$ZhTw implements TranslationsVrcnsync$usageSteps$0i0$Ja {
	_TranslationsVrcnsync$usageSteps$0i0$ZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '在 PC 上啟動 VRCNSync 應用程式';
	@override String get desc => '請在您的 PC 上啟動 VRCNSync 應用程式';
}

// Path: vrcnsync.usageSteps.1
class _TranslationsVrcnsync$usageSteps$0i1$ZhTw implements TranslationsVrcnsync$usageSteps$0i1$Ja {
	_TranslationsVrcnsync$usageSteps$0i1$ZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '連接到相同的 WiFi 網路';
	@override String get desc => '請將您的 PC 和行動裝置連接到相同的 WiFi 網路';
}

// Path: vrcnsync.usageSteps.2
class _TranslationsVrcnsync$usageSteps$0i2$ZhTw implements TranslationsVrcnsync$usageSteps$0i2$Ja {
	_TranslationsVrcnsync$usageSteps$0i2$ZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '指定行動裝置為連線目標';
	@override String get desc => '請在 PC 應用程式中指定上述的 IP 位址和連接埠';
}

// Path: vrcnsync.usageSteps.3
class _TranslationsVrcnsync$usageSteps$0i3$ZhTw implements TranslationsVrcnsync$usageSteps$0i3$Ja {
	_TranslationsVrcnsync$usageSteps$0i3$ZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '傳送照片';
	@override String get desc => '從 PC 傳送照片後，將自動儲存到 VRCN 相簿';
}

// Path: credits.section
class _TranslationsCreditsSectionZhTw implements TranslationsCreditsSectionJa {
	_TranslationsCreditsSectionZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get development => '開發';
	@override String get iconPeople => '有趣的圖示貢獻者們';
	@override String get testFeedback => '測試與意見回饋';
	@override String get specialThanks => '特別感謝';
}

// Path: instance.type
class _TranslationsInstanceTypeZhTw implements TranslationsInstanceTypeJa {
	_TranslationsInstanceTypeZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get public => '公開';
	@override String get hidden => '好友+';
	@override String get friends => '好友';
	@override String get private => '邀請+';
	@override String get unknown => '未知';
}

// Path: search.tabs.userSearch
class _TranslationsSearchTabsUserSearchZhTw implements TranslationsSearchTabsUserSearchJa {
	_TranslationsSearchTabsUserSearchZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => '搜尋使用者';
	@override String get emptyDescription => '您可以使用使用者名稱或ID進行搜尋';
	@override String get searching => '搜尋中...';
	@override String get noResults => '找不到符合的使用者';
	@override String error({required Object error}) => '搜尋使用者時發生錯誤：${error}';
	@override String get inputPlaceholder => '輸入使用者名稱或ID';
}

// Path: search.tabs.worldSearch
class _TranslationsSearchTabsWorldSearchZhTw implements TranslationsSearchTabsWorldSearchJa {
	_TranslationsSearchTabsWorldSearchZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => '探索世界';
	@override String get emptyDescription => '請輸入關鍵字進行搜尋';
	@override String get searching => '搜尋中...';
	@override String get noResults => '找不到符合的世界';
	@override String noResultsWithQuery({required Object query}) => '找不到與「${query}」相符的世界';
	@override String get noResultsHint => '試試更換搜尋關鍵字吧';
	@override String error({required Object error}) => '搜尋世界時發生錯誤：${error}';
	@override String resultCount({required Object count}) => '找到了 ${count} 個世界';
	@override String authorPrefix({required Object authorName}) => '作者 ${authorName}';
	@override String get listView => '列表視圖';
	@override String get gridView => '網格視圖';
}

// Path: search.tabs.groupSearch
class _TranslationsSearchTabsGroupSearchZhTw implements TranslationsSearchTabsGroupSearchJa {
	_TranslationsSearchTabsGroupSearchZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => '搜尋群組';
	@override String get emptyDescription => '請輸入關鍵字進行搜尋';
	@override String get searching => '搜尋中...';
	@override String get noResults => '找不到符合的群組';
	@override String noResultsWithQuery({required Object query}) => '找不到與「${query}」相符的群組';
	@override String get noResultsHint => '試試更換搜尋關鍵字吧';
	@override String error({required Object error}) => '搜尋群組時發生錯誤：${error}';
	@override String resultCount({required Object count}) => '找到了 ${count} 個群組';
	@override String get listView => '列表視圖';
	@override String get gridView => '網格視圖';
	@override String memberCount({required Object count}) => '${count} 位成員';
}

// Path: search.tabs.avatarSearch
class _TranslationsSearchTabsAvatarSearchZhTw implements TranslationsSearchTabsAvatarSearchJa {
	_TranslationsSearchTabsAvatarSearchZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get avatar => '虛擬化身';
	@override String get emptyTitle => '搜尋虛擬化身';
	@override String get emptyDescription => '請輸入關鍵字進行搜尋';
	@override String get searching => '正在搜尋虛擬化身...';
	@override String get noResults => '找不到搜尋結果';
	@override String get noResultsHint => '試試用其他關鍵字搜尋';
	@override String error({required Object error}) => '搜尋虛擬化身時發生錯誤：${error}';
}

// Path: inventory.tabs.emojiInventory
class _TranslationsInventoryTabsEmojiInventoryZhTw implements TranslationsInventoryTabsEmojiInventoryJa {
	_TranslationsInventoryTabsEmojiInventoryZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在載入表情符號...';
	@override String error({required Object error}) => '獲取表情符號失敗：${error}';
	@override String get emptyTitle => '沒有表情符號';
	@override String get emptyDescription => '在 VRChat 上傳的表情符號會顯示在這裡';
	@override String get zoomHint => '雙擊放大';
}

// Path: inventory.tabs.galleryInventory
class _TranslationsInventoryTabsGalleryInventoryZhTw implements TranslationsInventoryTabsGalleryInventoryJa {
	_TranslationsInventoryTabsGalleryInventoryZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在載入圖片庫...';
	@override String error({required Object error}) => '獲取圖片庫失敗：${error}';
	@override String get emptyTitle => '沒有圖片庫';
	@override String get emptyDescription => '在 VRChat 上傳的圖片庫會顯示在這裡';
	@override String get zoomHint => '雙擊放大';
}

// Path: inventory.tabs.iconInventory
class _TranslationsInventoryTabsIconInventoryZhTw implements TranslationsInventoryTabsIconInventoryJa {
	_TranslationsInventoryTabsIconInventoryZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在載入圖示...';
	@override String error({required Object error}) => '獲取圖示失敗：${error}';
	@override String get emptyTitle => '沒有圖示';
	@override String get emptyDescription => '在 VRChat 上傳的圖示會顯示在這裡';
	@override String get zoomHint => '雙擊放大';
}

// Path: inventory.tabs.printInventory
class _TranslationsInventoryTabsPrintInventoryZhTw implements TranslationsInventoryTabsPrintInventoryJa {
	_TranslationsInventoryTabsPrintInventoryZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在載入列印圖...';
	@override String error({required Object error}) => '獲取列印圖失敗：${error}';
	@override String get emptyTitle => '沒有列印圖';
	@override String get emptyDescription => '在 VRChat 上傳的列印圖會顯示在這裡';
	@override String get zoomHint => '雙擊放大';
}

// Path: inventory.tabs.stickerInventory
class _TranslationsInventoryTabsStickerInventoryZhTw implements TranslationsInventoryTabsStickerInventoryJa {
	_TranslationsInventoryTabsStickerInventoryZhTw._(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get loading => '正在載入貼圖...';
	@override String error({required Object error}) => '獲取貼圖失敗：${error}';
	@override String get emptyTitle => '沒有貼圖';
	@override String get emptyDescription => '在 VRChat 上傳的貼圖會顯示在這裡';
	@override String get zoomHint => '雙擊放大';
}

/// The flat map containing all translations for locale <zh-TW>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhTw {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.title' => 'VRCN',
			'common.ok' => '確定',
			'common.cancel' => '取消',
			'common.close' => '關閉',
			'common.save' => '儲存',
			'common.edit' => '編輯',
			'common.delete' => '刪除',
			'common.yes' => '是',
			'common.no' => '否',
			'common.loading' => '載入中...',
			'common.error' => ({required Object error}) => '發生錯誤：${error}',
			'common.errorNomessage' => '發生錯誤',
			'common.retry' => '重試',
			'common.search' => '搜尋',
			'common.settings' => '設定',
			'common.confirm' => '確認',
			'common.agree' => '同意',
			'common.decline' => '不同意',
			'common.username' => '使用者名稱',
			'common.password' => '密碼',
			'common.login' => '登入',
			'common.logout' => '登出',
			'common.share' => '分享',
			'termsAgreement.welcomeTitle' => '歡迎來到 VRCN',
			'termsAgreement.welcomeMessage' => '在使用本應用程式前\n請先閱讀服務條款與隱私權政策',
			'termsAgreement.termsTitle' => '服務條款',
			'termsAgreement.termsSubtitle' => '關於本應用程式的使用條款',
			'termsAgreement.privacyTitle' => '隱私權政策',
			'termsAgreement.privacySubtitle' => '關於個人資訊的處理方式',
			'termsAgreement.agreeTerms' => ({required Object title}) => '同意「${title}」',
			'termsAgreement.checkContent' => '查看內容',
			'termsAgreement.notice' => '本應用程式為 VRChat Inc. 的非官方應用程式。\n與 VRChat Inc. 無任何關聯。',
			'drawer.home' => '主頁',
			'drawer.profile' => '個人資料',
			'drawer.favorite' => '我的最愛',
			'drawer.eventCalendar' => '活動日曆',
			'drawer.avatar' => '虛擬化身',
			'drawer.group' => '群組',
			'drawer.inventory' => '物品欄',
			'drawer.vrcnsync' => 'VRCNSync (β)',
			'drawer.review' => '評價',
			'drawer.feedback' => '意見回饋',
			'drawer.settings' => '設定',
			'drawer.userLoading' => '正在載入使用者資訊...',
			'drawer.userError' => '獲取使用者資訊失敗',
			'drawer.retry' => '重試',
			'drawer.section.content' => '內容',
			'drawer.section.other' => '其他',
			'login.forgotPassword' => '忘記密碼？',
			'login.createAccount' => '註冊',
			'login.subtitle' => '使用您的 VRChat 帳號資訊登入',
			'login.email' => '電子郵件地址',
			'login.emailHint' => '輸入電子郵件或使用者名稱',
			'login.passwordHint' => '輸入密碼',
			'login.rememberMe' => '保持登入狀態',
			'login.loggingIn' => '登入中...',
			'login.errorEmptyEmail' => '請輸入使用者名稱或電子郵件地址',
			'login.errorEmptyPassword' => '請輸入密碼',
			'login.errorLoginFailed' => '登入失敗。請檢查您的電子郵件地址和密碼。',
			'login.twoFactorTitle' => '兩步驟驗證',
			'login.twoFactorSubtitle' => '請輸入驗證碼',
			'login.twoFactorInstruction' => '請輸入驗證應用程式中顯示的\n6 位數驗證碼',
			'login.twoFactorCodeHint' => '驗證碼',
			'login.verify' => '驗證',
			'login.verifying' => '驗證中...',
			'login.errorEmpty2fa' => '請輸入驗證碼',
			'login.error2faFailed' => '兩步驟驗證失敗。請確認驗證碼是否正確。',
			'login.backToLogin' => '返回登入畫面',
			'login.paste' => '貼上',
			'friends.loading' => '正在載入好友資訊...',
			'friends.error' => ({required Object error}) => '獲取好友資訊失敗：${error}',
			'friends.notFound' => '找不到好友',
			'friends.private' => '私人',
			'friends.active' => '在線',
			'friends.offline' => '離線',
			'friends.online' => '線上',
			'friends.groupTitle' => '按世界分組',
			'friends.refresh' => '重新整理',
			'friends.searchHint' => '按好友名稱搜尋',
			'friends.noResult' => '找不到符合的好友',
			'friendDetail.loading' => '正在載入使用者資訊...',
			'friendDetail.error' => ({required Object error}) => '獲取使用者資訊失敗：${error}',
			'friendDetail.currentLocation' => '目前位置',
			'friendDetail.basicInfo' => '基本資訊',
			'friendDetail.userId' => '使用者ID',
			'friendDetail.dateJoined' => '註冊日期',
			'friendDetail.lastLogin' => '最後登入',
			'friendDetail.bio' => '個人簡介',
			'friendDetail.links' => '連結',
			'friendDetail.loadingLinks' => '正在載入連結資訊...',
			'friendDetail.group' => '所屬群組',
			'friendDetail.groupDetail' => '顯示群組詳細資訊',
			'friendDetail.groupCode' => ({required Object code}) => '群組代碼：${code}',
			'friendDetail.memberCount' => ({required Object count}) => '成員數：${count}人',
			'friendDetail.unknownGroup' => '未知的群組',
			'friendDetail.block' => '封鎖',
			'friendDetail.mute' => '靜音',
			'friendDetail.openWebsite' => '在網站上開啟',
			'friendDetail.shareProfile' => '分享個人資料',
			'friendDetail.confirmBlockTitle' => ({required Object name}) => '要封鎖 ${name} 嗎？',
			'friendDetail.confirmBlockMessage' => '封鎖後，您將不會再收到此使用者的好友邀請或訊息。',
			'friendDetail.confirmMuteTitle' => ({required Object name}) => '要將 ${name} 靜音嗎？',
			'friendDetail.confirmMuteMessage' => '靜音後，您將聽不到此使用者的聲音。',
			'friendDetail.blockSuccess' => '已封鎖',
			'friendDetail.muteSuccess' => '已靜音',
			'friendDetail.operationFailed' => ({required Object error}) => '操作失敗：${error}',
			'search.userTab' => '使用者',
			'search.worldTab' => '世界',
			'search.avatarTab' => '虛擬化身',
			'search.groupTab' => '群組',
			'search.tabs.userSearch.emptyTitle' => '搜尋使用者',
			'search.tabs.userSearch.emptyDescription' => '您可以使用使用者名稱或ID進行搜尋',
			'search.tabs.userSearch.searching' => '搜尋中...',
			'search.tabs.userSearch.noResults' => '找不到符合的使用者',
			'search.tabs.userSearch.error' => ({required Object error}) => '搜尋使用者時發生錯誤：${error}',
			'search.tabs.userSearch.inputPlaceholder' => '輸入使用者名稱或ID',
			'search.tabs.worldSearch.emptyTitle' => '探索世界',
			'search.tabs.worldSearch.emptyDescription' => '請輸入關鍵字進行搜尋',
			'search.tabs.worldSearch.searching' => '搜尋中...',
			'search.tabs.worldSearch.noResults' => '找不到符合的世界',
			'search.tabs.worldSearch.noResultsWithQuery' => ({required Object query}) => '找不到與「${query}」相符的世界',
			'search.tabs.worldSearch.noResultsHint' => '試試更換搜尋關鍵字吧',
			'search.tabs.worldSearch.error' => ({required Object error}) => '搜尋世界時發生錯誤：${error}',
			'search.tabs.worldSearch.resultCount' => ({required Object count}) => '找到了 ${count} 個世界',
			'search.tabs.worldSearch.authorPrefix' => ({required Object authorName}) => '作者 ${authorName}',
			'search.tabs.worldSearch.listView' => '列表視圖',
			'search.tabs.worldSearch.gridView' => '網格視圖',
			'search.tabs.groupSearch.emptyTitle' => '搜尋群組',
			'search.tabs.groupSearch.emptyDescription' => '請輸入關鍵字進行搜尋',
			'search.tabs.groupSearch.searching' => '搜尋中...',
			'search.tabs.groupSearch.noResults' => '找不到符合的群組',
			'search.tabs.groupSearch.noResultsWithQuery' => ({required Object query}) => '找不到與「${query}」相符的群組',
			'search.tabs.groupSearch.noResultsHint' => '試試更換搜尋關鍵字吧',
			'search.tabs.groupSearch.error' => ({required Object error}) => '搜尋群組時發生錯誤：${error}',
			'search.tabs.groupSearch.resultCount' => ({required Object count}) => '找到了 ${count} 個群組',
			'search.tabs.groupSearch.listView' => '列表視圖',
			'search.tabs.groupSearch.gridView' => '網格視圖',
			'search.tabs.groupSearch.memberCount' => ({required Object count}) => '${count} 位成員',
			'search.tabs.avatarSearch.avatar' => '虛擬化身',
			'search.tabs.avatarSearch.emptyTitle' => '搜尋虛擬化身',
			'search.tabs.avatarSearch.emptyDescription' => '請輸入關鍵字進行搜尋',
			'search.tabs.avatarSearch.searching' => '正在搜尋虛擬化身...',
			'search.tabs.avatarSearch.noResults' => '找不到搜尋結果',
			'search.tabs.avatarSearch.noResultsHint' => '試試用其他關鍵字搜尋',
			'search.tabs.avatarSearch.error' => ({required Object error}) => '搜尋虛擬化身時發生錯誤：${error}',
			'profile.title' => '個人資料',
			'profile.edit' => '編輯',
			'profile.refresh' => '重新整理',
			'profile.loading' => '正在載入個人資料...',
			'profile.error' => '獲取個人資料失敗：{error}',
			'profile.displayName' => '顯示名稱',
			'profile.username' => '使用者名稱',
			'profile.userId' => '使用者ID',
			'profile.engageCard' => '互動名片',
			'profile.frined' => '好友',
			'profile.dateJoined' => '註冊日期',
			'profile.userType' => '使用者類型',
			'profile.status' => '狀態',
			'profile.statusMessage' => '狀態訊息',
			'profile.bio' => '個人簡介',
			'profile.links' => '連結',
			'profile.group' => '所屬群組',
			'profile.groupDetail' => '顯示群組詳細資訊',
			'profile.avatar' => '目前的虛擬化身',
			'profile.avatarDetail' => '顯示虛擬化身詳細資訊',
			'profile.public' => '公開',
			'profile.private' => '私人',
			'profile.hidden' => '隱藏',
			'profile.unknown' => '未知',
			'profile.friends' => '好友',
			'profile.loadingLinks' => '正在載入連結資訊...',
			'profile.noGroup' => '沒有所屬群組',
			'profile.noBio' => '沒有個人簡介',
			'profile.noLinks' => '沒有連結',
			'profile.save' => '儲存變更',
			'profile.saved' => '個人資料已更新',
			'profile.saveFailed' => '更新失敗：{error}',
			'profile.discardTitle' => '要捨棄變更嗎？',
			'profile.discardContent' => '您對個人資料所做的變更將不會被儲存。',
			'profile.discardCancel' => '取消',
			'profile.discardOk' => '捨棄',
			'profile.basic' => '基本資訊',
			'profile.pronouns' => '代名詞',
			'profile.addLink' => '新增',
			'profile.removeLink' => '移除',
			'profile.linkHint' => '輸入連結（例如：https://twitter.com/username）',
			'profile.linksHint' => '連結將顯示在您的個人資料上，點擊即可開啟',
			'profile.statusMessageHint' => '輸入您目前的狀況或訊息',
			'profile.bioHint' => '寫一些關於您自己的事吧',
			'engageCard.pickBackground' => '選擇背景圖片',
			'engageCard.removeBackground' => '移除背景圖片',
			'engageCard.scanQr' => '掃描 QR Code',
			'engageCard.showAvatar' => '顯示虛擬化身',
			'engageCard.hideAvatar' => '隱藏虛擬化身',
			'engageCard.noBackground' => '尚未選擇背景圖片\n可從右上角按鈕進行設定',
			'engageCard.loading' => '載入中...',
			'engageCard.error' => ({required Object error}) => '獲取互動名片資訊失敗：${error}',
			'engageCard.copyUserId' => '複製使用者ID',
			'engageCard.copied' => '已複製',
			'qrScanner.title' => '掃描 QR Code',
			'qrScanner.guide' => '請將 QR Code 對準框內',
			'qrScanner.loading' => '正在初始化相機...',
			'qrScanner.error' => ({required Object error}) => '讀取 QR Code 失敗：${error}',
			'qrScanner.notFound' => '找不到有效的使用者 QR Code',
			'favorites.title' => '我的最愛',
			'favorites.frined' => '好友',
			'favorites.friendsTab' => '好友',
			'favorites.worldsTab' => '世界',
			'favorites.avatarsTab' => '虛擬化身',
			'favorites.emptyFolderTitle' => '沒有最愛資料夾',
			'favorites.emptyFolderDescription' => '請在 VRChat 內建立最愛資料夾',
			'favorites.emptyFriends' => '此資料夾中沒有好友',
			'favorites.emptyWorlds' => '此資料夾中沒有世界',
			'favorites.emptyAvatars' => '此資料夾中沒有虛擬化身',
			'favorites.emptyWorldsTabTitle' => '沒有最愛的世界',
			'favorites.emptyWorldsTabDescription' => '您可以從世界詳細資訊畫面將世界加入最愛',
			'favorites.emptyAvatarsTabTitle' => '沒有最愛的虛擬化身',
			'favorites.emptyAvatarsTabDescription' => '您可以從虛擬化身詳細資訊畫面將其加入最愛',
			'favorites.loading' => '正在載入最愛項目...',
			'favorites.loadingFolder' => '正在載入資料夾資訊...',
			'favorites.error' => ({required Object error}) => '載入最愛項目失敗：${error}',
			'favorites.errorFolder' => '獲取資訊失敗',
			'favorites.remove' => '從最愛中移除',
			'favorites.removeSuccess' => ({required Object name}) => '已將 ${name} 從最愛中移除',
			'favorites.removeFailed' => ({required Object error}) => '移除失敗：${error}',
			'favorites.itemsCount' => ({required Object count}) => '${count} 個項目',
			'favorites.public' => '公開',
			'favorites.private' => '私人',
			'favorites.hidden' => '隱藏',
			'favorites.unknown' => '未知',
			'favorites.loadingError' => '載入錯誤',
			'notifications.emptyTitle' => '沒有通知',
			'notifications.emptyDescription' => '好友請求、邀請等\n新通知將會顯示在此處',
			'notifications.friendRequest' => ({required Object userName}) => '您收到了來自 ${userName} 的好友請求',
			'notifications.invite' => ({required Object userName, required Object worldName}) => '您收到了 ${userName} 邀請您前往 ${worldName} 的邀請',
			'notifications.friendOnline' => ({required Object userName}) => '${userName} 已上線',
			'notifications.friendOffline' => ({required Object userName}) => '${userName} 已離線',
			'notifications.friendActive' => ({required Object userName}) => '${userName} 變為在線',
			'notifications.friendAdd' => ({required Object userName}) => '${userName} 已被加為好友',
			'notifications.friendRemove' => ({required Object userName}) => '${userName} 已被從好友中移除',
			'notifications.statusUpdate' => ({required Object userName, required Object status, required Object world}) => '${userName} 的狀態已更新：${status}${world}',
			'notifications.locationChange' => ({required Object userName, required Object worldName}) => '${userName} 已移動至 ${worldName}',
			'notifications.userUpdate' => ({required Object world}) => '您的資訊已更新${world}',
			'notifications.myLocationChange' => ({required Object worldName}) => '您的移動：${worldName}',
			'notifications.requestInvite' => ({required Object userName}) => '您收到了來自 ${userName} 的加入請求',
			'notifications.votekick' => ({required Object userName}) => '來自 ${userName} 的投票踢除',
			'notifications.responseReceived' => ({required Object userName}) => '已收到通知ID:${userName}的回應',
			'notifications.error' => ({required Object worldName}) => '錯誤：${worldName}',
			'notifications.system' => ({required Object extraData}) => '系統通知：${extraData}',
			'notifications.secondsAgo' => ({required Object seconds}) => '${seconds}秒前',
			'notifications.minutesAgo' => ({required Object minutes}) => '${minutes}分鐘前',
			'notifications.hoursAgo' => ({required Object hours}) => '${hours}小時前',
			'eventCalendar.title' => '活動日曆',
			'eventCalendar.filter' => '篩選活動',
			'eventCalendar.refresh' => '更新活動資訊',
			'eventCalendar.loading' => '正在獲取活動資訊...',
			'eventCalendar.error' => ({required Object error}) => '獲取活動資訊失敗：${error}',
			'eventCalendar.filterActive' => ({required Object count}) => '篩選條件已啟用（${count}筆）',
			'eventCalendar.clear' => '清除',
			'eventCalendar.noEvents' => '沒有符合條件的活動',
			'eventCalendar.clearFilter' => '清除篩選',
			'eventCalendar.today' => '今天',
			'eventCalendar.reminderSet' => '設定提醒',
			'eventCalendar.reminderSetDone' => '已設定提醒',
			'eventCalendar.reminderDeleted' => '已刪除提醒',
			'eventCalendar.eventName' => '活動名稱',
			'eventCalendar.organizer' => '主辦方',
			'eventCalendar.description' => '說明',
			'eventCalendar.genre' => '類型',
			'eventCalendar.condition' => '參加條件',
			'eventCalendar.way' => '參加方法',
			'eventCalendar.note' => '備註',
			'eventCalendar.quest' => '支援 Quest',
			'eventCalendar.reminderCount' => ({required Object count}) => '${count}筆',
			'eventCalendar.startToEnd' => ({required Object start, required Object end}) => '${start}～${end}',
			'avatars.title' => '虛擬化身',
			'avatars.searchHint' => '按虛擬化身名稱等搜尋',
			'avatars.searchTooltip' => '搜尋',
			'avatars.searchEmptyTitle' => '找不到搜尋結果',
			'avatars.searchEmptyDescription' => '請嘗試其他搜尋關鍵字',
			'avatars.emptyTitle' => '沒有虛擬化身',
			'avatars.emptyDescription' => '請新增虛擬化身或稍後再試',
			'avatars.refresh' => '重新整理',
			'avatars.loading' => '正在載入虛擬化身...',
			'avatars.error' => ({required Object error}) => '獲取虛擬化身資訊失敗：${error}',
			'avatars.current' => '使用中',
			'avatars.public' => '公開',
			'avatars.private' => '私人',
			'avatars.hidden' => '隱藏',
			'avatars.author' => '作者',
			'avatars.sortUpdated' => '按更新時間',
			'avatars.sortName' => '按名稱',
			'avatars.sortTooltip' => '排序',
			'avatars.viewModeTooltip' => '切換顯示模式',
			'worldDetail.loading' => '正在載入世界資訊...',
			'worldDetail.error' => ({required Object error}) => '獲取世界資訊失敗：${error}',
			'worldDetail.share' => '分享這個世界',
			'worldDetail.openInVRChat' => '在 VRChat 官網開啟',
			'worldDetail.report' => '檢舉這個世界',
			'worldDetail.creator' => '建立者',
			'worldDetail.created' => '建立時間',
			'worldDetail.updated' => '更新時間',
			'worldDetail.favorites' => '最愛數',
			'worldDetail.visits' => '訪問次數',
			'worldDetail.occupants' => '目前人數',
			'worldDetail.popularity' => '評價',
			'worldDetail.description' => '說明',
			'worldDetail.noDescription' => '沒有說明',
			'worldDetail.tags' => '標籤',
			'worldDetail.joinPublic' => '以公開方式傳送邀請',
			'worldDetail.favoriteAdded' => '已加入最愛',
			'worldDetail.favoriteRemoved' => '已從最愛中移除',
			'worldDetail.unknown' => '未知',
			'avatarDetail.changeSuccess' => ({required Object name}) => '已變更為虛擬化身「${name}」',
			'avatarDetail.changeFailed' => ({required Object error}) => '變更虛擬化身失敗：${error}',
			'avatarDetail.changing' => '變更中...',
			'avatarDetail.useThisAvatar' => '使用此虛擬化身',
			'avatarDetail.creator' => '建立者',
			'avatarDetail.created' => '建立時間',
			'avatarDetail.updated' => '更新時間',
			'avatarDetail.description' => '說明',
			'avatarDetail.noDescription' => '沒有說明',
			'avatarDetail.tags' => '標籤',
			'avatarDetail.addToFavorites' => '加入最愛',
			'avatarDetail.public' => '公開',
			'avatarDetail.private' => '私人',
			'avatarDetail.hidden' => '隱藏',
			'avatarDetail.unknown' => '未知',
			'avatarDetail.share' => '分享',
			'avatarDetail.loading' => '正在載入虛擬化身資訊...',
			'avatarDetail.error' => ({required Object error}) => '獲取虛擬化身資訊失敗：${error}',
			'groups.title' => '群組',
			'groups.loadingUser' => '正在載入使用者資訊...',
			'groups.errorUser' => ({required Object error}) => '獲取使用者資訊失敗：${error}',
			'groups.loadingGroups' => '正在載入群組資訊...',
			'groups.errorGroups' => ({required Object error}) => '獲取群組資訊失敗：${error}',
			'groups.emptyTitle' => '您尚未加入任何群組',
			'groups.emptyDescription' => '您可以從 VRChat 應用程式或網站加入群組',
			'groups.searchGroups' => '尋找群組',
			'groups.members' => ({required Object count}) => '${count} 位成員',
			'groups.showDetails' => '顯示詳細資訊',
			'groups.unknownName' => '名稱不明',
			'groupDetail.loading' => '正在載入群組資訊...',
			'groupDetail.error' => ({required Object error}) => '獲取群組資訊失敗：${error}',
			'groupDetail.share' => '分享群組資訊',
			'groupDetail.description' => '說明',
			'groupDetail.roles' => '角色',
			'groupDetail.basicInfo' => '基本資訊',
			'groupDetail.createdAt' => '建立日期',
			'groupDetail.owner' => '擁有者',
			'groupDetail.rules' => '規則',
			'groupDetail.languages' => '語言',
			'groupDetail.memberCount' => ({required Object count}) => '${count} 位成員',
			'groupDetail.privacy.public' => '公開',
			'groupDetail.privacy.private' => '私人',
			'groupDetail.privacy.friends' => '好友',
			'groupDetail.privacy.invite' => '邀請制',
			'groupDetail.privacy.unknown' => '未知',
			'groupDetail.role.admin' => '管理員',
			'groupDetail.role.moderator' => '版主',
			'groupDetail.role.member' => '成員',
			'groupDetail.role.unknown' => '未知',
			'inventory.title' => '物品欄',
			'inventory.gallery' => '圖片庫',
			'inventory.icon' => '圖示',
			'inventory.emoji' => '表情符號',
			'inventory.sticker' => '貼圖',
			'inventory.print' => '列印圖',
			'inventory.upload' => '上傳檔案',
			'inventory.uploadGallery' => '正在上傳圖片庫圖片...',
			'inventory.uploadIcon' => '正在上傳圖示...',
			'inventory.uploadEmoji' => '正在上傳表情符號...',
			'inventory.uploadSticker' => '正在上傳貼圖...',
			'inventory.uploadPrint' => '正在上傳列印圖...',
			'inventory.selectImage' => '選擇圖片',
			'inventory.selectFromGallery' => '從圖片庫選擇',
			'inventory.takePhoto' => '使用相機拍攝',
			'inventory.uploadSuccess' => '上傳完成',
			'inventory.uploadFailed' => '上傳失敗',
			'inventory.uploadFailedFormat' => '檔案格式或大小有問題。請選擇 PNG 格式且小於 1MB 的圖片。',
			'inventory.uploadFailedAuth' => '驗證失敗。請重新登入。',
			'inventory.uploadFailedSize' => '檔案大小過大。請選擇較小的圖片。',
			'inventory.uploadFailedServer' => ({required Object code}) => '發生伺服器錯誤 (${code})',
			'inventory.pickImageFailed' => ({required Object error}) => '選擇圖片失敗：${error}',
			'inventory.tabs.emojiInventory.loading' => '正在載入表情符號...',
			'inventory.tabs.emojiInventory.error' => ({required Object error}) => '獲取表情符號失敗：${error}',
			'inventory.tabs.emojiInventory.emptyTitle' => '沒有表情符號',
			'inventory.tabs.emojiInventory.emptyDescription' => '在 VRChat 上傳的表情符號會顯示在這裡',
			'inventory.tabs.emojiInventory.zoomHint' => '雙擊放大',
			'inventory.tabs.galleryInventory.loading' => '正在載入圖片庫...',
			'inventory.tabs.galleryInventory.error' => ({required Object error}) => '獲取圖片庫失敗：${error}',
			'inventory.tabs.galleryInventory.emptyTitle' => '沒有圖片庫',
			'inventory.tabs.galleryInventory.emptyDescription' => '在 VRChat 上傳的圖片庫會顯示在這裡',
			'inventory.tabs.galleryInventory.zoomHint' => '雙擊放大',
			'inventory.tabs.iconInventory.loading' => '正在載入圖示...',
			'inventory.tabs.iconInventory.error' => ({required Object error}) => '獲取圖示失敗：${error}',
			'inventory.tabs.iconInventory.emptyTitle' => '沒有圖示',
			'inventory.tabs.iconInventory.emptyDescription' => '在 VRChat 上傳的圖示會顯示在這裡',
			'inventory.tabs.iconInventory.zoomHint' => '雙擊放大',
			'inventory.tabs.printInventory.loading' => '正在載入列印圖...',
			'inventory.tabs.printInventory.error' => ({required Object error}) => '獲取列印圖失敗：${error}',
			'inventory.tabs.printInventory.emptyTitle' => '沒有列印圖',
			'inventory.tabs.printInventory.emptyDescription' => '在 VRChat 上傳的列印圖會顯示在這裡',
			'inventory.tabs.printInventory.zoomHint' => '雙擊放大',
			'inventory.tabs.stickerInventory.loading' => '正在載入貼圖...',
			'inventory.tabs.stickerInventory.error' => ({required Object error}) => '獲取貼圖失敗：${error}',
			'inventory.tabs.stickerInventory.emptyTitle' => '沒有貼圖',
			'inventory.tabs.stickerInventory.emptyDescription' => '在 VRChat 上傳的貼圖會顯示在這裡',
			'inventory.tabs.stickerInventory.zoomHint' => '雙擊放大',
			'vrcnsync.title' => 'VRCNSync (β)',
			'vrcnsync.betaTitle' => 'Beta 版功能',
			'vrcnsync.betaDescription' => '此功能為開發中的 Beta 版，可能會發生非預期的問題。\n目前僅實作本機版本，若有雲端版需求將會實作。',
			'vrcnsync.githubLink' => 'VRCNSync 的 GitHub 頁面',
			'vrcnsync.openGithub' => '開啟 GitHub 頁面',
			'vrcnsync.serverRunning' => '伺服器執行中',
			'vrcnsync.serverStopped' => '伺服器已停止',
			'vrcnsync.serverRunningDesc' => '將來自 PC 的照片儲存到 VRCN 相簿',
			'vrcnsync.serverStoppedDesc' => '伺服器已停止',
			'vrcnsync.photoSaved' => '照片已儲存至 VRCN 相簿',
			'vrcnsync.photoReceived' => '已接收照片（儲存至相簿失敗）',
			'vrcnsync.openAlbum' => '開啟相簿',
			'vrcnsync.permissionErrorIos' => '需要存取照片圖庫的權限',
			'vrcnsync.permissionErrorAndroid' => '需要存取儲存空間的權限',
			'vrcnsync.openSettings' => '開啟設定',
			'vrcnsync.initError' => ({required Object error}) => '初始化失敗：${error}',
			'vrcnsync.openPhotoAppError' => '無法開啟相簿應用程式',
			'vrcnsync.serverInfo' => '伺服器資訊',
			'vrcnsync.ip' => ({required Object ip}) => 'IP: ${ip}',
			'vrcnsync.port' => ({required Object port}) => '連接埠: ${port}',
			'vrcnsync.address' => ({required Object ip, required Object port}) => '${ip}:${port}',
			'vrcnsync.autoSave' => '接收到的照片將自動儲存到「VRCN」相簿',
			'vrcnsync.usage' => '使用方法',
			'vrcnsync.usageSteps.0.title' => '在 PC 上啟動 VRCNSync 應用程式',
			'vrcnsync.usageSteps.0.desc' => '請在您的 PC 上啟動 VRCNSync 應用程式',
			'vrcnsync.usageSteps.1.title' => '連接到相同的 WiFi 網路',
			'vrcnsync.usageSteps.1.desc' => '請將您的 PC 和行動裝置連接到相同的 WiFi 網路',
			'vrcnsync.usageSteps.2.title' => '指定行動裝置為連線目標',
			'vrcnsync.usageSteps.2.desc' => '請在 PC 應用程式中指定上述的 IP 位址和連接埠',
			'vrcnsync.usageSteps.3.title' => '傳送照片',
			'vrcnsync.usageSteps.3.desc' => '從 PC 傳送照片後，將自動儲存到 VRCN 相簿',
			'vrcnsync.stats' => '連線狀態',
			'vrcnsync.statServer' => '伺服器狀態',
			'vrcnsync.statServerRunning' => '執行中',
			'vrcnsync.statServerStopped' => '已停止',
			'vrcnsync.statNetwork' => '網路',
			'vrcnsync.statNetworkConnected' => '已連線',
			'vrcnsync.statNetworkDisconnected' => '未連線',
			'feedback.title' => '意見回饋',
			'feedback.type' => '回饋類型',
			'feedback.types.bug' => '錯誤回報',
			'feedback.types.feature' => '功能請求',
			'feedback.types.improvement' => '改善建議',
			'feedback.types.other' => '其他',
			'feedback.inputTitle' => '標題 *',
			'feedback.inputTitleHint' => '請簡潔地描述',
			'feedback.inputDescription' => '詳細說明 *',
			'feedback.inputDescriptionHint' => '請提供詳細說明...',
			'feedback.cancel' => '取消',
			'feedback.send' => '傳送',
			'feedback.sending' => '傳送中...',
			'feedback.required' => '標題和詳細說明為必填項目',
			'feedback.success' => '意見回饋已成功傳送，感謝您！',
			'feedback.fail' => '傳送意見回饋失敗',
			'settings.appearance' => '外觀',
			'settings.language' => '語言',
			'settings.languageDescription' => '您可以選擇應用程式的顯示語言',
			'settings.appIcon' => '應用程式圖示',
			'settings.appIconDescription' => '變更顯示在主畫面的應用程式圖示',
			'settings.contentSettings' => '內容設定',
			'settings.searchEnabled' => '搜尋功能已啟用',
			'settings.searchDisabled' => '搜尋功能已停用',
			'settings.enableSearch' => '啟用搜尋功能',
			'settings.enableSearchDescription' => '搜尋結果中可能包含色情或暴力內容。',
			'settings.apiSetting' => '虛擬化身搜尋 API',
			'settings.apiSettingDescription' => '設定虛擬化身搜尋功能的 API',
			'settings.apiSettingSaveUrl' => 'URL 已儲存',
			'settings.notSet' => '未設定（虛擬化身搜尋功能無法使用）',
			'settings.notifications' => '通知設定',
			'settings.eventReminder' => '活動提醒',
			'settings.eventReminderDescription' => '在設定的活動開始前接收通知',
			'settings.manageReminders' => '管理已設定的提醒',
			'settings.manageRemindersDescription' => '可以取消或確認通知',
			'settings.dataStorage' => '資料與儲存空間',
			'settings.clearCache' => '清除快取',
			'settings.clearCacheSuccess' => '已清除快取',
			'settings.clearCacheError' => '清除快取時發生錯誤',
			'settings.cacheSize' => ({required Object size}) => '快取大小：${size}',
			'settings.calculatingCache' => '正在計算快取大小...',
			'settings.cacheError' => '無法取得快取大小',
			'settings.confirmClearCache' => '清除快取將會刪除暫時儲存的圖片和資料。\n\n帳號資訊和應用程式設定不會被刪除。',
			'settings.appInfo' => '應用程式資訊',
			'settings.version' => '版本',
			'settings.packageName' => '套件名稱',
			'settings.credit' => '製作群',
			'settings.creditDescription' => '開發者與貢獻者資訊',
			'settings.contact' => '聯絡我們',
			'settings.contactDescription' => '問題回報與意見',
			'settings.privacyPolicy' => '隱私權政策',
			'settings.privacyPolicyDescription' => '關於個人資訊的處理方式',
			'settings.termsOfService' => '服務條款',
			'settings.termsOfServiceDescription' => '應用程式的使用條款',
			'settings.openSource' => '開源軟體資訊',
			'settings.openSourceDescription' => '所使用函式庫等的授權',
			'settings.github' => 'GitHub 儲存庫',
			'settings.githubDescription' => '查看原始碼',
			'settings.logoutConfirm' => '確定要登出嗎？',
			'settings.logoutError' => ({required Object error}) => '登出時發生錯誤：${error}',
			'settings.iconChangeNotSupported' => '您的裝置不支援變更應用程式圖示',
			'settings.iconChangeFailed' => '變更圖示失敗',
			'settings.themeMode' => '主題模式',
			'settings.themeModeDescription' => '選擇應用程式的顯示主題',
			'settings.themeLight' => '淺色',
			_ => null,
		} ?? switch (path) {
			'settings.themeSystem' => '系統',
			'settings.themeDark' => '深色',
			'settings.appIconDefault' => '預設',
			'settings.appIconIcon' => '圖示',
			'settings.appIconLogo' => '標誌',
			'settings.delete' => '刪除',
			'credits.title' => '製作群',
			'credits.section.development' => '開發',
			'credits.section.iconPeople' => '有趣的圖示貢獻者們',
			'credits.section.testFeedback' => '測試與意見回饋',
			'credits.section.specialThanks' => '特別感謝',
			'download.success' => '下載完成',
			'download.failure' => ({required Object error}) => '下載失敗：${error}',
			'download.shareFailure' => ({required Object error}) => '分享失敗：${error}',
			'download.permissionTitle' => '需要權限',
			'download.permissionDenied' => ({required Object permissionType}) => '已拒絕存取 ${permissionType} 的權限。\n請從設定應用程式中啟用權限。',
			'download.permissionCancel' => '取消',
			'download.permissionOpenSettings' => '開啟設定',
			'download.permissionPhoto' => '照片',
			'download.permissionPhotoLibrary' => '照片圖庫',
			'download.permissionStorage' => '儲存空間',
			'download.permissionPhotoRequired' => '需要存取照片的權限',
			'download.permissionPhotoLibraryRequired' => '需要存取照片圖庫的權限',
			'download.permissionStorageRequired' => '需要存取儲存空間的權限',
			'download.permissionError' => ({required Object error}) => '檢查權限時發生錯誤：${error}',
			'download.downloading' => ({required Object fileName}) => '正在下載 ${fileName}...',
			'download.sharing' => ({required Object fileName}) => '正在準備分享 ${fileName}...',
			'instance.type.public' => '公開',
			'instance.type.hidden' => '好友+',
			'instance.type.friends' => '好友',
			'instance.type.private' => '邀請+',
			'instance.type.unknown' => '未知',
			'status.active' => '線上',
			'status.joinMe' => '歡迎加入',
			'status.askMe' => '歡迎詢問',
			'status.busy' => '忙碌中',
			'status.offline' => '離線',
			'status.unknown' => '狀態不明',
			'location.private' => '私人',
			'location.playerCount' => ({required Object userCount, required Object capacity}) => '玩家數：${userCount} / ${capacity}',
			'location.instanceType' => ({required Object type}) => '房間類型：${type}',
			'location.noInfo' => '沒有位置資訊',
			'location.fetchError' => '獲取位置資訊失敗',
			'location.privateLocation' => '正在私人場所',
			'location.inviteSending' => '正在傳送邀請...',
			'location.inviteSent' => '已傳送邀請。您可以從通知加入',
			'location.inviteFailed' => ({required Object error}) => '傳送邀請失敗：${error}',
			'location.inviteButton' => '向自己傳送邀請',
			'location.isPrivate' => ({required Object number}) => '${number}人私密',
			'location.isActive' => ({required Object number}) => '${number}人線上',
			'location.isOffline' => ({required Object number}) => '${number}人離線',
			'location.isTraveling' => ({required Object number}) => '${number}人移動中',
			'location.isStaying' => ({required Object number}) => '${number}人停留中',
			'reminder.dialogTitle' => '設定提醒',
			'reminder.alreadySet' => '已設定',
			'reminder.set' => '設定',
			'reminder.cancel' => '取消',
			'reminder.delete' => '刪除',
			'reminder.deleteAll' => '刪除所有提醒',
			'reminder.deleteAllConfirm' => '您確定要刪除所有已設定的活動提醒嗎？此操作無法復原。',
			'reminder.deleted' => '已刪除提醒',
			'reminder.deletedAll' => '已刪除所有提醒',
			'reminder.noReminders' => '沒有已設定的提醒',
			'reminder.setFromEvent' => '您可以從活動頁面設定通知',
			'reminder.eventStart' => ({required Object time}) => '${time} 開始',
			'reminder.notifyAt' => ({required Object time, required Object label}) => '${time} (${label})',
			'reminder.receiveNotification' => '您想在何時收到通知？',
			'friend.sortFilter' => '排序與篩選',
			'friend.filter' => '篩選',
			'friend.filterAll' => '顯示全部',
			'friend.filterOnline' => '僅線上',
			'friend.filterOffline' => '僅離線',
			'friend.filterFavorite' => '僅最愛',
			'friend.sort' => '排序',
			'friend.sortStatus' => '按上線狀態',
			'friend.sortName' => '按名稱',
			'friend.sortLastLogin' => '按最後登入時間',
			'friend.sortAsc' => '遞增',
			'friend.sortDesc' => '遞減',
			'friend.close' => '關閉',
			'eventCalendarFilter.filterTitle' => '篩選活動',
			'eventCalendarFilter.clear' => '清除',
			'eventCalendarFilter.keyword' => '關鍵字搜尋',
			'eventCalendarFilter.keywordHint' => '活動名稱、說明、主辦方等',
			'eventCalendarFilter.date' => '按日期篩選',
			'eventCalendarFilter.dateHint' => '可顯示特定日期範圍的活動',
			'eventCalendarFilter.startDate' => '開始日期',
			'eventCalendarFilter.endDate' => '結束日期',
			'eventCalendarFilter.select' => '請選擇',
			'eventCalendarFilter.time' => '按時段篩選',
			'eventCalendarFilter.timeHint' => '可顯示在特定時段舉行的活動',
			'eventCalendarFilter.startTime' => '開始時間',
			'eventCalendarFilter.endTime' => '結束時間',
			'eventCalendarFilter.genre' => '按類型篩選',
			'eventCalendarFilter.genreSelected' => ({required Object count}) => '已選擇 ${count} 個類型',
			'eventCalendarFilter.apply' => '套用',
			'eventCalendarFilter.filterSummary' => '篩選條件',
			'eventCalendarFilter.filterNone' => '未設定篩選條件',
			_ => null,
		};
	}
}
