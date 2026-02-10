class AppState {
  int  selectPageRoot;
  bool showButton;
  AppState({this.selectPageRoot = 0 , this.showButton = true});

  AppState copyWith({int? selectPageRoot , bool ? showButton}) {
    return AppState(selectPageRoot: selectPageRoot ?? this.selectPageRoot , showButton: showButton??this.showButton);
  }
}
