class StoredData {
  // when the onboarding page was showed
  final bool onBoardingShowed;
  final bool loggedIn;

  StoredData({this.onBoardingShowed = false, this.loggedIn = false});

  Map<String, dynamic> get map => {
        'onBoardingShowed': onBoardingShowed,
        'loggedIn': loggedIn,
      };

  factory StoredData.fromJson(Map<String, dynamic> parsedJson) {
    return StoredData(
      onBoardingShowed: parsedJson['onBoardingShowed'],
      loggedIn: parsedJson['loggedIn'],
    );
  }

  StoredData copyWith({bool onBoardingShowed, bool loggedIn}) {
    return StoredData(
        loggedIn: loggedIn ?? this.loggedIn,
        onBoardingShowed: onBoardingShowed ?? this.onBoardingShowed);
  }
}
