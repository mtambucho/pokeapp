import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokeapp/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:pokeapp/util/assets.dart';
import 'package:pokeapp/util/custom_colors.dart';
import 'package:pokeapp/util/strings.dart';

class OnBoardingPage extends StatefulWidget {
  OnBoardingPage({Key key}) : super(key: key);
  static const routeName = '/onboardingRoute';

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  List<Widget> _buildPageIndicator(int numPages) {
    var list = <Widget>[];
    for (var i = 0; i < numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.yellow.shade800 : Colors.grey.shade600,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _numPages = 3;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Colors.grey.shade200,
                Colors.grey.shade100,
                Colors.grey.shade200,
                Colors.grey.shade300,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: PageView(
                      physics: ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        _pageOne(),
                        _pageTwo(),
                        _pageThree(),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(_numPages),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? Container(
              height: 80.0,
              width: double.infinity,
              color: Colors.white,
              child: FlatButton(
                onPressed: () => BlocProvider.of<AuthenticationBloc>(context)
                    .add(FinishOnBoarding()),
                child: Text(
                  Strings.done,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColors.blue,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          : Text(''),
    );
  }

  Widget _pageOne() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
        ),
        Image.asset(
          Assets.logoAsset,
          height: 100,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * .05,
        ),
        Text(
          Strings.welcome,
          style: TextStyle(
              color: CustomColors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * .2,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            Strings.welcomeText,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: CustomColors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
        ),
        Spacer(),
        Text(
          Strings.learnMore,
          style: TextStyle(
              color: Colors.grey.shade600,
              fontStyle: FontStyle.italic,
              fontSize: 20),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
        )
      ],
    );
  }

  Widget _pageTwo() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidget(
            imageAsset: Assets.scrollAsset,
            text: Strings.scrollText,
          )
        ],
      ),
    );
  }

  Widget _pageThree() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageWidget(
            imageAsset: Assets.tapAsset,
            text: Strings.tapText,
          )
        ],
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  ImageWidget({@required this.imageAsset, @required this.text, Key key})
      : assert(imageAsset != null),
        assert(text != null),
        super(key: key);

  final String imageAsset;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: CustomColors.onboardingYellow,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.symmetric(vertical: 100),
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          Image.asset(imageAsset, height: 100, fit: BoxFit.fitWidth),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 30),
            child: Text(
              text,
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade800, fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
