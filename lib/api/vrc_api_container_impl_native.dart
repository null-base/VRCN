import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vrchat/api/vrc_api_container_impl_base.dart';
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

    return api;
  }
}
