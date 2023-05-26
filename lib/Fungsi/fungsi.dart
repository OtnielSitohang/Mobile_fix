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

String timeFormatHourMinute(String time) {
  String afterFormat = 'mantap';

  return afterFormat;
}
