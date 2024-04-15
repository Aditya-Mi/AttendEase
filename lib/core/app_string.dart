// ignore_for_file: constant_identifier_names

const BASE_URL = 'attendanceapi-9uwg.onrender.com';
const String USER_KEY = 'user';
const String TOKEN_KEY = 'token';

List<String> branches = ['ECE', 'IT', 'CSE', 'EE'];
List<String> sections = ['A', 'B', 'C'];
List<String> secondList = [
  'Electronics and Communication',
  'Information Technology',
  'Computer Science',
  'ECE'
];

Map<String, String> branchMap = {
  'ECE': 'Electronics and Communication',
  'IT': 'Information Technology',
  'CSE': 'Computer Science',
  'EE': 'Electronics and Communication'
};
Map<String, String> reverseBranchMap = Map.fromEntries(
  branchMap.entries.map(
    (entry) => MapEntry(entry.value, entry.key),
  ),
);

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];
