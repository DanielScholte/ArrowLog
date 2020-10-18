import 'dart:io';

import 'package:arrow_log/utils/urls.dart';
import 'package:arrow_log/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ArrowLogAppBar(
        title: 'About',
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0, left: 4.0, right: 4.0, bottom: 4.0),
            child: Image.asset(
              'assets/logo.png',
              width: 80.0,
              height: 80.0,
            ),
          ),
          Text(
            'ArrowLog',
            style: Theme.of(context).textTheme.headline1.copyWith(
              color: Theme.of(context).textTheme.headline2.color,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            'By Daniël Scholte',
            style: Theme.of(context).textTheme.bodyText1,
            textAlign: TextAlign.center,
          ),
          _getAppVersion(),
          Padding(
            padding: EdgeInsets.only(top: 4.0),
            child: _buildOptions(),
          )
        ],
      ),
    );
  }

  Widget _buildOptions() {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Platform.isIOS ? FontAwesomeIcons.appStoreIos : FontAwesomeIcons.googlePlay
          ),
          title: Text(
            'Rate the app on the ${Platform.isIOS ? 'App Store' : 'Play Store'}'
          ),
          trailing: Icon(
            FontAwesomeIcons.chevronRight,
            size: 20,
          ),
          onTap: () => Urls.launchURL(Platform.isIOS ? Urls.appStoreUrl : Urls.playStoreUrl),
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.github
          ),
          title: Text(
            'View the project on Github'
          ),
          trailing: Icon(
            FontAwesomeIcons.chevronRight,
            size: 20,
          ),
          onTap: () => Urls.launchURL(Urls.githubUrl),
        ),
        ListTile(
          leading: Icon(
            FontAwesomeIcons.envelope
          ),
          title: Text(
            'Send us feedback'
          ),
          trailing: Icon(
            FontAwesomeIcons.chevronRight,
            size: 20,
          ),
          onTap: () => Urls.launchURL(Urls.emailUrl),
        ),
      ],
    );
  }

  Widget _getAppVersion() {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Container();
        }

        if (!snapshot.hasData) {
          return Container(
            width: 32.0,
            height: 32.0,
            child: CircularProgressIndicator(),
          );
        }

        return Text(
          'Version ${snapshot.data.version} - Build ${snapshot.data.buildNumber}',
          style: Theme.of(context).textTheme.bodyText1,
          textAlign: TextAlign.center,
        );
      },
    );
  }
}