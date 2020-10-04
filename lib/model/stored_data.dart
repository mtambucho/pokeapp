class StoredData {
  // when the onboarding page was showed
  final bool onBoardingShowed;

  StoredData({this.onBoardingShowed});

  Map<String, dynamic> get map => {
        'onBoardingShowed': onBoardingShowed,
      };

  factory StoredData.fromJson(Map<String, dynamic> parsedJson) {
    return StoredData(
      onBoardingShowed: parsedJson['onBoardingShowed'],
    );
  }
}
