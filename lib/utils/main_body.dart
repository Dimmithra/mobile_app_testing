import 'package:flutter/material.dart';
import 'package:mobile_app_test/utils/colors.dart';

class MainBodyScreen extends StatefulWidget {
  const MainBodyScreen({
    super.key,
    this.appBarTitle,
    this.appBarbackgroundColor,
    this.centerTitle = true,
    this.automaticallyImplyLeading,
    required this.container,
    this.toolbarHeight,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.appbar = true,
    this.actions,
    this.floatingActionButton,
  });
  final Widget? appBarTitle;
  final Color? appBarbackgroundColor;
  final bool? centerTitle;
  final bool? automaticallyImplyLeading;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget container;
  final double? toolbarHeight;
  final Widget? bottomNavigationBar;
  final bool? appbar;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  @override
  State<MainBodyScreen> createState() => _MainBodyScreenState();
}

class _MainBodyScreenState extends State<MainBodyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCommenBackground,
      bottomNavigationBar: widget.bottomNavigationBar,
      endDrawer: widget.endDrawer,
      floatingActionButton: widget.floatingActionButton,
      drawer: widget.drawer,
      appBar: widget.appbar == true
          ? AppBar(
              actions: widget.actions,
              toolbarHeight: widget.toolbarHeight,
              title: widget.appBarTitle,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: kDefTextColor,
                fontSize: 18,
              ),
              backgroundColor: kAppBarColor ?? widget.appBarbackgroundColor,
              centerTitle: widget.centerTitle,
              automaticallyImplyLeading:
                  widget.automaticallyImplyLeading ?? false,
            )
          : null,
      body: widget.appbar == false
          ? SafeArea(child: widget.container)
          : widget.container,
    );
  }
}
