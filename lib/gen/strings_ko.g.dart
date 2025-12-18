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
class TranslationsKo with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsKo({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ko,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ko>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsKo _root = this; // ignore: unused_field

	@override 
	TranslationsKo $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsKo(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsCommonKo common = _TranslationsCommonKo._(_root);
	@override late final _TranslationsTermsAgreementKo termsAgreement = _TranslationsTermsAgreementKo._(_root);
	@override late final _TranslationsDrawerKo drawer = _TranslationsDrawerKo._(_root);
	@override late final _TranslationsLoginKo login = _TranslationsLoginKo._(_root);
	@override late final _TranslationsFriendsKo friends = _TranslationsFriendsKo._(_root);
	@override late final _TranslationsFriendDetailKo friendDetail = _TranslationsFriendDetailKo._(_root);
	@override late final _TranslationsSearchKo search = _TranslationsSearchKo._(_root);
	@override late final _TranslationsProfileKo profile = _TranslationsProfileKo._(_root);
	@override late final _TranslationsEngageCardKo engageCard = _TranslationsEngageCardKo._(_root);
	@override late final _TranslationsQrScannerKo qrScanner = _TranslationsQrScannerKo._(_root);
	@override late final _TranslationsFavoritesKo favorites = _TranslationsFavoritesKo._(_root);
	@override late final _TranslationsNotificationsKo notifications = _TranslationsNotificationsKo._(_root);
	@override late final _TranslationsEventCalendarKo eventCalendar = _TranslationsEventCalendarKo._(_root);
	@override late final _TranslationsAvatarsKo avatars = _TranslationsAvatarsKo._(_root);
	@override late final _TranslationsWorldDetailKo worldDetail = _TranslationsWorldDetailKo._(_root);
	@override late final _TranslationsAvatarDetailKo avatarDetail = _TranslationsAvatarDetailKo._(_root);
	@override late final _TranslationsGroupsKo groups = _TranslationsGroupsKo._(_root);
	@override late final _TranslationsGroupDetailKo groupDetail = _TranslationsGroupDetailKo._(_root);
	@override late final _TranslationsInventoryKo inventory = _TranslationsInventoryKo._(_root);
	@override late final _TranslationsVrcnsyncKo vrcnsync = _TranslationsVrcnsyncKo._(_root);
	@override late final _TranslationsFeedbackKo feedback = _TranslationsFeedbackKo._(_root);
	@override late final _TranslationsSettingsKo settings = _TranslationsSettingsKo._(_root);
	@override late final _TranslationsCreditsKo credits = _TranslationsCreditsKo._(_root);
	@override late final _TranslationsDownloadKo download = _TranslationsDownloadKo._(_root);
	@override late final _TranslationsInstanceKo instance = _TranslationsInstanceKo._(_root);
	@override late final _TranslationsStatusKo status = _TranslationsStatusKo._(_root);
	@override late final _TranslationsLocationKo location = _TranslationsLocationKo._(_root);
	@override late final _TranslationsReminderKo reminder = _TranslationsReminderKo._(_root);
	@override late final _TranslationsFriendKo friend = _TranslationsFriendKo._(_root);
	@override late final _TranslationsEventCalendarFilterKo eventCalendarFilter = _TranslationsEventCalendarFilterKo._(_root);
}

// Path: common
class _TranslationsCommonKo implements TranslationsCommonJa {
	_TranslationsCommonKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => 'VRCN';
	@override String get ok => '확인';
	@override String get cancel => '취소';
	@override String get close => '닫기';
	@override String get save => '저장';
	@override String get edit => '편집';
	@override String get delete => '삭제';
	@override String get yes => '예';
	@override String get no => '아니요';
	@override String get loading => '로딩 중...';
	@override String error({required Object error}) => '오류가 발생했습니다: ${error}';
	@override String get errorNomessage => '오류가 발생했습니다';
	@override String get retry => '재시도';
	@override String get search => '검색';
	@override String get settings => '설정';
	@override String get confirm => '확인';
	@override String get agree => '동의';
	@override String get decline => '동의 안 함';
	@override String get username => '사용자 이름';
	@override String get password => '비밀번호';
	@override String get login => '로그인';
	@override String get logout => '로그아웃';
	@override String get share => '공유';
}

// Path: termsAgreement
class _TranslationsTermsAgreementKo implements TranslationsTermsAgreementJa {
	_TranslationsTermsAgreementKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get welcomeTitle => 'VRCN에 오신 것을 환영합니다';
	@override String get welcomeMessage => '앱을 사용하기 전에\n이용약관과 개인정보처리방침을 확인해 주세요';
	@override String get termsTitle => '이용약관';
	@override String get termsSubtitle => '앱 이용 조건에 대하여';
	@override String get privacyTitle => '개인정보처리방침';
	@override String get privacySubtitle => '개인정보 취급에 대하여';
	@override String agreeTerms({required Object title}) => '\'${title}\'에 동의합니다';
	@override String get checkContent => '내용 확인';
	@override String get notice => '이 앱은 VRChat Inc.의 비공식 앱입니다.\nVRChat Inc.와는 일절 관계가 없습니다.';
}

// Path: drawer
class _TranslationsDrawerKo implements TranslationsDrawerJa {
	_TranslationsDrawerKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get home => '홈';
	@override String get profile => '프로필';
	@override String get favorite => '즐겨찾기';
	@override String get eventCalendar => '이벤트 캘린더';
	@override String get avatar => '아바타';
	@override String get group => '그룹';
	@override String get inventory => '인벤토리';
	@override String get vrcnsync => 'VRCNSync (β)';
	@override String get review => '리뷰';
	@override String get feedback => '피드백';
	@override String get settings => '설정';
	@override String get userLoading => '사용자 정보 로딩 중...';
	@override String get userError => '사용자 정보 로딩에 실패했습니다';
	@override String get retry => '재시도';
	@override late final _TranslationsDrawerSectionKo section = _TranslationsDrawerSectionKo._(_root);
}

// Path: login
class _TranslationsLoginKo implements TranslationsLoginJa {
	_TranslationsLoginKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get forgotPassword => '비밀번호를 잊으셨나요?';
	@override String get createAccount => '계정 만들기';
	@override String get subtitle => 'VRChat 계정 정보로 로그인';
	@override String get email => '이메일 주소';
	@override String get emailHint => '이메일 또는 사용자 이름 입력';
	@override String get passwordHint => '비밀번호 입력';
	@override String get rememberMe => '로그인 상태 유지';
	@override String get loggingIn => '로그인 중...';
	@override String get errorEmptyEmail => '사용자 이름 또는 이메일 주소를 입력해 주세요';
	@override String get errorEmptyPassword => '비밀번호를 입력해 주세요';
	@override String get errorLoginFailed => '로그인에 실패했습니다. 이메일 주소와 비밀번호를 확인해 주세요.';
	@override String get twoFactorTitle => '2단계 인증';
	@override String get twoFactorSubtitle => '인증 코드를 입력해 주세요';
	@override String get twoFactorInstruction => '인증 앱에 표시된\n6자리 코드를 입력해 주세요';
	@override String get twoFactorCodeHint => '인증 코드';
	@override String get verify => '인증';
	@override String get verifying => '인증 중...';
	@override String get errorEmpty2fa => '인증 코드를 입력해 주세요';
	@override String get error2faFailed => '2단계 인증에 실패했습니다. 코드가 올바른지 확인해 주세요.';
	@override String get backToLogin => '로그인 화면으로 돌아가기';
	@override String get paste => '붙여넣기';
}

// Path: friends
class _TranslationsFriendsKo implements TranslationsFriendsJa {
	_TranslationsFriendsKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get loading => '친구 정보 로딩 중...';
	@override String error({required Object error}) => '친구 정보 로딩에 실패했습니다: ${error}';
	@override String get notFound => '친구를 찾을 수 없습니다';
	@override String get private => '프라이빗';
	@override String get active => '활동 중';
	@override String get offline => '오프라인';
	@override String get online => '온라인';
	@override String get groupTitle => '월드별로 그룹화';
	@override String get refresh => '새로고침';
	@override String get searchHint => '친구 이름으로 검색';
	@override String get noResult => '해당하는 친구가 없습니다';
}

// Path: friendDetail
class _TranslationsFriendDetailKo implements TranslationsFriendDetailJa {
	_TranslationsFriendDetailKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get loading => '사용자 정보 로딩 중...';
	@override String error({required Object error}) => '사용자 정보 로딩에 실패했습니다: ${error}';
	@override String get currentLocation => '현재 위치';
	@override String get basicInfo => '기본 정보';
	@override String get userId => '사용자 ID';
	@override String get dateJoined => '가입일';
	@override String get lastLogin => '마지막 로그인';
	@override String get bio => '자기소개';
	@override String get links => '링크';
	@override String get loadingLinks => '링크 정보 로딩 중...';
	@override String get group => '소속 그룹';
	@override String get groupDetail => '그룹 상세 정보 보기';
	@override String groupCode({required Object code}) => '그룹 코드: ${code}';
	@override String memberCount({required Object count}) => '멤버 수: ${count}명';
	@override String get unknownGroup => '알 수 없는 그룹';
	@override String get block => '차단';
	@override String get mute => '음소거';
	@override String get openWebsite => '웹사이트에서 열기';
	@override String get shareProfile => '프로필 공유';
	@override String confirmBlockTitle({required Object name}) => '${name}님을 차단하시겠습니까?';
	@override String get confirmBlockMessage => '차단하면 이 사용자로부터 친구 신청이나 메시지를 받지 않게 됩니다.';
	@override String confirmMuteTitle({required Object name}) => '${name}님을 음소거하시겠습니까?';
	@override String get confirmMuteMessage => '음소거하면 이 사용자의 음성이 들리지 않게 됩니다.';
	@override String get blockSuccess => '차단했습니다';
	@override String get muteSuccess => '음소거했습니다';
	@override String operationFailed({required Object error}) => '작업에 실패했습니다: ${error}';
}

// Path: search
class _TranslationsSearchKo implements TranslationsSearchJa {
	_TranslationsSearchKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get userTab => '사용자';
	@override String get worldTab => '월드';
	@override String get avatarTab => '아바타';
	@override String get groupTab => '그룹';
	@override late final _TranslationsSearchTabsKo tabs = _TranslationsSearchTabsKo._(_root);
}

// Path: profile
class _TranslationsProfileKo implements TranslationsProfileJa {
	_TranslationsProfileKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '프로필';
	@override String get edit => '편집';
	@override String get refresh => '새로고침';
	@override String get loading => '프로필 정보 로딩 중...';
	@override String get error => '프로필 정보 로딩에 실패했습니다: {error}';
	@override String get displayName => '표시 이름';
	@override String get username => '사용자 이름';
	@override String get userId => '사용자 ID';
	@override String get engageCard => '인게이지 카드';
	@override String get frined => '친구';
	@override String get dateJoined => '가입일';
	@override String get userType => '사용자 유형';
	@override String get status => '상태';
	@override String get statusMessage => '상태 메시지';
	@override String get bio => '자기소개';
	@override String get links => '링크';
	@override String get group => '소속 그룹';
	@override String get groupDetail => '그룹 상세 정보 보기';
	@override String get avatar => '현재 아바타';
	@override String get avatarDetail => '아바타 상세 정보 보기';
	@override String get public => '공개';
	@override String get private => '비공개';
	@override String get hidden => '숨김';
	@override String get unknown => '알 수 없음';
	@override String get friends => '친구';
	@override String get loadingLinks => '링크 정보 로딩 중...';
	@override String get noGroup => '소속된 그룹이 없습니다';
	@override String get noBio => '자기소개가 없습니다';
	@override String get noLinks => '링크가 없습니다';
	@override String get save => '변경사항 저장';
	@override String get saved => '프로필을 업데이트했습니다';
	@override String get saveFailed => '업데이트에 실패했습니다: {error}';
	@override String get discardTitle => '변경사항을 취소하시겠습니까?';
	@override String get discardContent => '프로필에 적용한 변경사항은 저장되지 않습니다.';
	@override String get discardCancel => '취소';
	@override String get discardOk => '취소하기';
	@override String get basic => '기본 정보';
	@override String get pronouns => '대명사';
	@override String get addLink => '추가';
	@override String get removeLink => '삭제';
	@override String get linkHint => '링크 입력 (예: https://twitter.com/username)';
	@override String get linksHint => '링크는 프로필에 표시되며, 탭하여 열 수 있습니다';
	@override String get statusMessageHint => '현재 상황이나 메시지를 입력하세요';
	@override String get bioHint => '자신에 대해 작성해 보세요';
}

// Path: engageCard
class _TranslationsEngageCardKo implements TranslationsEngageCardJa {
	_TranslationsEngageCardKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get pickBackground => '배경 이미지 선택';
	@override String get removeBackground => '배경 이미지 삭제';
	@override String get scanQr => 'QR 코드 스캔';
	@override String get showAvatar => '아바타 표시';
	@override String get hideAvatar => '아바타 숨기기';
	@override String get noBackground => '배경 이미지가 선택되지 않았습니다\n오른쪽 상단 버튼으로 설정할 수 있습니다';
	@override String get loading => '로딩 중...';
	@override String error({required Object error}) => '인게이지 카드 정보 로딩에 실패했습니다: ${error}';
	@override String get copyUserId => '사용자 ID 복사';
	@override String get copied => '복사했습니다';
}

// Path: qrScanner
class _TranslationsQrScannerKo implements TranslationsQrScannerJa {
	_TranslationsQrScannerKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => 'QR 코드 스캔';
	@override String get guide => 'QR 코드를 프레임 안에 맞춰주세요';
	@override String get loading => '카메라 초기화 중...';
	@override String error({required Object error}) => 'QR 코드 읽기에 실패했습니다: ${error}';
	@override String get notFound => '유효한 사용자 QR 코드를 찾을 수 없습니다';
}

// Path: favorites
class _TranslationsFavoritesKo implements TranslationsFavoritesJa {
	_TranslationsFavoritesKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '즐겨찾기';
	@override String get frined => '친구';
	@override String get friendsTab => '친구';
	@override String get worldsTab => '월드';
	@override String get avatarsTab => '아바타';
	@override String get emptyFolderTitle => '즐겨찾기 폴더가 없습니다';
	@override String get emptyFolderDescription => 'VRChat에서 즐겨찾기 폴더를 생성해 주세요';
	@override String get emptyFriends => '이 폴더에는 친구가 없습니다';
	@override String get emptyWorlds => '이 폴더에는 월드가 없습니다';
	@override String get emptyAvatars => '이 폴더에는 아바타가 없습니다';
	@override String get emptyWorldsTabTitle => '즐겨찾는 월드가 없습니다';
	@override String get emptyWorldsTabDescription => '월드 상세 화면에서 즐겨찾기에 등록할 수 있습니다';
	@override String get emptyAvatarsTabTitle => '즐겨찾는 아바타가 없습니다';
	@override String get emptyAvatarsTabDescription => '아바타 상세 화면에서 즐겨찾기에 등록할 수 있습니다';
	@override String get loading => '즐겨찾기 로딩 중...';
	@override String get loadingFolder => '폴더 정보 로딩 중...';
	@override String error({required Object error}) => '즐겨찾기 로딩에 실패했습니다: ${error}';
	@override String get errorFolder => '정보를 가져오는데 실패했습니다';
	@override String get remove => '즐겨찾기에서 삭제';
	@override String removeSuccess({required Object name}) => '${name}을(를) 즐겨찾기에서 삭제했습니다';
	@override String removeFailed({required Object error}) => '삭제에 실패했습니다: ${error}';
	@override String itemsCount({required Object count}) => '${count} 아이템';
	@override String get public => '공개';
	@override String get private => '비공개';
	@override String get hidden => '숨김';
	@override String get unknown => '알 수 없음';
	@override String get loadingError => '로딩 오류';
}

// Path: notifications
class _TranslationsNotificationsKo implements TranslationsNotificationsJa {
	_TranslationsNotificationsKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => '알림이 없습니다';
	@override String get emptyDescription => '친구 요청이나 초대 등\n새로운 알림이 여기에 표시됩니다';
	@override String friendRequest({required Object userName}) => '${userName}님으로부터 친구 요청이 도착했습니다';
	@override String invite({required Object userName, required Object worldName}) => '${userName}님으로부터 ${worldName}(으)로 초대가 도착했습니다';
	@override String friendOnline({required Object userName}) => '${userName}님이 온라인 상태가 되었습니다';
	@override String friendOffline({required Object userName}) => '${userName}님이 오프라인 상태가 되었습니다';
	@override String friendActive({required Object userName}) => '${userName}님이 활동 중 상태가 되었습니다';
	@override String friendAdd({required Object userName}) => '${userName}님이 친구에 추가되었습니다';
	@override String friendRemove({required Object userName}) => '${userName}님이 친구에서 삭제되었습니다';
	@override String statusUpdate({required Object userName, required Object status, required Object world}) => '${userName}님의 상태가 업데이트되었습니다: ${status}${world}';
	@override String locationChange({required Object userName, required Object worldName}) => '${userName}님이 ${worldName}(으)로 이동했습니다';
	@override String userUpdate({required Object world}) => '당신의 정보가 업데이트되었습니다${world}';
	@override String myLocationChange({required Object worldName}) => '당신의 이동: ${worldName}';
	@override String requestInvite({required Object userName}) => '${userName}님으로부터 참가 요청이 도착했습니다';
	@override String votekick({required Object userName}) => '${userName}님으로부터 투표 추방이 있었습니다';
	@override String responseReceived({required Object userName}) => '알림 ID:${userName}의 응답을 수신했습니다';
	@override String error({required Object worldName}) => '오류: ${worldName}';
	@override String system({required Object extraData}) => '시스템 알림: ${extraData}';
	@override String secondsAgo({required Object seconds}) => '${seconds}초 전';
	@override String minutesAgo({required Object minutes}) => '${minutes}분 전';
	@override String hoursAgo({required Object hours}) => '${hours}시간 전';
}

// Path: eventCalendar
class _TranslationsEventCalendarKo implements TranslationsEventCalendarJa {
	_TranslationsEventCalendarKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '이벤트 캘린더';
	@override String get filter => '이벤트 필터링';
	@override String get refresh => '이벤트 정보 새로고침';
	@override String get loading => '이벤트 정보 로딩 중...';
	@override String error({required Object error}) => '이벤트 정보 로딩에 실패했습니다: ${error}';
	@override String filterActive({required Object count}) => '필터 적용 중 (${count}건)';
	@override String get clear => '초기화';
	@override String get noEvents => '조건에 맞는 이벤트가 없습니다';
	@override String get clearFilter => '필터 초기화';
	@override String get today => '오늘';
	@override String get reminderSet => '리마인더 설정';
	@override String get reminderSetDone => '리마인더 설정됨';
	@override String get reminderDeleted => '리마인더를 삭제했습니다';
	@override String get eventName => '이벤트 이름';
	@override String get organizer => '주최자';
	@override String get description => '설명';
	@override String get genre => '장르';
	@override String get condition => '참가 조건';
	@override String get way => '참가 방법';
	@override String get note => '비고';
	@override String get quest => 'Quest 대응';
	@override String reminderCount({required Object count}) => '${count}건';
	@override String startToEnd({required Object start, required Object end}) => '${start} ~ ${end}';
}

// Path: avatars
class _TranslationsAvatarsKo implements TranslationsAvatarsJa {
	_TranslationsAvatarsKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '아바타';
	@override String get searchHint => '아바타 이름 등으로 검색';
	@override String get searchTooltip => '검색';
	@override String get searchEmptyTitle => '검색 결과를 찾을 수 없습니다';
	@override String get searchEmptyDescription => '다른 검색어로 시도해 주세요';
	@override String get emptyTitle => '아바타가 없습니다';
	@override String get emptyDescription => '아바타를 추가하거나 나중에 다시 시도해 주세요';
	@override String get refresh => '새로고침';
	@override String get loading => '아바타 로딩 중...';
	@override String error({required Object error}) => '아바타 정보 로딩에 실패했습니다: ${error}';
	@override String get current => '사용 중';
	@override String get public => '공개';
	@override String get private => '비공개';
	@override String get hidden => '숨김';
	@override String get author => '제작자';
	@override String get sortUpdated => '업데이트 순';
	@override String get sortName => '이름 순';
	@override String get sortTooltip => '정렬';
	@override String get viewModeTooltip => '보기 모드 전환';
}

// Path: worldDetail
class _TranslationsWorldDetailKo implements TranslationsWorldDetailJa {
	_TranslationsWorldDetailKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get loading => '월드 정보 로딩 중...';
	@override String error({required Object error}) => '월드 정보 로딩에 실패했습니다: ${error}';
	@override String get share => '이 월드 공유하기';
	@override String get openInVRChat => 'VRChat 공식 웹사이트에서 열기';
	@override String get report => '이 월드 신고하기';
	@override String get creator => '제작자';
	@override String get created => '생성일';
	@override String get updated => '업데이트일';
	@override String get favorites => '즐겨찾기 수';
	@override String get visits => '방문 수';
	@override String get occupants => '현재 인원';
	@override String get popularity => '평가';
	@override String get description => '설명';
	@override String get noDescription => '설명이 없습니다';
	@override String get tags => '태그';
	@override String get joinPublic => '퍼블릭으로 초대 보내기';
	@override String get favoriteAdded => '즐겨찾기에 추가했습니다';
	@override String get favoriteRemoved => '즐겨찾기에서 삭제했습니다';
	@override String get unknown => '알 수 없음';
}

// Path: avatarDetail
class _TranslationsAvatarDetailKo implements TranslationsAvatarDetailJa {
	_TranslationsAvatarDetailKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String changeSuccess({required Object name}) => '아바타 \'${name}\'(으)로 변경했습니다';
	@override String changeFailed({required Object error}) => '아바타 변경에 실패했습니다: ${error}';
	@override String get changing => '변경 중...';
	@override String get useThisAvatar => '이 아바타 사용하기';
	@override String get creator => '제작자';
	@override String get created => '생성일';
	@override String get updated => '업데이트일';
	@override String get description => '설명';
	@override String get noDescription => '설명이 없습니다';
	@override String get tags => '태그';
	@override String get addToFavorites => '즐겨찾기에 추가';
	@override String get public => '공개';
	@override String get private => '비공개';
	@override String get hidden => '숨김';
	@override String get unknown => '알 수 없음';
	@override String get share => '공유';
	@override String get loading => '아바타 정보 로딩 중...';
	@override String error({required Object error}) => '아바타 정보 로딩에 실패했습니다: ${error}';
}

// Path: groups
class _TranslationsGroupsKo implements TranslationsGroupsJa {
	_TranslationsGroupsKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '그룹';
	@override String get loadingUser => '사용자 정보 로딩 중...';
	@override String errorUser({required Object error}) => '사용자 정보 로딩에 실패했습니다: ${error}';
	@override String get loadingGroups => '그룹 정보 로딩 중...';
	@override String errorGroups({required Object error}) => '그룹 정보 로딩에 실패했습니다: ${error}';
	@override String get emptyTitle => '가입한 그룹이 없습니다';
	@override String get emptyDescription => 'VRChat 앱이나 웹사이트에서 그룹에 가입할 수 있습니다';
	@override String get searchGroups => '그룹 찾기';
	@override String members({required Object count}) => '${count}명의 멤버';
	@override String get showDetails => '상세 정보 보기';
	@override String get unknownName => '이름 알 수 없음';
}

// Path: groupDetail
class _TranslationsGroupDetailKo implements TranslationsGroupDetailJa {
	_TranslationsGroupDetailKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get loading => '그룹 정보 로딩 중...';
	@override String error({required Object error}) => '그룹 정보 로딩에 실패했습니다: ${error}';
	@override String get share => '그룹 정보 공유';
	@override String get description => '설명';
	@override String get roles => '역할';
	@override String get basicInfo => '기본 정보';
	@override String get createdAt => '생성일';
	@override String get owner => '소유자';
	@override String get rules => '규칙';
	@override String get languages => '언어';
	@override String memberCount({required Object count}) => '${count} 멤버';
	@override late final _TranslationsGroupDetailPrivacyKo privacy = _TranslationsGroupDetailPrivacyKo._(_root);
	@override late final _TranslationsGroupDetailRoleKo role = _TranslationsGroupDetailRoleKo._(_root);
}

// Path: inventory
class _TranslationsInventoryKo implements TranslationsInventoryJa {
	_TranslationsInventoryKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '인벤토리';
	@override String get gallery => '갤러리';
	@override String get icon => '아이콘';
	@override String get emoji => '이모지';
	@override String get sticker => '스티커';
	@override String get print => '프린트';
	@override String get upload => '파일 업로드';
	@override String get uploadGallery => '갤러리 이미지 업로드 중...';
	@override String get uploadIcon => '아이콘 업로드 중...';
	@override String get uploadEmoji => '이모지 업로드 중...';
	@override String get uploadSticker => '스티커 업로드 중...';
	@override String get uploadPrint => '프린트 이미지 업로드 중...';
	@override String get selectImage => '이미지 선택';
	@override String get selectFromGallery => '갤러리에서 선택';
	@override String get takePhoto => '카메라로 촬영';
	@override String get uploadSuccess => '업로드가 완료되었습니다';
	@override String get uploadFailed => '업로드에 실패했습니다';
	@override String get uploadFailedFormat => '파일 형식 또는 크기에 문제가 있습니다. PNG 형식의 1MB 이하 이미지를 선택해 주세요.';
	@override String get uploadFailedAuth => '인증에 실패했습니다. 다시 로그인해 주세요.';
	@override String get uploadFailedSize => '파일 크기가 너무 큽니다. 더 작은 이미지를 선택해 주세요.';
	@override String uploadFailedServer({required Object code}) => '서버 오류가 발생했습니다 (${code})';
	@override String pickImageFailed({required Object error}) => '이미지 선택에 실패했습니다: ${error}';
	@override late final _TranslationsInventoryTabsKo tabs = _TranslationsInventoryTabsKo._(_root);
}

// Path: vrcnsync
class _TranslationsVrcnsyncKo implements TranslationsVrcnsyncJa {
	_TranslationsVrcnsyncKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => 'VRCNSync (β)';
	@override String get betaTitle => '베타 기능';
	@override String get betaDescription => '이 기능은 개발 중인 베타 버전입니다. 예기치 않은 문제가 발생할 수 있습니다.\n현재는 로컬에서만 구현되어 있지만, 수요가 있으면 클라우드 버전을 구현할 예정입니다.';
	@override String get githubLink => 'VRCNSync GitHub 페이지';
	@override String get openGithub => 'GitHub 페이지 열기';
	@override String get serverRunning => '서버 실행 중';
	@override String get serverStopped => '서버 중지됨';
	@override String get serverRunningDesc => 'PC의 사진을 VRCN 앨범에 저장합니다';
	@override String get serverStoppedDesc => '서버가 중지되었습니다';
	@override String get photoSaved => '사진을 VRCN 앨범에 저장했습니다';
	@override String get photoReceived => '사진을 수신했습니다 (앨범 저장 실패)';
	@override String get openAlbum => '앨범 열기';
	@override String get permissionErrorIos => '사진 라이브러리에 대한 접근 권한이 필요합니다';
	@override String get permissionErrorAndroid => '저장소에 대한 접근 권한이 필요합니다';
	@override String get openSettings => '설정 열기';
	@override String initError({required Object error}) => '초기화에 실패했습니다: ${error}';
	@override String get openPhotoAppError => '사진 앱을 열 수 없었습니다';
	@override String get serverInfo => '서버 정보';
	@override String ip({required Object ip}) => 'IP: ${ip}';
	@override String port({required Object port}) => '포트: ${port}';
	@override String address({required Object ip, required Object port}) => '${ip}:${port}';
	@override String get autoSave => '수신된 사진은 \'VRCN\' 앨범에 자동 저장됩니다';
	@override String get usage => '사용 방법';
	@override List<dynamic> get usageSteps => [
		_TranslationsVrcnsync$usageSteps$0i0$Ko._(_root),
		_TranslationsVrcnsync$usageSteps$0i1$Ko._(_root),
		_TranslationsVrcnsync$usageSteps$0i2$Ko._(_root),
		_TranslationsVrcnsync$usageSteps$0i3$Ko._(_root),
	];
	@override String get stats => '연결 상태';
	@override String get statServer => '서버 상태';
	@override String get statServerRunning => '실행 중';
	@override String get statServerStopped => '중지됨';
	@override String get statNetwork => '네트워크';
	@override String get statNetworkConnected => '연결됨';
	@override String get statNetworkDisconnected => '연결 안 됨';
}

// Path: feedback
class _TranslationsFeedbackKo implements TranslationsFeedbackJa {
	_TranslationsFeedbackKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '피드백';
	@override String get type => '피드백 유형';
	@override Map<String, String> get types => {
		'bug': '버그 신고',
		'feature': '기능 요청',
		'improvement': '개선 제안',
		'other': '기타',
	};
	@override String get inputTitle => '제목 *';
	@override String get inputTitleHint => '간결하게 작성해 주세요';
	@override String get inputDescription => '상세 설명 *';
	@override String get inputDescriptionHint => '자세한 설명을 작성해 주세요...';
	@override String get cancel => '취소';
	@override String get send => '전송';
	@override String get sending => '전송 중...';
	@override String get required => '제목과 상세 설명은 필수 항목입니다';
	@override String get success => '피드백을 전송했습니다. 감사합니다!';
	@override String get fail => '피드백 전송에 실패했습니다';
}

// Path: settings
class _TranslationsSettingsKo implements TranslationsSettingsJa {
	_TranslationsSettingsKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get appearance => '화면';
	@override String get language => '언어';
	@override String get languageDescription => '앱의 표시 언어를 선택할 수 있습니다.';
	@override String get appIcon => '앱 아이콘';
	@override String get appIconDescription => '홈 화면에 표시되는 앱 아이콘을 변경합니다';
	@override String get contentSettings => '콘텐츠 설정';
	@override String get searchEnabled => '검색 기능이 활성화되었습니다';
	@override String get searchDisabled => '검색 기능이 비활성화되었습니다';
	@override String get enableSearch => '검색 기능 활성화';
	@override String get enableSearchDescription => '검색 결과에 성적인 콘텐츠나 폭력적인 콘텐츠가 표시될 수 있습니다.';
	@override String get apiSetting => '아바타 검색 API';
	@override String get apiSettingDescription => '아바타 검색 기능의 API를 설정합니다';
	@override String get apiSettingSaveUrl => 'URL을 저장했습니다';
	@override String get notSet => '설정되지 않음 (아바타 검색 기능을 사용할 수 없습니다)';
	@override String get notifications => '알림 설정';
	@override String get eventReminder => '이벤트 리마인더';
	@override String get eventReminderDescription => '설정한 이벤트 시작 전에 알림을 받습니다';
	@override String get manageReminders => '설정된 리마인더 관리';
	@override String get manageRemindersDescription => '알림 취소 및 확인이 가능합니다';
	@override String get dataStorage => '데이터 및 저장 공간';
	@override String get clearCache => '캐시 삭제';
	@override String get clearCacheSuccess => '캐시를 삭제했습니다';
	@override String get clearCacheError => '캐시 삭제 중 오류가 발생했습니다';
	@override String cacheSize({required Object size}) => '캐시 크기: ${size}';
	@override String get calculatingCache => '캐시 크기 계산 중...';
	@override String get cacheError => '캐시 크기를 가져올 수 없었습니다';
	@override String get confirmClearCache => '캐시를 삭제하면 임시로 저장된 이미지나 데이터가 삭제됩니다.\n\n계정 정보나 앱 설정은 삭제되지 않습니다.';
	@override String get appInfo => '앱 정보';
	@override String get version => '버전';
	@override String get packageName => '패키지 이름';
	@override String get credit => '크레딧';
	@override String get creditDescription => '개발자·기여자 정보';
	@override String get contact => '문의하기';
	@override String get contactDescription => '버그 신고·의견은 여기로';
	@override String get privacyPolicy => '개인정보처리방침';
	@override String get privacyPolicyDescription => '개인정보 취급에 대하여';
	@override String get termsOfService => '이용약관';
	@override String get termsOfServiceDescription => '앱 이용 조건';
	@override String get openSource => '오픈소스 정보';
	@override String get openSourceDescription => '사용 중인 라이브러리 등의 라이선스';
	@override String get github => 'GitHub 리포지토리';
	@override String get githubDescription => '소스 코드 보기';
	@override String get logoutConfirm => '로그아웃하시겠습니까?';
	@override String logoutError({required Object error}) => '로그아웃 중 오류가 발생했습니다: ${error}';
	@override String get iconChangeNotSupported => '사용 중인 기기에서는 앱 아이콘 변경을 지원하지 않습니다';
	@override String get iconChangeFailed => '아이콘 변경에 실패했습니다';
	@override String get themeMode => '테마 모드';
	@override String get themeModeDescription => '앱의 표시 테마를 선택할 수 있습니다';
	@override String get themeLight => '밝게';
	@override String get themeSystem => '시스템';
	@override String get themeDark => '어둡게';
	@override String get appIconDefault => '기본';
	@override String get appIconIcon => '아이콘';
	@override String get appIconLogo => '로고';
	@override String get delete => '삭제하기';
}

// Path: credits
class _TranslationsCreditsKo implements TranslationsCreditsJa {
	_TranslationsCreditsKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '크레딧';
	@override late final _TranslationsCreditsSectionKo section = _TranslationsCreditsSectionKo._(_root);
}

// Path: download
class _TranslationsDownloadKo implements TranslationsDownloadJa {
	_TranslationsDownloadKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get success => '다운로드가 완료되었습니다';
	@override String failure({required Object error}) => '다운로드에 실패했습니다: ${error}';
	@override String shareFailure({required Object error}) => '공유에 실패했습니다: ${error}';
	@override String get permissionTitle => '권한이 필요합니다';
	@override String permissionDenied({required Object permissionType}) => '${permissionType}에 대한 저장 권한이 거부되었습니다.\n설정 앱에서 권한을 활성화해 주세요.';
	@override String get permissionCancel => '취소';
	@override String get permissionOpenSettings => '설정 열기';
	@override String get permissionPhoto => '사진';
	@override String get permissionPhotoLibrary => '사진 라이브러리';
	@override String get permissionStorage => '저장 공간';
	@override String get permissionPhotoRequired => '사진에 대한 저장 권한이 필요합니다';
	@override String get permissionPhotoLibraryRequired => '사진 라이브러리에 대한 저장 권한이 필요합니다';
	@override String get permissionStorageRequired => '저장 공간에 대한 접근 권한이 필요합니다';
	@override String permissionError({required Object error}) => '권한 확인 중 오류가 발생했습니다: ${error}';
	@override String downloading({required Object fileName}) => '${fileName} 다운로드 중...';
	@override String sharing({required Object fileName}) => '${fileName} 공유 준비 중...';
}

// Path: instance
class _TranslationsInstanceKo implements TranslationsInstanceJa {
	_TranslationsInstanceKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsInstanceTypeKo type = _TranslationsInstanceTypeKo._(_root);
}

// Path: status
class _TranslationsStatusKo implements TranslationsStatusJa {
	_TranslationsStatusKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get active => '온라인';
	@override String get joinMe => '누구나 와요';
	@override String get askMe => '물어보세요';
	@override String get busy => '바쁨';
	@override String get offline => '오프라인';
	@override String get unknown => '상태 알 수 없음';
}

// Path: location
class _TranslationsLocationKo implements TranslationsLocationJa {
	_TranslationsLocationKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get private => '프라이빗';
	@override String playerCount({required Object userCount, required Object capacity}) => '플레이어 수: ${userCount} / ${capacity}';
	@override String instanceType({required Object type}) => '인스턴스 타입: ${type}';
	@override String get noInfo => '위치 정보가 없습니다';
	@override String get fetchError => '위치 정보 로딩에 실패했습니다';
	@override String get privateLocation => '프라이빗한 장소에 있습니다';
	@override String get inviteSending => '초대 보내는 중...';
	@override String get inviteSent => '초대를 보냈습니다. 알림에서 참여할 수 있습니다';
	@override String inviteFailed({required Object error}) => '초대 보내기에 실패했습니다: ${error}';
	@override String get inviteButton => '나에게 초대 보내기';
	@override String isPrivate({required Object number}) => '${number}명이 비공개';
	@override String isActive({required Object number}) => '${number}명이 활동 중';
	@override String isOffline({required Object number}) => '${number}명이 오프라인';
	@override String isTraveling({required Object number}) => '${number}명이 이동 중';
	@override String isStaying({required Object number}) => '${number}명이 체류 중';
}

// Path: reminder
class _TranslationsReminderKo implements TranslationsReminderJa {
	_TranslationsReminderKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get dialogTitle => '리마인더 설정';
	@override String get alreadySet => '설정됨';
	@override String get set => '설정하기';
	@override String get cancel => '취소';
	@override String get delete => '삭제하기';
	@override String get deleteAll => '모든 리마인더 삭제';
	@override String get deleteAllConfirm => '설정한 모든 이벤트 리마인더를 삭제합니다. 이 작업은 되돌릴 수 없습니다.';
	@override String get deleted => '리마인더를 삭제했습니다';
	@override String get deletedAll => '모든 리마인더를 삭제했습니다';
	@override String get noReminders => '설정된 리마인더가 없습니다';
	@override String get setFromEvent => '이벤트 페이지에서 알림을 설정할 수 있습니다';
	@override String eventStart({required Object time}) => '${time} 시작';
	@override String notifyAt({required Object time, required Object label}) => '${time} (${label})';
	@override String get receiveNotification => '언제 알림을 받으시겠습니까?';
}

// Path: friend
class _TranslationsFriendKo implements TranslationsFriendJa {
	_TranslationsFriendKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get sortFilter => '정렬·필터';
	@override String get filter => '필터';
	@override String get filterAll => '모두 표시';
	@override String get filterOnline => '온라인만';
	@override String get filterOffline => '오프라인만';
	@override String get filterFavorite => '즐겨찾기만';
	@override String get sort => '정렬';
	@override String get sortStatus => '온라인 상태 순';
	@override String get sortName => '이름 순';
	@override String get sortLastLogin => '마지막 로그인 순';
	@override String get sortAsc => '오름차순';
	@override String get sortDesc => '내림차순';
	@override String get close => '닫기';
}

// Path: eventCalendarFilter
class _TranslationsEventCalendarFilterKo implements TranslationsEventCalendarFilterJa {
	_TranslationsEventCalendarFilterKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get filterTitle => '이벤트 필터링';
	@override String get clear => '초기화';
	@override String get keyword => '키워드 검색';
	@override String get keywordHint => '이벤트 이름, 설명, 주최자 등';
	@override String get date => '날짜로 필터링';
	@override String get dateHint => '특정 날짜 범위의 이벤트를 표시할 수 있습니다';
	@override String get startDate => '시작일';
	@override String get endDate => '종료일';
	@override String get select => '선택해 주세요';
	@override String get time => '시간대로 필터링';
	@override String get timeHint => '특정 시간대에 개최되는 이벤트를 표시할 수 있습니다';
	@override String get startTime => '시작 시간';
	@override String get endTime => '종료 시간';
	@override String get genre => '장르로 필터링';
	@override String genreSelected({required Object count}) => '${count}개의 장르 선택 중';
	@override String get apply => '적용하기';
	@override String get filterSummary => '필터';
	@override String get filterNone => '필터가 설정되지 않았습니다';
}

// Path: drawer.section
class _TranslationsDrawerSectionKo implements TranslationsDrawerSectionJa {
	_TranslationsDrawerSectionKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get content => '콘텐츠';
	@override String get other => '기타';
}

// Path: search.tabs
class _TranslationsSearchTabsKo implements TranslationsSearchTabsJa {
	_TranslationsSearchTabsKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsSearchTabsUserSearchKo userSearch = _TranslationsSearchTabsUserSearchKo._(_root);
	@override late final _TranslationsSearchTabsWorldSearchKo worldSearch = _TranslationsSearchTabsWorldSearchKo._(_root);
	@override late final _TranslationsSearchTabsGroupSearchKo groupSearch = _TranslationsSearchTabsGroupSearchKo._(_root);
	@override late final _TranslationsSearchTabsAvatarSearchKo avatarSearch = _TranslationsSearchTabsAvatarSearchKo._(_root);
}

// Path: groupDetail.privacy
class _TranslationsGroupDetailPrivacyKo implements TranslationsGroupDetailPrivacyJa {
	_TranslationsGroupDetailPrivacyKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get public => '공개';
	@override String get private => '비공개';
	@override String get friends => '친구';
	@override String get invite => '초대제';
	@override String get unknown => '알 수 없음';
}

// Path: groupDetail.role
class _TranslationsGroupDetailRoleKo implements TranslationsGroupDetailRoleJa {
	_TranslationsGroupDetailRoleKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get admin => '관리자';
	@override String get moderator => '모더레이터';
	@override String get member => '멤버';
	@override String get unknown => '알 수 없음';
}

// Path: inventory.tabs
class _TranslationsInventoryTabsKo implements TranslationsInventoryTabsJa {
	_TranslationsInventoryTabsKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsInventoryTabsEmojiInventoryKo emojiInventory = _TranslationsInventoryTabsEmojiInventoryKo._(_root);
	@override late final _TranslationsInventoryTabsGalleryInventoryKo galleryInventory = _TranslationsInventoryTabsGalleryInventoryKo._(_root);
	@override late final _TranslationsInventoryTabsIconInventoryKo iconInventory = _TranslationsInventoryTabsIconInventoryKo._(_root);
	@override late final _TranslationsInventoryTabsPrintInventoryKo printInventory = _TranslationsInventoryTabsPrintInventoryKo._(_root);
	@override late final _TranslationsInventoryTabsStickerInventoryKo stickerInventory = _TranslationsInventoryTabsStickerInventoryKo._(_root);
}

// Path: vrcnsync.usageSteps.0
class _TranslationsVrcnsync$usageSteps$0i0$Ko implements TranslationsVrcnsync$usageSteps$0i0$Ja {
	_TranslationsVrcnsync$usageSteps$0i0$Ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => 'PC에서 VRCNSync 앱 실행';
	@override String get desc => 'PC에서 VRCNSync 앱을 실행해 주세요';
}

// Path: vrcnsync.usageSteps.1
class _TranslationsVrcnsync$usageSteps$0i1$Ko implements TranslationsVrcnsync$usageSteps$0i1$Ja {
	_TranslationsVrcnsync$usageSteps$0i1$Ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '동일한 WiFi 네트워크에 연결';
	@override String get desc => 'PC와 모바일 기기를 동일한 WiFi 네트워크에 연결해 주세요';
}

// Path: vrcnsync.usageSteps.2
class _TranslationsVrcnsync$usageSteps$0i2$Ko implements TranslationsVrcnsync$usageSteps$0i2$Ja {
	_TranslationsVrcnsync$usageSteps$0i2$Ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '연결 대상으로 모바일 기기 지정';
	@override String get desc => 'PC 앱에서 위의 IP 주소와 포트를 지정해 주세요';
}

// Path: vrcnsync.usageSteps.3
class _TranslationsVrcnsync$usageSteps$0i3$Ko implements TranslationsVrcnsync$usageSteps$0i3$Ja {
	_TranslationsVrcnsync$usageSteps$0i3$Ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '사진 전송';
	@override String get desc => 'PC에서 사진을 전송하면 자동으로 VRCN 앨범에 저장됩니다';
}

// Path: credits.section
class _TranslationsCreditsSectionKo implements TranslationsCreditsSectionJa {
	_TranslationsCreditsSectionKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get development => '개발';
	@override String get iconPeople => '재미있는 아이콘 제공자들';
	@override String get testFeedback => '테스트·피드백';
	@override String get specialThanks => '스페셜 땡스';
}

// Path: instance.type
class _TranslationsInstanceTypeKo implements TranslationsInstanceTypeJa {
	_TranslationsInstanceTypeKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get public => '퍼블릭';
	@override String get hidden => '프렌드+';
	@override String get friends => '프렌드';
	@override String get private => '인바이트+';
	@override String get unknown => '알 수 없음';
}

// Path: search.tabs.userSearch
class _TranslationsSearchTabsUserSearchKo implements TranslationsSearchTabsUserSearchJa {
	_TranslationsSearchTabsUserSearchKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => '사용자 검색';
	@override String get emptyDescription => '사용자 이름이나 ID로 검색할 수 있습니다';
	@override String get searching => '검색 중...';
	@override String get noResults => '해당하는 사용자를 찾을 수 없습니다';
	@override String error({required Object error}) => '사용자 검색 중 오류가 발생했습니다: ${error}';
	@override String get inputPlaceholder => '사용자 이름 또는 ID 입력';
}

// Path: search.tabs.worldSearch
class _TranslationsSearchTabsWorldSearchKo implements TranslationsSearchTabsWorldSearchJa {
	_TranslationsSearchTabsWorldSearchKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => '월드 탐색';
	@override String get emptyDescription => '키워드를 입력하여 검색해 주세요';
	@override String get searching => '검색 중...';
	@override String get noResults => '해당하는 월드를 찾을 수 없습니다';
	@override String noResultsWithQuery({required Object query}) => '\'${query}\'에 일치하는 월드를\n찾을 수 없었습니다';
	@override String get noResultsHint => '검색 키워드를 바꿔보세요';
	@override String error({required Object error}) => '월드 검색 중 오류가 발생했습니다: ${error}';
	@override String resultCount({required Object count}) => '${count}개의 월드를 찾았습니다';
	@override String authorPrefix({required Object authorName}) => 'by ${authorName}';
	@override String get listView => '리스트 뷰';
	@override String get gridView => '그리드 뷰';
}

// Path: search.tabs.groupSearch
class _TranslationsSearchTabsGroupSearchKo implements TranslationsSearchTabsGroupSearchJa {
	_TranslationsSearchTabsGroupSearchKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get emptyTitle => '그룹 검색';
	@override String get emptyDescription => '키워드를 입력하여 검색해 주세요';
	@override String get searching => '검색 중...';
	@override String get noResults => '해당하는 그룹을 찾을 수 없습니다';
	@override String noResultsWithQuery({required Object query}) => '\'${query}\'에 일치하는 그룹을\n찾을 수 없었습니다';
	@override String get noResultsHint => '검색 키워드를 바꿔보세요';
	@override String error({required Object error}) => '그룹 검색 중 오류가 발생했습니다: ${error}';
	@override String resultCount({required Object count}) => '${count}개의 그룹을 찾았습니다';
	@override String get listView => '리스트 뷰';
	@override String get gridView => '그리드 뷰';
	@override String memberCount({required Object count}) => '${count} 멤버';
}

// Path: search.tabs.avatarSearch
class _TranslationsSearchTabsAvatarSearchKo implements TranslationsSearchTabsAvatarSearchJa {
	_TranslationsSearchTabsAvatarSearchKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get avatar => '아바타';
	@override String get emptyTitle => '아바타 검색';
	@override String get emptyDescription => '키워드를 입력하여 검색해 주세요';
	@override String get searching => '아바타 검색 중...';
	@override String get noResults => '검색 결과를 찾을 수 없습니다';
	@override String get noResultsHint => '다른 키워드로 시도해 보세요';
	@override String error({required Object error}) => '아바타 검색 중 오류가 발생했습니다: ${error}';
}

// Path: inventory.tabs.emojiInventory
class _TranslationsInventoryTabsEmojiInventoryKo implements TranslationsInventoryTabsEmojiInventoryJa {
	_TranslationsInventoryTabsEmojiInventoryKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get loading => '이모지 로딩 중...';
	@override String error({required Object error}) => '이모지 로딩에 실패했습니다: ${error}';
	@override String get emptyTitle => '이모지가 없습니다';
	@override String get emptyDescription => 'VRChat에서 업로드한 이모지가 여기에 표시됩니다';
	@override String get zoomHint => '더블 탭으로 확대';
}

// Path: inventory.tabs.galleryInventory
class _TranslationsInventoryTabsGalleryInventoryKo implements TranslationsInventoryTabsGalleryInventoryJa {
	_TranslationsInventoryTabsGalleryInventoryKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get loading => '갤러리 로딩 중...';
	@override String error({required Object error}) => '갤러리 로딩에 실패했습니다: ${error}';
	@override String get emptyTitle => '갤러리가 없습니다';
	@override String get emptyDescription => 'VRChat에서 업로드한 갤러리가 여기에 표시됩니다';
	@override String get zoomHint => '더블 탭으로 확대';
}

// Path: inventory.tabs.iconInventory
class _TranslationsInventoryTabsIconInventoryKo implements TranslationsInventoryTabsIconInventoryJa {
	_TranslationsInventoryTabsIconInventoryKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get loading => '아이콘 로딩 중...';
	@override String error({required Object error}) => '아이콘 로딩에 실패했습니다: ${error}';
	@override String get emptyTitle => '아이콘이 없습니다';
	@override String get emptyDescription => 'VRChat에서 업로드한 아이콘이 여기에 표시됩니다';
	@override String get zoomHint => '더블 탭으로 확대';
}

// Path: inventory.tabs.printInventory
class _TranslationsInventoryTabsPrintInventoryKo implements TranslationsInventoryTabsPrintInventoryJa {
	_TranslationsInventoryTabsPrintInventoryKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get loading => '프린트 로딩 중...';
	@override String error({required Object error}) => '프린트 로딩에 실패했습니다: ${error}';
	@override String get emptyTitle => '프린트가 없습니다';
	@override String get emptyDescription => 'VRChat에서 업로드한 프린트가 여기에 표시됩니다';
	@override String get zoomHint => '더블 탭으로 확대';
}

// Path: inventory.tabs.stickerInventory
class _TranslationsInventoryTabsStickerInventoryKo implements TranslationsInventoryTabsStickerInventoryJa {
	_TranslationsInventoryTabsStickerInventoryKo._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get loading => '스티커 로딩 중...';
	@override String error({required Object error}) => '스티커 로딩에 실패했습니다: ${error}';
	@override String get emptyTitle => '스티커가 없습니다';
	@override String get emptyDescription => 'VRChat에서 업로드한 스티커가 여기에 표시됩니다';
	@override String get zoomHint => '더블 탭으로 확대';
}

/// The flat map containing all translations for locale <ko>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsKo {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.title' => 'VRCN',
			'common.ok' => '확인',
			'common.cancel' => '취소',
			'common.close' => '닫기',
			'common.save' => '저장',
			'common.edit' => '편집',
			'common.delete' => '삭제',
			'common.yes' => '예',
			'common.no' => '아니요',
			'common.loading' => '로딩 중...',
			'common.error' => ({required Object error}) => '오류가 발생했습니다: ${error}',
			'common.errorNomessage' => '오류가 발생했습니다',
			'common.retry' => '재시도',
			'common.search' => '검색',
			'common.settings' => '설정',
			'common.confirm' => '확인',
			'common.agree' => '동의',
			'common.decline' => '동의 안 함',
			'common.username' => '사용자 이름',
			'common.password' => '비밀번호',
			'common.login' => '로그인',
			'common.logout' => '로그아웃',
			'common.share' => '공유',
			'termsAgreement.welcomeTitle' => 'VRCN에 오신 것을 환영합니다',
			'termsAgreement.welcomeMessage' => '앱을 사용하기 전에\n이용약관과 개인정보처리방침을 확인해 주세요',
			'termsAgreement.termsTitle' => '이용약관',
			'termsAgreement.termsSubtitle' => '앱 이용 조건에 대하여',
			'termsAgreement.privacyTitle' => '개인정보처리방침',
			'termsAgreement.privacySubtitle' => '개인정보 취급에 대하여',
			'termsAgreement.agreeTerms' => ({required Object title}) => '\'${title}\'에 동의합니다',
			'termsAgreement.checkContent' => '내용 확인',
			'termsAgreement.notice' => '이 앱은 VRChat Inc.의 비공식 앱입니다.\nVRChat Inc.와는 일절 관계가 없습니다.',
			'drawer.home' => '홈',
			'drawer.profile' => '프로필',
			'drawer.favorite' => '즐겨찾기',
			'drawer.eventCalendar' => '이벤트 캘린더',
			'drawer.avatar' => '아바타',
			'drawer.group' => '그룹',
			'drawer.inventory' => '인벤토리',
			'drawer.vrcnsync' => 'VRCNSync (β)',
			'drawer.review' => '리뷰',
			'drawer.feedback' => '피드백',
			'drawer.settings' => '설정',
			'drawer.userLoading' => '사용자 정보 로딩 중...',
			'drawer.userError' => '사용자 정보 로딩에 실패했습니다',
			'drawer.retry' => '재시도',
			'drawer.section.content' => '콘텐츠',
			'drawer.section.other' => '기타',
			'login.forgotPassword' => '비밀번호를 잊으셨나요?',
			'login.createAccount' => '계정 만들기',
			'login.subtitle' => 'VRChat 계정 정보로 로그인',
			'login.email' => '이메일 주소',
			'login.emailHint' => '이메일 또는 사용자 이름 입력',
			'login.passwordHint' => '비밀번호 입력',
			'login.rememberMe' => '로그인 상태 유지',
			'login.loggingIn' => '로그인 중...',
			'login.errorEmptyEmail' => '사용자 이름 또는 이메일 주소를 입력해 주세요',
			'login.errorEmptyPassword' => '비밀번호를 입력해 주세요',
			'login.errorLoginFailed' => '로그인에 실패했습니다. 이메일 주소와 비밀번호를 확인해 주세요.',
			'login.twoFactorTitle' => '2단계 인증',
			'login.twoFactorSubtitle' => '인증 코드를 입력해 주세요',
			'login.twoFactorInstruction' => '인증 앱에 표시된\n6자리 코드를 입력해 주세요',
			'login.twoFactorCodeHint' => '인증 코드',
			'login.verify' => '인증',
			'login.verifying' => '인증 중...',
			'login.errorEmpty2fa' => '인증 코드를 입력해 주세요',
			'login.error2faFailed' => '2단계 인증에 실패했습니다. 코드가 올바른지 확인해 주세요.',
			'login.backToLogin' => '로그인 화면으로 돌아가기',
			'login.paste' => '붙여넣기',
			'friends.loading' => '친구 정보 로딩 중...',
			'friends.error' => ({required Object error}) => '친구 정보 로딩에 실패했습니다: ${error}',
			'friends.notFound' => '친구를 찾을 수 없습니다',
			'friends.private' => '프라이빗',
			'friends.active' => '활동 중',
			'friends.offline' => '오프라인',
			'friends.online' => '온라인',
			'friends.groupTitle' => '월드별로 그룹화',
			'friends.refresh' => '새로고침',
			'friends.searchHint' => '친구 이름으로 검색',
			'friends.noResult' => '해당하는 친구가 없습니다',
			'friendDetail.loading' => '사용자 정보 로딩 중...',
			'friendDetail.error' => ({required Object error}) => '사용자 정보 로딩에 실패했습니다: ${error}',
			'friendDetail.currentLocation' => '현재 위치',
			'friendDetail.basicInfo' => '기본 정보',
			'friendDetail.userId' => '사용자 ID',
			'friendDetail.dateJoined' => '가입일',
			'friendDetail.lastLogin' => '마지막 로그인',
			'friendDetail.bio' => '자기소개',
			'friendDetail.links' => '링크',
			'friendDetail.loadingLinks' => '링크 정보 로딩 중...',
			'friendDetail.group' => '소속 그룹',
			'friendDetail.groupDetail' => '그룹 상세 정보 보기',
			'friendDetail.groupCode' => ({required Object code}) => '그룹 코드: ${code}',
			'friendDetail.memberCount' => ({required Object count}) => '멤버 수: ${count}명',
			'friendDetail.unknownGroup' => '알 수 없는 그룹',
			'friendDetail.block' => '차단',
			'friendDetail.mute' => '음소거',
			'friendDetail.openWebsite' => '웹사이트에서 열기',
			'friendDetail.shareProfile' => '프로필 공유',
			'friendDetail.confirmBlockTitle' => ({required Object name}) => '${name}님을 차단하시겠습니까?',
			'friendDetail.confirmBlockMessage' => '차단하면 이 사용자로부터 친구 신청이나 메시지를 받지 않게 됩니다.',
			'friendDetail.confirmMuteTitle' => ({required Object name}) => '${name}님을 음소거하시겠습니까?',
			'friendDetail.confirmMuteMessage' => '음소거하면 이 사용자의 음성이 들리지 않게 됩니다.',
			'friendDetail.blockSuccess' => '차단했습니다',
			'friendDetail.muteSuccess' => '음소거했습니다',
			'friendDetail.operationFailed' => ({required Object error}) => '작업에 실패했습니다: ${error}',
			'search.userTab' => '사용자',
			'search.worldTab' => '월드',
			'search.avatarTab' => '아바타',
			'search.groupTab' => '그룹',
			'search.tabs.userSearch.emptyTitle' => '사용자 검색',
			'search.tabs.userSearch.emptyDescription' => '사용자 이름이나 ID로 검색할 수 있습니다',
			'search.tabs.userSearch.searching' => '검색 중...',
			'search.tabs.userSearch.noResults' => '해당하는 사용자를 찾을 수 없습니다',
			'search.tabs.userSearch.error' => ({required Object error}) => '사용자 검색 중 오류가 발생했습니다: ${error}',
			'search.tabs.userSearch.inputPlaceholder' => '사용자 이름 또는 ID 입력',
			'search.tabs.worldSearch.emptyTitle' => '월드 탐색',
			'search.tabs.worldSearch.emptyDescription' => '키워드를 입력하여 검색해 주세요',
			'search.tabs.worldSearch.searching' => '검색 중...',
			'search.tabs.worldSearch.noResults' => '해당하는 월드를 찾을 수 없습니다',
			'search.tabs.worldSearch.noResultsWithQuery' => ({required Object query}) => '\'${query}\'에 일치하는 월드를\n찾을 수 없었습니다',
			'search.tabs.worldSearch.noResultsHint' => '검색 키워드를 바꿔보세요',
			'search.tabs.worldSearch.error' => ({required Object error}) => '월드 검색 중 오류가 발생했습니다: ${error}',
			'search.tabs.worldSearch.resultCount' => ({required Object count}) => '${count}개의 월드를 찾았습니다',
			'search.tabs.worldSearch.authorPrefix' => ({required Object authorName}) => 'by ${authorName}',
			'search.tabs.worldSearch.listView' => '리스트 뷰',
			'search.tabs.worldSearch.gridView' => '그리드 뷰',
			'search.tabs.groupSearch.emptyTitle' => '그룹 검색',
			'search.tabs.groupSearch.emptyDescription' => '키워드를 입력하여 검색해 주세요',
			'search.tabs.groupSearch.searching' => '검색 중...',
			'search.tabs.groupSearch.noResults' => '해당하는 그룹을 찾을 수 없습니다',
			'search.tabs.groupSearch.noResultsWithQuery' => ({required Object query}) => '\'${query}\'에 일치하는 그룹을\n찾을 수 없었습니다',
			'search.tabs.groupSearch.noResultsHint' => '검색 키워드를 바꿔보세요',
			'search.tabs.groupSearch.error' => ({required Object error}) => '그룹 검색 중 오류가 발생했습니다: ${error}',
			'search.tabs.groupSearch.resultCount' => ({required Object count}) => '${count}개의 그룹을 찾았습니다',
			'search.tabs.groupSearch.listView' => '리스트 뷰',
			'search.tabs.groupSearch.gridView' => '그리드 뷰',
			'search.tabs.groupSearch.memberCount' => ({required Object count}) => '${count} 멤버',
			'search.tabs.avatarSearch.avatar' => '아바타',
			'search.tabs.avatarSearch.emptyTitle' => '아바타 검색',
			'search.tabs.avatarSearch.emptyDescription' => '키워드를 입력하여 검색해 주세요',
			'search.tabs.avatarSearch.searching' => '아바타 검색 중...',
			'search.tabs.avatarSearch.noResults' => '검색 결과를 찾을 수 없습니다',
			'search.tabs.avatarSearch.noResultsHint' => '다른 키워드로 시도해 보세요',
			'search.tabs.avatarSearch.error' => ({required Object error}) => '아바타 검색 중 오류가 발생했습니다: ${error}',
			'profile.title' => '프로필',
			'profile.edit' => '편집',
			'profile.refresh' => '새로고침',
			'profile.loading' => '프로필 정보 로딩 중...',
			'profile.error' => '프로필 정보 로딩에 실패했습니다: {error}',
			'profile.displayName' => '표시 이름',
			'profile.username' => '사용자 이름',
			'profile.userId' => '사용자 ID',
			'profile.engageCard' => '인게이지 카드',
			'profile.frined' => '친구',
			'profile.dateJoined' => '가입일',
			'profile.userType' => '사용자 유형',
			'profile.status' => '상태',
			'profile.statusMessage' => '상태 메시지',
			'profile.bio' => '자기소개',
			'profile.links' => '링크',
			'profile.group' => '소속 그룹',
			'profile.groupDetail' => '그룹 상세 정보 보기',
			'profile.avatar' => '현재 아바타',
			'profile.avatarDetail' => '아바타 상세 정보 보기',
			'profile.public' => '공개',
			'profile.private' => '비공개',
			'profile.hidden' => '숨김',
			'profile.unknown' => '알 수 없음',
			'profile.friends' => '친구',
			'profile.loadingLinks' => '링크 정보 로딩 중...',
			'profile.noGroup' => '소속된 그룹이 없습니다',
			'profile.noBio' => '자기소개가 없습니다',
			'profile.noLinks' => '링크가 없습니다',
			'profile.save' => '변경사항 저장',
			'profile.saved' => '프로필을 업데이트했습니다',
			'profile.saveFailed' => '업데이트에 실패했습니다: {error}',
			'profile.discardTitle' => '변경사항을 취소하시겠습니까?',
			'profile.discardContent' => '프로필에 적용한 변경사항은 저장되지 않습니다.',
			'profile.discardCancel' => '취소',
			'profile.discardOk' => '취소하기',
			'profile.basic' => '기본 정보',
			'profile.pronouns' => '대명사',
			'profile.addLink' => '추가',
			'profile.removeLink' => '삭제',
			'profile.linkHint' => '링크 입력 (예: https://twitter.com/username)',
			'profile.linksHint' => '링크는 프로필에 표시되며, 탭하여 열 수 있습니다',
			'profile.statusMessageHint' => '현재 상황이나 메시지를 입력하세요',
			'profile.bioHint' => '자신에 대해 작성해 보세요',
			'engageCard.pickBackground' => '배경 이미지 선택',
			'engageCard.removeBackground' => '배경 이미지 삭제',
			'engageCard.scanQr' => 'QR 코드 스캔',
			'engageCard.showAvatar' => '아바타 표시',
			'engageCard.hideAvatar' => '아바타 숨기기',
			'engageCard.noBackground' => '배경 이미지가 선택되지 않았습니다\n오른쪽 상단 버튼으로 설정할 수 있습니다',
			'engageCard.loading' => '로딩 중...',
			'engageCard.error' => ({required Object error}) => '인게이지 카드 정보 로딩에 실패했습니다: ${error}',
			'engageCard.copyUserId' => '사용자 ID 복사',
			'engageCard.copied' => '복사했습니다',
			'qrScanner.title' => 'QR 코드 스캔',
			'qrScanner.guide' => 'QR 코드를 프레임 안에 맞춰주세요',
			'qrScanner.loading' => '카메라 초기화 중...',
			'qrScanner.error' => ({required Object error}) => 'QR 코드 읽기에 실패했습니다: ${error}',
			'qrScanner.notFound' => '유효한 사용자 QR 코드를 찾을 수 없습니다',
			'favorites.title' => '즐겨찾기',
			'favorites.frined' => '친구',
			'favorites.friendsTab' => '친구',
			'favorites.worldsTab' => '월드',
			'favorites.avatarsTab' => '아바타',
			'favorites.emptyFolderTitle' => '즐겨찾기 폴더가 없습니다',
			'favorites.emptyFolderDescription' => 'VRChat에서 즐겨찾기 폴더를 생성해 주세요',
			'favorites.emptyFriends' => '이 폴더에는 친구가 없습니다',
			'favorites.emptyWorlds' => '이 폴더에는 월드가 없습니다',
			'favorites.emptyAvatars' => '이 폴더에는 아바타가 없습니다',
			'favorites.emptyWorldsTabTitle' => '즐겨찾는 월드가 없습니다',
			'favorites.emptyWorldsTabDescription' => '월드 상세 화면에서 즐겨찾기에 등록할 수 있습니다',
			'favorites.emptyAvatarsTabTitle' => '즐겨찾는 아바타가 없습니다',
			'favorites.emptyAvatarsTabDescription' => '아바타 상세 화면에서 즐겨찾기에 등록할 수 있습니다',
			'favorites.loading' => '즐겨찾기 로딩 중...',
			'favorites.loadingFolder' => '폴더 정보 로딩 중...',
			'favorites.error' => ({required Object error}) => '즐겨찾기 로딩에 실패했습니다: ${error}',
			'favorites.errorFolder' => '정보를 가져오는데 실패했습니다',
			'favorites.remove' => '즐겨찾기에서 삭제',
			'favorites.removeSuccess' => ({required Object name}) => '${name}을(를) 즐겨찾기에서 삭제했습니다',
			'favorites.removeFailed' => ({required Object error}) => '삭제에 실패했습니다: ${error}',
			'favorites.itemsCount' => ({required Object count}) => '${count} 아이템',
			'favorites.public' => '공개',
			'favorites.private' => '비공개',
			'favorites.hidden' => '숨김',
			'favorites.unknown' => '알 수 없음',
			'favorites.loadingError' => '로딩 오류',
			'notifications.emptyTitle' => '알림이 없습니다',
			'notifications.emptyDescription' => '친구 요청이나 초대 등\n새로운 알림이 여기에 표시됩니다',
			'notifications.friendRequest' => ({required Object userName}) => '${userName}님으로부터 친구 요청이 도착했습니다',
			'notifications.invite' => ({required Object userName, required Object worldName}) => '${userName}님으로부터 ${worldName}(으)로 초대가 도착했습니다',
			'notifications.friendOnline' => ({required Object userName}) => '${userName}님이 온라인 상태가 되었습니다',
			'notifications.friendOffline' => ({required Object userName}) => '${userName}님이 오프라인 상태가 되었습니다',
			'notifications.friendActive' => ({required Object userName}) => '${userName}님이 활동 중 상태가 되었습니다',
			'notifications.friendAdd' => ({required Object userName}) => '${userName}님이 친구에 추가되었습니다',
			'notifications.friendRemove' => ({required Object userName}) => '${userName}님이 친구에서 삭제되었습니다',
			'notifications.statusUpdate' => ({required Object userName, required Object status, required Object world}) => '${userName}님의 상태가 업데이트되었습니다: ${status}${world}',
			'notifications.locationChange' => ({required Object userName, required Object worldName}) => '${userName}님이 ${worldName}(으)로 이동했습니다',
			'notifications.userUpdate' => ({required Object world}) => '당신의 정보가 업데이트되었습니다${world}',
			'notifications.myLocationChange' => ({required Object worldName}) => '당신의 이동: ${worldName}',
			'notifications.requestInvite' => ({required Object userName}) => '${userName}님으로부터 참가 요청이 도착했습니다',
			'notifications.votekick' => ({required Object userName}) => '${userName}님으로부터 투표 추방이 있었습니다',
			'notifications.responseReceived' => ({required Object userName}) => '알림 ID:${userName}의 응답을 수신했습니다',
			'notifications.error' => ({required Object worldName}) => '오류: ${worldName}',
			'notifications.system' => ({required Object extraData}) => '시스템 알림: ${extraData}',
			'notifications.secondsAgo' => ({required Object seconds}) => '${seconds}초 전',
			'notifications.minutesAgo' => ({required Object minutes}) => '${minutes}분 전',
			'notifications.hoursAgo' => ({required Object hours}) => '${hours}시간 전',
			'eventCalendar.title' => '이벤트 캘린더',
			'eventCalendar.filter' => '이벤트 필터링',
			'eventCalendar.refresh' => '이벤트 정보 새로고침',
			'eventCalendar.loading' => '이벤트 정보 로딩 중...',
			'eventCalendar.error' => ({required Object error}) => '이벤트 정보 로딩에 실패했습니다: ${error}',
			'eventCalendar.filterActive' => ({required Object count}) => '필터 적용 중 (${count}건)',
			'eventCalendar.clear' => '초기화',
			'eventCalendar.noEvents' => '조건에 맞는 이벤트가 없습니다',
			'eventCalendar.clearFilter' => '필터 초기화',
			'eventCalendar.today' => '오늘',
			'eventCalendar.reminderSet' => '리마인더 설정',
			'eventCalendar.reminderSetDone' => '리마인더 설정됨',
			'eventCalendar.reminderDeleted' => '리마인더를 삭제했습니다',
			'eventCalendar.eventName' => '이벤트 이름',
			'eventCalendar.organizer' => '주최자',
			'eventCalendar.description' => '설명',
			'eventCalendar.genre' => '장르',
			'eventCalendar.condition' => '참가 조건',
			'eventCalendar.way' => '참가 방법',
			'eventCalendar.note' => '비고',
			'eventCalendar.quest' => 'Quest 대응',
			'eventCalendar.reminderCount' => ({required Object count}) => '${count}건',
			'eventCalendar.startToEnd' => ({required Object start, required Object end}) => '${start} ~ ${end}',
			'avatars.title' => '아바타',
			'avatars.searchHint' => '아바타 이름 등으로 검색',
			'avatars.searchTooltip' => '검색',
			'avatars.searchEmptyTitle' => '검색 결과를 찾을 수 없습니다',
			'avatars.searchEmptyDescription' => '다른 검색어로 시도해 주세요',
			'avatars.emptyTitle' => '아바타가 없습니다',
			'avatars.emptyDescription' => '아바타를 추가하거나 나중에 다시 시도해 주세요',
			'avatars.refresh' => '새로고침',
			'avatars.loading' => '아바타 로딩 중...',
			'avatars.error' => ({required Object error}) => '아바타 정보 로딩에 실패했습니다: ${error}',
			'avatars.current' => '사용 중',
			'avatars.public' => '공개',
			'avatars.private' => '비공개',
			'avatars.hidden' => '숨김',
			'avatars.author' => '제작자',
			'avatars.sortUpdated' => '업데이트 순',
			'avatars.sortName' => '이름 순',
			'avatars.sortTooltip' => '정렬',
			'avatars.viewModeTooltip' => '보기 모드 전환',
			'worldDetail.loading' => '월드 정보 로딩 중...',
			'worldDetail.error' => ({required Object error}) => '월드 정보 로딩에 실패했습니다: ${error}',
			'worldDetail.share' => '이 월드 공유하기',
			'worldDetail.openInVRChat' => 'VRChat 공식 웹사이트에서 열기',
			'worldDetail.report' => '이 월드 신고하기',
			'worldDetail.creator' => '제작자',
			'worldDetail.created' => '생성일',
			'worldDetail.updated' => '업데이트일',
			'worldDetail.favorites' => '즐겨찾기 수',
			'worldDetail.visits' => '방문 수',
			'worldDetail.occupants' => '현재 인원',
			'worldDetail.popularity' => '평가',
			'worldDetail.description' => '설명',
			'worldDetail.noDescription' => '설명이 없습니다',
			'worldDetail.tags' => '태그',
			'worldDetail.joinPublic' => '퍼블릭으로 초대 보내기',
			'worldDetail.favoriteAdded' => '즐겨찾기에 추가했습니다',
			'worldDetail.favoriteRemoved' => '즐겨찾기에서 삭제했습니다',
			'worldDetail.unknown' => '알 수 없음',
			'avatarDetail.changeSuccess' => ({required Object name}) => '아바타 \'${name}\'(으)로 변경했습니다',
			'avatarDetail.changeFailed' => ({required Object error}) => '아바타 변경에 실패했습니다: ${error}',
			'avatarDetail.changing' => '변경 중...',
			'avatarDetail.useThisAvatar' => '이 아바타 사용하기',
			'avatarDetail.creator' => '제작자',
			'avatarDetail.created' => '생성일',
			'avatarDetail.updated' => '업데이트일',
			'avatarDetail.description' => '설명',
			'avatarDetail.noDescription' => '설명이 없습니다',
			'avatarDetail.tags' => '태그',
			'avatarDetail.addToFavorites' => '즐겨찾기에 추가',
			'avatarDetail.public' => '공개',
			'avatarDetail.private' => '비공개',
			'avatarDetail.hidden' => '숨김',
			'avatarDetail.unknown' => '알 수 없음',
			'avatarDetail.share' => '공유',
			'avatarDetail.loading' => '아바타 정보 로딩 중...',
			'avatarDetail.error' => ({required Object error}) => '아바타 정보 로딩에 실패했습니다: ${error}',
			'groups.title' => '그룹',
			'groups.loadingUser' => '사용자 정보 로딩 중...',
			'groups.errorUser' => ({required Object error}) => '사용자 정보 로딩에 실패했습니다: ${error}',
			'groups.loadingGroups' => '그룹 정보 로딩 중...',
			'groups.errorGroups' => ({required Object error}) => '그룹 정보 로딩에 실패했습니다: ${error}',
			'groups.emptyTitle' => '가입한 그룹이 없습니다',
			'groups.emptyDescription' => 'VRChat 앱이나 웹사이트에서 그룹에 가입할 수 있습니다',
			'groups.searchGroups' => '그룹 찾기',
			'groups.members' => ({required Object count}) => '${count}명의 멤버',
			'groups.showDetails' => '상세 정보 보기',
			'groups.unknownName' => '이름 알 수 없음',
			'groupDetail.loading' => '그룹 정보 로딩 중...',
			'groupDetail.error' => ({required Object error}) => '그룹 정보 로딩에 실패했습니다: ${error}',
			'groupDetail.share' => '그룹 정보 공유',
			'groupDetail.description' => '설명',
			'groupDetail.roles' => '역할',
			'groupDetail.basicInfo' => '기본 정보',
			'groupDetail.createdAt' => '생성일',
			'groupDetail.owner' => '소유자',
			'groupDetail.rules' => '규칙',
			'groupDetail.languages' => '언어',
			'groupDetail.memberCount' => ({required Object count}) => '${count} 멤버',
			'groupDetail.privacy.public' => '공개',
			'groupDetail.privacy.private' => '비공개',
			'groupDetail.privacy.friends' => '친구',
			'groupDetail.privacy.invite' => '초대제',
			'groupDetail.privacy.unknown' => '알 수 없음',
			'groupDetail.role.admin' => '관리자',
			'groupDetail.role.moderator' => '모더레이터',
			'groupDetail.role.member' => '멤버',
			'groupDetail.role.unknown' => '알 수 없음',
			'inventory.title' => '인벤토리',
			'inventory.gallery' => '갤러리',
			'inventory.icon' => '아이콘',
			'inventory.emoji' => '이모지',
			'inventory.sticker' => '스티커',
			'inventory.print' => '프린트',
			'inventory.upload' => '파일 업로드',
			'inventory.uploadGallery' => '갤러리 이미지 업로드 중...',
			'inventory.uploadIcon' => '아이콘 업로드 중...',
			'inventory.uploadEmoji' => '이모지 업로드 중...',
			'inventory.uploadSticker' => '스티커 업로드 중...',
			'inventory.uploadPrint' => '프린트 이미지 업로드 중...',
			'inventory.selectImage' => '이미지 선택',
			'inventory.selectFromGallery' => '갤러리에서 선택',
			'inventory.takePhoto' => '카메라로 촬영',
			'inventory.uploadSuccess' => '업로드가 완료되었습니다',
			'inventory.uploadFailed' => '업로드에 실패했습니다',
			'inventory.uploadFailedFormat' => '파일 형식 또는 크기에 문제가 있습니다. PNG 형식의 1MB 이하 이미지를 선택해 주세요.',
			'inventory.uploadFailedAuth' => '인증에 실패했습니다. 다시 로그인해 주세요.',
			'inventory.uploadFailedSize' => '파일 크기가 너무 큽니다. 더 작은 이미지를 선택해 주세요.',
			'inventory.uploadFailedServer' => ({required Object code}) => '서버 오류가 발생했습니다 (${code})',
			'inventory.pickImageFailed' => ({required Object error}) => '이미지 선택에 실패했습니다: ${error}',
			'inventory.tabs.emojiInventory.loading' => '이모지 로딩 중...',
			'inventory.tabs.emojiInventory.error' => ({required Object error}) => '이모지 로딩에 실패했습니다: ${error}',
			'inventory.tabs.emojiInventory.emptyTitle' => '이모지가 없습니다',
			'inventory.tabs.emojiInventory.emptyDescription' => 'VRChat에서 업로드한 이모지가 여기에 표시됩니다',
			'inventory.tabs.emojiInventory.zoomHint' => '더블 탭으로 확대',
			'inventory.tabs.galleryInventory.loading' => '갤러리 로딩 중...',
			'inventory.tabs.galleryInventory.error' => ({required Object error}) => '갤러리 로딩에 실패했습니다: ${error}',
			'inventory.tabs.galleryInventory.emptyTitle' => '갤러리가 없습니다',
			'inventory.tabs.galleryInventory.emptyDescription' => 'VRChat에서 업로드한 갤러리가 여기에 표시됩니다',
			'inventory.tabs.galleryInventory.zoomHint' => '더블 탭으로 확대',
			'inventory.tabs.iconInventory.loading' => '아이콘 로딩 중...',
			'inventory.tabs.iconInventory.error' => ({required Object error}) => '아이콘 로딩에 실패했습니다: ${error}',
			'inventory.tabs.iconInventory.emptyTitle' => '아이콘이 없습니다',
			'inventory.tabs.iconInventory.emptyDescription' => 'VRChat에서 업로드한 아이콘이 여기에 표시됩니다',
			'inventory.tabs.iconInventory.zoomHint' => '더블 탭으로 확대',
			'inventory.tabs.printInventory.loading' => '프린트 로딩 중...',
			'inventory.tabs.printInventory.error' => ({required Object error}) => '프린트 로딩에 실패했습니다: ${error}',
			'inventory.tabs.printInventory.emptyTitle' => '프린트가 없습니다',
			'inventory.tabs.printInventory.emptyDescription' => 'VRChat에서 업로드한 프린트가 여기에 표시됩니다',
			'inventory.tabs.printInventory.zoomHint' => '더블 탭으로 확대',
			'inventory.tabs.stickerInventory.loading' => '스티커 로딩 중...',
			'inventory.tabs.stickerInventory.error' => ({required Object error}) => '스티커 로딩에 실패했습니다: ${error}',
			'inventory.tabs.stickerInventory.emptyTitle' => '스티커가 없습니다',
			'inventory.tabs.stickerInventory.emptyDescription' => 'VRChat에서 업로드한 스티커가 여기에 표시됩니다',
			'inventory.tabs.stickerInventory.zoomHint' => '더블 탭으로 확대',
			'vrcnsync.title' => 'VRCNSync (β)',
			'vrcnsync.betaTitle' => '베타 기능',
			'vrcnsync.betaDescription' => '이 기능은 개발 중인 베타 버전입니다. 예기치 않은 문제가 발생할 수 있습니다.\n현재는 로컬에서만 구현되어 있지만, 수요가 있으면 클라우드 버전을 구현할 예정입니다.',
			'vrcnsync.githubLink' => 'VRCNSync GitHub 페이지',
			'vrcnsync.openGithub' => 'GitHub 페이지 열기',
			'vrcnsync.serverRunning' => '서버 실행 중',
			'vrcnsync.serverStopped' => '서버 중지됨',
			'vrcnsync.serverRunningDesc' => 'PC의 사진을 VRCN 앨범에 저장합니다',
			'vrcnsync.serverStoppedDesc' => '서버가 중지되었습니다',
			'vrcnsync.photoSaved' => '사진을 VRCN 앨범에 저장했습니다',
			'vrcnsync.photoReceived' => '사진을 수신했습니다 (앨범 저장 실패)',
			'vrcnsync.openAlbum' => '앨범 열기',
			'vrcnsync.permissionErrorIos' => '사진 라이브러리에 대한 접근 권한이 필요합니다',
			'vrcnsync.permissionErrorAndroid' => '저장소에 대한 접근 권한이 필요합니다',
			'vrcnsync.openSettings' => '설정 열기',
			'vrcnsync.initError' => ({required Object error}) => '초기화에 실패했습니다: ${error}',
			'vrcnsync.openPhotoAppError' => '사진 앱을 열 수 없었습니다',
			'vrcnsync.serverInfo' => '서버 정보',
			'vrcnsync.ip' => ({required Object ip}) => 'IP: ${ip}',
			'vrcnsync.port' => ({required Object port}) => '포트: ${port}',
			'vrcnsync.address' => ({required Object ip, required Object port}) => '${ip}:${port}',
			'vrcnsync.autoSave' => '수신된 사진은 \'VRCN\' 앨범에 자동 저장됩니다',
			'vrcnsync.usage' => '사용 방법',
			'vrcnsync.usageSteps.0.title' => 'PC에서 VRCNSync 앱 실행',
			'vrcnsync.usageSteps.0.desc' => 'PC에서 VRCNSync 앱을 실행해 주세요',
			'vrcnsync.usageSteps.1.title' => '동일한 WiFi 네트워크에 연결',
			'vrcnsync.usageSteps.1.desc' => 'PC와 모바일 기기를 동일한 WiFi 네트워크에 연결해 주세요',
			'vrcnsync.usageSteps.2.title' => '연결 대상으로 모바일 기기 지정',
			'vrcnsync.usageSteps.2.desc' => 'PC 앱에서 위의 IP 주소와 포트를 지정해 주세요',
			'vrcnsync.usageSteps.3.title' => '사진 전송',
			'vrcnsync.usageSteps.3.desc' => 'PC에서 사진을 전송하면 자동으로 VRCN 앨범에 저장됩니다',
			'vrcnsync.stats' => '연결 상태',
			'vrcnsync.statServer' => '서버 상태',
			'vrcnsync.statServerRunning' => '실행 중',
			'vrcnsync.statServerStopped' => '중지됨',
			'vrcnsync.statNetwork' => '네트워크',
			'vrcnsync.statNetworkConnected' => '연결됨',
			'vrcnsync.statNetworkDisconnected' => '연결 안 됨',
			'feedback.title' => '피드백',
			'feedback.type' => '피드백 유형',
			'feedback.types.bug' => '버그 신고',
			'feedback.types.feature' => '기능 요청',
			'feedback.types.improvement' => '개선 제안',
			'feedback.types.other' => '기타',
			'feedback.inputTitle' => '제목 *',
			'feedback.inputTitleHint' => '간결하게 작성해 주세요',
			'feedback.inputDescription' => '상세 설명 *',
			'feedback.inputDescriptionHint' => '자세한 설명을 작성해 주세요...',
			'feedback.cancel' => '취소',
			'feedback.send' => '전송',
			'feedback.sending' => '전송 중...',
			'feedback.required' => '제목과 상세 설명은 필수 항목입니다',
			'feedback.success' => '피드백을 전송했습니다. 감사합니다!',
			'feedback.fail' => '피드백 전송에 실패했습니다',
			'settings.appearance' => '화면',
			'settings.language' => '언어',
			'settings.languageDescription' => '앱의 표시 언어를 선택할 수 있습니다.',
			'settings.appIcon' => '앱 아이콘',
			'settings.appIconDescription' => '홈 화면에 표시되는 앱 아이콘을 변경합니다',
			'settings.contentSettings' => '콘텐츠 설정',
			'settings.searchEnabled' => '검색 기능이 활성화되었습니다',
			'settings.searchDisabled' => '검색 기능이 비활성화되었습니다',
			'settings.enableSearch' => '검색 기능 활성화',
			'settings.enableSearchDescription' => '검색 결과에 성적인 콘텐츠나 폭력적인 콘텐츠가 표시될 수 있습니다.',
			'settings.apiSetting' => '아바타 검색 API',
			'settings.apiSettingDescription' => '아바타 검색 기능의 API를 설정합니다',
			'settings.apiSettingSaveUrl' => 'URL을 저장했습니다',
			'settings.notSet' => '설정되지 않음 (아바타 검색 기능을 사용할 수 없습니다)',
			'settings.notifications' => '알림 설정',
			'settings.eventReminder' => '이벤트 리마인더',
			'settings.eventReminderDescription' => '설정한 이벤트 시작 전에 알림을 받습니다',
			'settings.manageReminders' => '설정된 리마인더 관리',
			'settings.manageRemindersDescription' => '알림 취소 및 확인이 가능합니다',
			'settings.dataStorage' => '데이터 및 저장 공간',
			'settings.clearCache' => '캐시 삭제',
			'settings.clearCacheSuccess' => '캐시를 삭제했습니다',
			'settings.clearCacheError' => '캐시 삭제 중 오류가 발생했습니다',
			'settings.cacheSize' => ({required Object size}) => '캐시 크기: ${size}',
			'settings.calculatingCache' => '캐시 크기 계산 중...',
			'settings.cacheError' => '캐시 크기를 가져올 수 없었습니다',
			'settings.confirmClearCache' => '캐시를 삭제하면 임시로 저장된 이미지나 데이터가 삭제됩니다.\n\n계정 정보나 앱 설정은 삭제되지 않습니다.',
			'settings.appInfo' => '앱 정보',
			'settings.version' => '버전',
			'settings.packageName' => '패키지 이름',
			'settings.credit' => '크레딧',
			'settings.creditDescription' => '개발자·기여자 정보',
			'settings.contact' => '문의하기',
			'settings.contactDescription' => '버그 신고·의견은 여기로',
			'settings.privacyPolicy' => '개인정보처리방침',
			'settings.privacyPolicyDescription' => '개인정보 취급에 대하여',
			'settings.termsOfService' => '이용약관',
			'settings.termsOfServiceDescription' => '앱 이용 조건',
			'settings.openSource' => '오픈소스 정보',
			'settings.openSourceDescription' => '사용 중인 라이브러리 등의 라이선스',
			'settings.github' => 'GitHub 리포지토리',
			'settings.githubDescription' => '소스 코드 보기',
			'settings.logoutConfirm' => '로그아웃하시겠습니까?',
			'settings.logoutError' => ({required Object error}) => '로그아웃 중 오류가 발생했습니다: ${error}',
			'settings.iconChangeNotSupported' => '사용 중인 기기에서는 앱 아이콘 변경을 지원하지 않습니다',
			'settings.iconChangeFailed' => '아이콘 변경에 실패했습니다',
			'settings.themeMode' => '테마 모드',
			'settings.themeModeDescription' => '앱의 표시 테마를 선택할 수 있습니다',
			'settings.themeLight' => '밝게',
			_ => null,
		} ?? switch (path) {
			'settings.themeSystem' => '시스템',
			'settings.themeDark' => '어둡게',
			'settings.appIconDefault' => '기본',
			'settings.appIconIcon' => '아이콘',
			'settings.appIconLogo' => '로고',
			'settings.delete' => '삭제하기',
			'credits.title' => '크레딧',
			'credits.section.development' => '개발',
			'credits.section.iconPeople' => '재미있는 아이콘 제공자들',
			'credits.section.testFeedback' => '테스트·피드백',
			'credits.section.specialThanks' => '스페셜 땡스',
			'download.success' => '다운로드가 완료되었습니다',
			'download.failure' => ({required Object error}) => '다운로드에 실패했습니다: ${error}',
			'download.shareFailure' => ({required Object error}) => '공유에 실패했습니다: ${error}',
			'download.permissionTitle' => '권한이 필요합니다',
			'download.permissionDenied' => ({required Object permissionType}) => '${permissionType}에 대한 저장 권한이 거부되었습니다.\n설정 앱에서 권한을 활성화해 주세요.',
			'download.permissionCancel' => '취소',
			'download.permissionOpenSettings' => '설정 열기',
			'download.permissionPhoto' => '사진',
			'download.permissionPhotoLibrary' => '사진 라이브러리',
			'download.permissionStorage' => '저장 공간',
			'download.permissionPhotoRequired' => '사진에 대한 저장 권한이 필요합니다',
			'download.permissionPhotoLibraryRequired' => '사진 라이브러리에 대한 저장 권한이 필요합니다',
			'download.permissionStorageRequired' => '저장 공간에 대한 접근 권한이 필요합니다',
			'download.permissionError' => ({required Object error}) => '권한 확인 중 오류가 발생했습니다: ${error}',
			'download.downloading' => ({required Object fileName}) => '${fileName} 다운로드 중...',
			'download.sharing' => ({required Object fileName}) => '${fileName} 공유 준비 중...',
			'instance.type.public' => '퍼블릭',
			'instance.type.hidden' => '프렌드+',
			'instance.type.friends' => '프렌드',
			'instance.type.private' => '인바이트+',
			'instance.type.unknown' => '알 수 없음',
			'status.active' => '온라인',
			'status.joinMe' => '누구나 와요',
			'status.askMe' => '물어보세요',
			'status.busy' => '바쁨',
			'status.offline' => '오프라인',
			'status.unknown' => '상태 알 수 없음',
			'location.private' => '프라이빗',
			'location.playerCount' => ({required Object userCount, required Object capacity}) => '플레이어 수: ${userCount} / ${capacity}',
			'location.instanceType' => ({required Object type}) => '인스턴스 타입: ${type}',
			'location.noInfo' => '위치 정보가 없습니다',
			'location.fetchError' => '위치 정보 로딩에 실패했습니다',
			'location.privateLocation' => '프라이빗한 장소에 있습니다',
			'location.inviteSending' => '초대 보내는 중...',
			'location.inviteSent' => '초대를 보냈습니다. 알림에서 참여할 수 있습니다',
			'location.inviteFailed' => ({required Object error}) => '초대 보내기에 실패했습니다: ${error}',
			'location.inviteButton' => '나에게 초대 보내기',
			'location.isPrivate' => ({required Object number}) => '${number}명이 비공개',
			'location.isActive' => ({required Object number}) => '${number}명이 활동 중',
			'location.isOffline' => ({required Object number}) => '${number}명이 오프라인',
			'location.isTraveling' => ({required Object number}) => '${number}명이 이동 중',
			'location.isStaying' => ({required Object number}) => '${number}명이 체류 중',
			'reminder.dialogTitle' => '리마인더 설정',
			'reminder.alreadySet' => '설정됨',
			'reminder.set' => '설정하기',
			'reminder.cancel' => '취소',
			'reminder.delete' => '삭제하기',
			'reminder.deleteAll' => '모든 리마인더 삭제',
			'reminder.deleteAllConfirm' => '설정한 모든 이벤트 리마인더를 삭제합니다. 이 작업은 되돌릴 수 없습니다.',
			'reminder.deleted' => '리마인더를 삭제했습니다',
			'reminder.deletedAll' => '모든 리마인더를 삭제했습니다',
			'reminder.noReminders' => '설정된 리마인더가 없습니다',
			'reminder.setFromEvent' => '이벤트 페이지에서 알림을 설정할 수 있습니다',
			'reminder.eventStart' => ({required Object time}) => '${time} 시작',
			'reminder.notifyAt' => ({required Object time, required Object label}) => '${time} (${label})',
			'reminder.receiveNotification' => '언제 알림을 받으시겠습니까?',
			'friend.sortFilter' => '정렬·필터',
			'friend.filter' => '필터',
			'friend.filterAll' => '모두 표시',
			'friend.filterOnline' => '온라인만',
			'friend.filterOffline' => '오프라인만',
			'friend.filterFavorite' => '즐겨찾기만',
			'friend.sort' => '정렬',
			'friend.sortStatus' => '온라인 상태 순',
			'friend.sortName' => '이름 순',
			'friend.sortLastLogin' => '마지막 로그인 순',
			'friend.sortAsc' => '오름차순',
			'friend.sortDesc' => '내림차순',
			'friend.close' => '닫기',
			'eventCalendarFilter.filterTitle' => '이벤트 필터링',
			'eventCalendarFilter.clear' => '초기화',
			'eventCalendarFilter.keyword' => '키워드 검색',
			'eventCalendarFilter.keywordHint' => '이벤트 이름, 설명, 주최자 등',
			'eventCalendarFilter.date' => '날짜로 필터링',
			'eventCalendarFilter.dateHint' => '특정 날짜 범위의 이벤트를 표시할 수 있습니다',
			'eventCalendarFilter.startDate' => '시작일',
			'eventCalendarFilter.endDate' => '종료일',
			'eventCalendarFilter.select' => '선택해 주세요',
			'eventCalendarFilter.time' => '시간대로 필터링',
			'eventCalendarFilter.timeHint' => '특정 시간대에 개최되는 이벤트를 표시할 수 있습니다',
			'eventCalendarFilter.startTime' => '시작 시간',
			'eventCalendarFilter.endTime' => '종료 시간',
			'eventCalendarFilter.genre' => '장르로 필터링',
			'eventCalendarFilter.genreSelected' => ({required Object count}) => '${count}개의 장르 선택 중',
			'eventCalendarFilter.apply' => '적용하기',
			'eventCalendarFilter.filterSummary' => '필터',
			'eventCalendarFilter.filterNone' => '필터가 설정되지 않았습니다',
			_ => null,
		};
	}
}
