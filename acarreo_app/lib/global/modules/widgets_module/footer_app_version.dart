import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FooterAppVersion extends StatefulWidget {
  final EdgeInsetsGeometry? padding;
  const FooterAppVersion({
    super.key,
    this.padding,
  });

  @override
  State<FooterAppVersion> createState() => _FooterAppVersionState();
}

class _FooterAppVersionState extends State<FooterAppVersion> {
  PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.only(top: 16.0),
      child: Center(
        child: Text(
          'Version: ${packageInfo.version} • Build: ${packageInfo.buildNumber}',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
