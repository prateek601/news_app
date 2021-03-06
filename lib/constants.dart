import 'package:flutter/material.dart';

// color palette
const Color primaryColor1 = Color(0xff0C54BE);
const Color primaryColor2 = Color(0xff303F60);
const Color secondaryColor1 = Color(0xffF5F9FD);
const Color secondaryColor2 = Color(0xffCED3DC);

// country list and news sources list
const List<String> countryList = ['Australia', 'USA', 'India', 'South Africa', 'France', 'Germany'];
const List<String> newsSources = ['ABC News', 'Business Insider', 'CNN', 'The Hindu', 'Google News (India)', 'Bloomberg'];
const List<String> sortPreference = ['Popular', 'Newest', 'Relevant'];

// Map of country and country code
const Map<String, String> countryMap = {
  'Australia': 'au',
  'USA': 'us',
  'India': 'in',
  'South Africa': 'za',
  'France': 'fr',
  'Germany': 'de'
};

// Map of news source and news source code
const Map<String, String> newsSourceMap = {
  'ABC News': 'abc-news',
  'Business Insider': 'business-insider',
  'CNN': 'cnn',
  'The Hindu': 'the-hindu',
  'Google News (India)': 'google-news-in',
  'Bloomberg': 'bloomberg'
};

// Map of sortPreference and there ids
const Map<String, String> sortPreferenceMap = {
  'Popular': 'popularity',
  'Newest': 'publishedAt',
  'Relevant': 'relevancy'
};

// pageSize used while making get request
const String pageSize = '10';

// user selected variable values
class SelectedVar {
  static String country = 'India';
  static String sortBy = 'Newest';
  static List sources = [];
}