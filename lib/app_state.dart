import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/lat_lng.dart';
import 'dart:convert';

class FFAppState extends ChangeNotifier {
  static final FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal() {
    initializePersistedState();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _namesOfGame = prefs.getStringList('ff_namesOfGame') ?? _namesOfGame;
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  bool _editProfile = false;
  bool get editProfile => _editProfile;
  set editProfile(bool _value) {
    _editProfile = _value;
  }

  List<String> _namesOfGame = ['Guess the author', 'Guess from the picture'];
  List<String> get namesOfGame => _namesOfGame;
  set namesOfGame(List<String> _value) {
    _namesOfGame = _value;
    prefs.setStringList('ff_namesOfGame', _value);
  }

  void addToNamesOfGame(String _value) {
    _namesOfGame.add(_value);
    prefs.setStringList('ff_namesOfGame', _namesOfGame);
  }

  void removeFromNamesOfGame(String _value) {
    _namesOfGame.remove(_value);
    prefs.setStringList('ff_namesOfGame', _namesOfGame);
  }

  void removeAtIndexFromNamesOfGame(int _index) {
    _namesOfGame.removeAt(_index);
    prefs.setStringList('ff_namesOfGame', _namesOfGame);
  }

  List<String> _typeOfGame = ['books', 'images'];
  List<String> get typeOfGame => _typeOfGame;
  set typeOfGame(List<String> _value) {
    _typeOfGame = _value;
  }

  void addToTypeOfGame(String _value) {
    _typeOfGame.add(_value);
  }

  void removeFromTypeOfGame(String _value) {
    _typeOfGame.remove(_value);
  }

  void removeAtIndexFromTypeOfGame(int _index) {
    _typeOfGame.removeAt(_index);
  }

  DocumentReference? _currentAuthor;
  DocumentReference? get currentAuthor => _currentAuthor;
  set currentAuthor(DocumentReference? _value) {
    _currentAuthor = _value;
  }

  String _currentAuthorName = '';
  String get currentAuthorName => _currentAuthorName;
  set currentAuthorName(String _value) {
    _currentAuthorName = _value;
  }

  String _editBook = '';
  String get editBook => _editBook;
  set editBook(String _value) {
    _editBook = _value;
  }

  List<String> _difficulty = ['0', '1', '2'];
  List<String> get difficulty => _difficulty;
  set difficulty(List<String> _value) {
    _difficulty = _value;
  }

  void addToDifficulty(String _value) {
    _difficulty.add(_value);
  }

  void removeFromDifficulty(String _value) {
    _difficulty.remove(_value);
  }

  void removeAtIndexFromDifficulty(int _index) {
    _difficulty.removeAt(_index);
  }

  List<String> _newGameVars = [];
  List<String> get newGameVars => _newGameVars;
  set newGameVars(List<String> _value) {
    _newGameVars = _value;
  }

  void addToNewGameVars(String _value) {
    _newGameVars.add(_value);
  }

  void removeFromNewGameVars(String _value) {
    _newGameVars.remove(_value);
  }

  void removeAtIndexFromNewGameVars(int _index) {
    _newGameVars.removeAt(_index);
  }

  String _currentAuthorId = '';
  String get currentAuthorId => _currentAuthorId;
  set currentAuthorId(String _value) {
    _currentAuthorId = _value;
  }

  List<dynamic> _allAuthorList = [];
  List<dynamic> get allAuthorList => _allAuthorList;
  set allAuthorList(List<dynamic> _value) {
    _allAuthorList = _value;
  }

  void addToAllAuthorList(dynamic _value) {
    _allAuthorList.add(_value);
  }

  void removeFromAllAuthorList(dynamic _value) {
    _allAuthorList.remove(_value);
  }

  void removeAtIndexFromAllAuthorList(int _index) {
    _allAuthorList.removeAt(_index);
  }

  List<dynamic> _allBookList = [];
  List<dynamic> get allBookList => _allBookList;
  set allBookList(List<dynamic> _value) {
    _allBookList = _value;
  }

  void addToAllBookList(dynamic _value) {
    _allBookList.add(_value);
  }

  void removeFromAllBookList(dynamic _value) {
    _allBookList.remove(_value);
  }

  void removeAtIndexFromAllBookList(int _index) {
    _allBookList.removeAt(_index);
  }

  List<dynamic> _newGameAuthors = [];
  List<dynamic> get newGameAuthors => _newGameAuthors;
  set newGameAuthors(List<dynamic> _value) {
    _newGameAuthors = _value;
  }

  void addToNewGameAuthors(dynamic _value) {
    _newGameAuthors.add(_value);
  }

  void removeFromNewGameAuthors(dynamic _value) {
    _newGameAuthors.remove(_value);
  }

  void removeAtIndexFromNewGameAuthors(int _index) {
    _newGameAuthors.removeAt(_index);
  }

  int _counterQuestion = 0;
  int get counterQuestion => _counterQuestion;
  set counterQuestion(int _value) {
    _counterQuestion = _value;
  }

  int _errorCounter = 3;
  int get errorCounter => _errorCounter;
  set errorCounter(int _value) {
    _errorCounter = _value;
  }

  List<dynamic> _newGameBooks = [];
  List<dynamic> get newGameBooks => _newGameBooks;
  set newGameBooks(List<dynamic> _value) {
    _newGameBooks = _value;
  }

  void addToNewGameBooks(dynamic _value) {
    _newGameBooks.add(_value);
  }

  void removeFromNewGameBooks(dynamic _value) {
    _newGameBooks.remove(_value);
  }

  void removeAtIndexFromNewGameBooks(int _index) {
    _newGameBooks.removeAt(_index);
  }

  List<int> _listGamesCounters = [0, 0, 0];
  List<int> get listGamesCounters => _listGamesCounters;
  set listGamesCounters(List<int> _value) {
    _listGamesCounters = _value;
  }

  void addToListGamesCounters(int _value) {
    _listGamesCounters.add(_value);
  }

  void removeFromListGamesCounters(int _value) {
    _listGamesCounters.remove(_value);
  }

  void removeAtIndexFromListGamesCounters(int _index) {
    _listGamesCounters.removeAt(_index);
  }

  int _usersLevel = 0;
  int get usersLevel => _usersLevel;
  set usersLevel(int _value) {
    _usersLevel = _value;
  }

  int _localPoints = 0;
  int get localPoints => _localPoints;
  set localPoints(int _value) {
    _localPoints = _value;
  }

  bool _buttonDidabled = false;
  bool get buttonDidabled => _buttonDidabled;
  set buttonDidabled(bool _value) {
    _buttonDidabled = _value;
  }

  List<dynamic> _currentFourItem = [];
  List<dynamic> get currentFourItem => _currentFourItem;
  set currentFourItem(List<dynamic> _value) {
    _currentFourItem = _value;
  }

  void addToCurrentFourItem(dynamic _value) {
    _currentFourItem.add(_value);
  }

  void removeFromCurrentFourItem(dynamic _value) {
    _currentFourItem.remove(_value);
  }

  void removeAtIndexFromCurrentFourItem(int _index) {
    _currentFourItem.removeAt(_index);
  }

  List<dynamic> _localLiderBoard = [];
  List<dynamic> get localLiderBoard => _localLiderBoard;
  set localLiderBoard(List<dynamic> _value) {
    _localLiderBoard = _value;
  }

  void addToLocalLiderBoard(dynamic _value) {
    _localLiderBoard.add(_value);
  }

  void removeFromLocalLiderBoard(dynamic _value) {
    _localLiderBoard.remove(_value);
  }

  void removeAtIndexFromLocalLiderBoard(int _index) {
    _localLiderBoard.removeAt(_index);
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}
