import 'package:flutter/material.dart';

import 'content.dart';

class ContentList extends StatefulWidget {
  final List<Content> _contents;

  const ContentList(this._contents, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<ContentList> createState() => _ContentListState(_contents);
}

class _ContentListState extends State<ContentList> {
  _ContentListState(this._contents);

  List<Content> _contents;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          itemCount: _contents.length,
          itemBuilder: (ctx, media) {
            return Card(
              child: Column(
                children: <Widget>[
                  ExpansionTile(
                    tilePadding: EdgeInsets.only(
                        left: 60, right: 25, top: 50, bottom: 50),
                    title: Text(_contents[media].name),
                    subtitle: Text(_contents[media].description),
                    childrenPadding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    children: <Widget>[
                      RichText(
                        textAlign: TextAlign.justify,
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                            const TextSpan(
                                text: "Résumé : ",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: "desc"),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  IconButton(
                    icon: Icon(_contents[media].favorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    tooltip: 'Favoris',
                    onPressed: () {
                      var content2 = _contents.toList();

                      content2[media].favorite = (!content2[media].favorite);
                      setState(() {
                        _contents = content2;
                      });
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
