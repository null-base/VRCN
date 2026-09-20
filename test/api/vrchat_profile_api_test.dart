import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vrchat/api/vrchat_profile_api.dart';
import 'package:vrchat_dart_generated/vrchat_dart_generated.dart' hide Response;

void main() {
  late Dio dio;
  late List<RequestOptions> requests;

  setUp(() {
    requests = [];
    dio = Dio()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            requests.add(options);
            handler.resolve(
              Response<Map<String, dynamic>>(
                requestOptions: options,
                statusCode: 200,
                data: {'id': 'usr_example'},
              ),
            );
          },
        ),
      );
  });

  test('requests a public profile with the v1.21 query parameter', () async {
    final profile = await VrchatProfileApi(UsersApi(dio)).getPublicProfile(
      'usr_example',
      asSelf: true,
    );

    expect(profile.id, 'usr_example');
    expect(requests.single.path, '/profile/usr_example');
    expect(requests.single.queryParameters, {'asSelf': true});
  });

  test('updates profile fields through the profile endpoint', () async {
    await VrchatProfileApi(UsersApi(dio)).updateProfile(
      'usr_example',
      UpdateProfileRequest(
        bio: 'Hello',
        bioLinks: ['https://example.com'],
      ),
    );

    expect(requests.single.method, 'PUT');
    expect(requests.single.path, '/profile/usr_example');
    expect(
      requests.single.data,
      '{"bio":"Hello","bioLinks":["https://example.com"]}',
    );
  });
}
