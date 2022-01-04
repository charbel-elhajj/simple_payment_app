import 'package:flutter/material.dart';
import 'package:simple_payment_app/widgets/wrapper.dart';

import '../../styles/colors.dart';
import '../../styles/spacings.dart';

class WhiteScaffold extends StatelessWidget {
  final String appBarTitle;
  final Widget body;
  final bool hasWrapper;

  const WhiteScaffold({
    Key? key,
    required this.appBarTitle,
    required this.body,
    this.hasWrapper = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: hasWrapper
          ? Wrapper(
              horizontalPadding: getSpacing(4),
              child: body,
            )
          : body,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        appBarTitle,
        style: Theme.of(context).textTheme.headline1,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: Container(
          color: greyColor,
          height: 1.0,
        ),
      ),
    );
  }
}
