import 'package:flutter/widgets.dart';

import 'content.dart';

class ContentList extends StatefulWidget {

  final List<Content> _contents;

  ContentList(this._contents);

  @override
  State<ContentList> createState() => _ContentListState(_contents);
}

class _ContentListState extends State<ContentList> {
  _ContentListState(this._contents);