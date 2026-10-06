import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vrchat/api/vrchat_profile_api.dart';
import 'package:vrchat/controllers/profile_edit_controller.dart';
import 'package:vrchat/provider/app_features_provider.dart';
import 'package:vrchat/provider/notification_provider.dart';
import 'package:vrchat/provider/user_provider.dart';
import 'package:vrchat/provider/vrchat_api_provider.dart';
import 'package:vrchat/provider/vrchat_extended_api_provider.dart';
import 'package:vrchat_dart/vrchat_dart.dart';
import 'package:vrchat_dart_generated/vrchat_dart_generated.dart' hide Response;

void main() {
  test('group membership actions use the expected requests', () async {
    final requests = <dio.RequestOptions>[];
    final api = _recordingApi(requests);
    final container = ProviderContainer(
      overrides: [
        vrchatRawApiProvider.overrideWith((ref) async => api),
      ],
    );
    addTearDown(container.dispose);

    final actions = container.read(groupActionsProvider);
    await actions.join('grp_example');
    await actions.leave('grp_example');
    await actions.ban('grp_example', 'usr_example');
    await actions.unban('grp_example', 'usr_example');

    expect(
      requests.map((request) => '${request.method} ${request.path}'),
      [
        'POST /groups/grp_example/join',
        'POST /groups/grp_example/leave',
        'POST /groups/grp_example/bans',
        'DELETE /groups/grp_example/bans/usr_example',
      ],
    );
    expect(
      jsonDecode(requests[2].data as String),
      {'userId': 'usr_example'},
    );
  });

  test(
    'marking a notification read uses the v2 acknowledge endpoint',
    () async {
      final requests = <dio.RequestOptions>[];
      final container = ProviderContainer(
        overrides: [
          vrchatRawApiProvider.overrideWith(
            (ref) async => _recordingApi(requests),
          ),
        ],
      );
      addTearDown(container.dispose);

      await container
          .read(notificationActionsProvider)
          .markAsRead('not_example');

      expect(requests.single.method, 'POST');
      expect(requests.single.path, '/notifications/not_example/see');
    },
  );

  test('status updates use the user endpoint', () async {
    final requests = <dio.RequestOptions>[];
    final api = _recordingApi(requests);

    await api.getUsersApi().updateUser(
      userId: 'usr_example',
      updateUserRequest: UpdateUserRequest(
        status: UserStatus.busy,
        statusDescription: 'Testing status updates',
      ),
    );

    expect(requests.single.method, 'PUT');
    expect(requests.single.path, '/users/usr_example');
    expect(jsonDecode(requests.single.data as String), {
      'status': 'busy',
      'statusDescription': 'Testing status updates',
    });
  });

  test(
    'profile edit controller sends user and public profile updates',
    () async {
      final user = _TestCurrentUser();
      final profileApi = _RecordingProfileApi();
      UpdateUserRequest? userRequest;
      final container = ProviderContainer(
        overrides: [
          currentUserProvider.overrideWith((ref) async => user),
          updateUserProvider.overrideWith((ref, request) async {
            userRequest = request;
            return user;
          }),
          vrchatProfileApiProvider.overrideWith((ref) async => profileApi),
        ],
      );
      addTearDown(container.dispose);

      await container
          .read(profileEditControllerProvider)
          .save(
            const ProfileEditInput(
              status: UserStatus.askMe,
              statusDescription: 'Available for a chat',
              bio: 'Profile bio',
              bioLinks: [' https://example.com ', ''],
              pronouns: 'they/them',
            ),
          );

      expect(userRequest?.status, UserStatus.askMe);
      expect(userRequest?.statusDescription, 'Available for a chat');
      expect(userRequest?.pronouns, 'they/them');
      expect(profileApi.updatedUserId, 'usr_example');
      expect(profileApi.updateRequest?.bio, 'Profile bio');
      expect(profileApi.updateRequest?.bioLinks, ['https://example.com']);
    },
  );
}

VrchatDartGenerated _recordingApi(List<dio.RequestOptions> requests) {
  final client =
      dio.Dio(
          dio.BaseOptions(baseUrl: 'https://example.invalid/api/1'),
        )
        ..interceptors.add(
          dio.InterceptorsWrapper(
            onRequest: (options, handler) {
              requests.add(options);
              handler.resolve(
                dio.Response<dynamic>(
                  requestOptions: options,
                  statusCode: 200,
                  data: null,
                ),
              );
            },
          ),
        );
  return VrchatDartGenerated(dio: client, interceptors: const []);
}

class _TestCurrentUser implements CurrentUser {
  @override
  String get id => 'usr_example';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _RecordingProfileApi extends VrchatProfileApi {
  _RecordingProfileApi() : super(VrchatDartGenerated().getUsersApi());

  String? updatedUserId;
  UpdateProfileRequest? updateRequest;

  @override
  Future<PublicProfile> updateProfile(
    String userId,
    UpdateProfileRequest request,
  ) async {
    updatedUserId = userId;
    updateRequest = request;
    return PublicProfile();
  }
}
