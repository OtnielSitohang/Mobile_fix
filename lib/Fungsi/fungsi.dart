import 'package:intl/intl.dart';

String formatTanggal(String dateString) {
  if (dateString != null) {
    try {
      DateTime date = DateTime.parse(dateString);

      // Buat formatter dengan format yang diinginkan
      DateFormat formatter = DateFormat('dd-MM-yyyy');

      // Format tanggal menggunakan formatter
      String formattedDate = formatter.format(date);

      return formattedDate;
    } catch (e) {
      // Kesalahan parsing, kembalikan nilai default atau pesan kesalahan
      return 'Invalid Date';
    }
  } else {
    // Handle ketika dateString bernilai null
    return 'Date Not Available';
  }
}

String timeFormatHourMinute(int seconds) {
  int hours = seconds ~/ 3600;
  int minutes = (seconds % 3600) ~/ 60;
  int remainingSeconds = (seconds % 60);

  String formattedTime = '';

  if (hours > 0) {
    formattedTime += '${hours.toString()} jam ';
  }
  if (minutes > 0) {
    formattedTime += '${minutes.toString()} menit ';
  }
  formattedTime += '${remainingSeconds.toString()} detik';

  return formattedTime.trim();
}
