import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerPlaceholder extends StatelessWidget {
  final int itemCount;

  const ShimmerPlaceholder({
    Key key,
    this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300],
              highlightColor: Colors.grey[100],
              child: itemCount != null
                  ? ListView.builder(
                      itemBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: SizedBox(
                          height: 200,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              Card(
                                margin: const EdgeInsets.all(5),
                                color: Colors.white54,
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 5,
                                  left: 5,
                                  child: Container(
                                    color: Colors.black,
                                    height: 40,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      itemCount: itemCount ?? 20,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                                height: 150, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 20, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 20, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.transparent, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.transparent, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.transparent, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.transparent, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.transparent, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.transparent, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.transparent, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.transparent, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.transparent, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.transparent, margin: const EdgeInsets.all(5)),
                            Container(
                                height: 5, color: Colors.black, margin: const EdgeInsets.all(5)),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
