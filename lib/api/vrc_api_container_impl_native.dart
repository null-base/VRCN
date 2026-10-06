import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vrchat/api/vrc_api_container_impl_base.dart';
import 'package:vrchat/api/instance_response_sanitizer.dart';
import 'package:vrchat/api/notification_response_sanitizer.dart';
import 'package:vrchat_dart/vrchat_dart.dart';

class VrcApiContainerImpl extends VrcApiContainerImplBase {
  @override
  Future<VrchatDart> create() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;

    final api = VrchatDart(
      userAgent: VrchatUserAgent(
        applicationName: 'VRCN',
        version: packageInfo.version,
        contactInfo: 'null@null-base.com',
      ),
      cookiePath: appDocPath,
    );

    api.rawApi.dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          InstanceResponseSanitizer.sanitize(
            response.requestOptions.path,
            response.data,
          );
          NotificationResponseSanitizer.sanitize(
            response.requestOptions.path,
            response.data,
          );
          handler.next(response);
        },
      ),
    );

    return api;
  }
}
