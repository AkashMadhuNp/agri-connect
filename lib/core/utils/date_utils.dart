
import 'package:intl/intl.dart';

class AppDateUtils {
  static final DateFormat _displayFormat = DateFormat('MMM dd, yyyy');
  static final DateFormat _apiFormat = DateFormat('yyyy-MM-dd');
  
  static String formatForDisplay(DateTime date) {
    return _displayFormat.format(date);
  }
  
  static String formatForApi(DateTime date) {
    return _apiFormat.format(date);
  }
  
  static DateTime? parseApiDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return _apiFormat.parse(dateString);
    } catch (e) {
      return null;
    }
  }
  
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }
}