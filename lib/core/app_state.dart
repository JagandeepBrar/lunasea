import 'package:redux/redux.dart';

final appReducer = combineReducers<AppState>([

]);

class AppState {
    AppState();
    factory AppState.initialState() => AppState();
}
