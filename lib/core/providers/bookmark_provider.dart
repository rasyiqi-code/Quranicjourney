import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/bookmark_model.dart';

class BookmarkProvider with ChangeNotifier {
  final SharedPreferences _prefs;
  final List<BookmarkModel> _bookmarks = [];

  BookmarkProvider(this._prefs) {
    _loadBookmarks();
  }

  List<BookmarkModel> get bookmarks => List.unmodifiable(_bookmarks);

  void _loadBookmarks() {
    final bookmarksJson = _prefs.getString('bookmarks');
    if (bookmarksJson != null) {
      try {
        final List<dynamic> jsonList = jsonDecode(bookmarksJson);
        _bookmarks.clear();
        _bookmarks.addAll(
          jsonList.map((json) => BookmarkModel.fromJson(json as Map<String, dynamic>)),
        );
      } catch (e) {
        _bookmarks.clear();
      }
    }
    notifyListeners();
  }

  void _saveBookmarks() {
    final jsonList = _bookmarks.map((b) => b.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    _prefs.setString('bookmarks', jsonString);
  }

  void addBookmark(BookmarkModel bookmark) {
    // Check if already bookmarked
    final exists = _bookmarks.any(
      (b) => b.surahNumber == bookmark.surahNumber && b.ayahNumber == bookmark.ayahNumber,
    );
    
    if (!exists) {
      _bookmarks.add(bookmark);
      _saveBookmarks();
      notifyListeners();
    }
  }

  void removeBookmark(int surahNumber, int ayahNumber) {
    _bookmarks.removeWhere(
      (b) => b.surahNumber == surahNumber && b.ayahNumber == ayahNumber,
    );
    _saveBookmarks();
    notifyListeners();
  }

  bool isBookmarked(int surahNumber, int ayahNumber) {
    return _bookmarks.any(
      (b) => b.surahNumber == surahNumber && b.ayahNumber == ayahNumber,
    );
  }

  void updateBookmarkNote(int surahNumber, int ayahNumber, String note) {
    final index = _bookmarks.indexWhere(
      (b) => b.surahNumber == surahNumber && b.ayahNumber == ayahNumber,
    );
    
    if (index != -1) {
      final bookmark = _bookmarks[index];
      _bookmarks[index] = BookmarkModel(
        surahNumber: bookmark.surahNumber,
        ayahNumber: bookmark.ayahNumber,
        surahName: bookmark.surahName,
        surahNameArabic: bookmark.surahNameArabic,
        createdAt: bookmark.createdAt,
        note: note,
      );
      _saveBookmarks();
      notifyListeners();
    }
  }
}

