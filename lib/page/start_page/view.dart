import 'package:fish_demo/actions/adapt.dart';
import 'package:fish_demo/widgets/keepalive_widget.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'dart:ui' as ui;

import 'state.dart';

Widget buildView(
    StartPageState state, Dispatch dispatch, ViewService viewService) {
  final Map<int, bool> _movieGenres = Map<int, bool>();
  final Map<int, bool> _tvGenres = Map<int, bool>();

  final pages = [
    _FirstPage(
      continueTapped: () => state.pageController
          .nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease),
    ),
    _SubscribeTopicPage(
        title: '1.?',
        buttonTitle: ' >',
        tag: 'movie_',
        isMovie: true,
        genres: _movieGenres,
        backTapped: () => state.pageController.previousPage(
            duration: Duration(milliseconds: 400), curve: Curves.ease),
        nextTapped: () {

        }),
    _SubscribeTopicPage(
        title: '2.{I18n.of(viewService.context).whatKindOfTvShowDoYouLike}?',
        buttonTitle: '{I18n.of(viewService.context).start} >',
        tag: 'tvshow_',
        isMovie: false,
        genres: _tvGenres,
        backTapped: () => state.pageController.previousPage(
            duration: Duration(milliseconds: 400), curve: Curves.ease),
        nextTapped: () {

        }),
  ];

  Widget _buildPage(Widget page) {
    return keepAliveWrapper(page);
  }

  return Scaffold(
    body: FutureBuilder(
        future: _checkContextInit(
          Stream<double>.periodic(Duration(milliseconds: 50),
              (x) => MediaQuery.of(viewService.context).size.height),
        ),
        builder: (_, snapshot) {
          if (snapshot.hasData) if (snapshot.data > 0) {
            Adapt.initContext(viewService.context);
            if (state.isFirstTime != true)
              return Container();
            else
              return PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: state.pageController,
                allowImplicitScrolling: false,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(pages[index]);
                },
              );
          }
          return Container();
        }),
  );
}

Future<double> _checkContextInit(Stream<double> source) async {
  await for (double value in source) {
    if (value > 0) {
      return value;
    }
  }
  return 0.0;
}

class _FirstPage extends StatelessWidget {
  final Function continueTapped;
  const _FirstPage({this.continueTapped});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: Adapt.px(300)),
        SizedBox(
            width: Adapt.screenW(),
            height: Adapt.px(500),
            child: Lottie.asset(
              'images/landscape.json', //Lottie.network(https://assets4.lottiefiles.com/packages/lf20_umBOmV.json')
            )),
        Text(
          '{I18n.of(context).welcome},',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: Adapt.px(20)),
        Text(
          '{I18n.of(context).letStartWithFewSteps}.',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Expanded(child: SizedBox()),
        GestureDetector(
            onTap: continueTapped,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
              height: 60,
              decoration: BoxDecoration(
                  color: const Color(0xFF202F39),
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                  child: Text(
                "I18n.of(context).continueA",
                style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )),
            )),
        SizedBox(height: Adapt.px(20))
      ]),
    ));
  }
}

class _SubscribeTopicPage extends StatefulWidget {
  final String title;
  final String buttonTitle;
  final bool isMovie;
  final String tag;
  final Function backTapped;
  final Function nextTapped;
  final Map<int, bool> genres;
  _SubscribeTopicPage(
      {this.backTapped,
      this.nextTapped,
      this.genres,
      this.isMovie,
      @required this.title,
      @required this.buttonTitle,
      this.tag});
  @override
  _SubscribeTopicPageState createState() => _SubscribeTopicPageState();
}

class _SubscribeTopicPageState extends State<_SubscribeTopicPage> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: Adapt.px(80)),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            )),
        SizedBox(height: Adapt.px(60)),

        Row(children: [
          SizedBox(width: Adapt.px(80)),
          InkWell(
              onTap: widget.backTapped,
              child: SizedBox(
                  width: Adapt.px(100),
                  height: Adapt.px(80),
                  child: Center(
                    child: Text("I18n.of(context).back",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                  ))),
          Expanded(child: SizedBox()),
          GestureDetector(
              onTap: () async {
                widget.nextTapped();
              },
              child: Container(
                width: Adapt.px(250),
                margin: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
                height: 60,
                decoration: BoxDecoration(
                    color: const Color(0xFF202F39),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Text(
                  widget.buttonTitle,
                  style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )),
              )),
        ]),
        SizedBox(height: Adapt.px(20))
      ]),
    ));
  }
}
