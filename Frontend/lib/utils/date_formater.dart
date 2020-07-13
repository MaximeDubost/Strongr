class DateFormater {
  static String format(String dateTimeToString,
      {bool isWithTime = false, timeOnly = false}) {
    DateTime convertedDateTime = DateTime.parse(dateTimeToString);
    String result = "";

    if (!timeOnly) {
      if (convertedDateTime.day < 10)
        result += "0" + convertedDateTime.day.toString();
      else
        result += convertedDateTime.day.toString();
      result += "/";
      if (convertedDateTime.month < 10)
        result += "0" + convertedDateTime.month.toString();
      else
        result += convertedDateTime.month.toString();
      result += "/" + convertedDateTime.year.toString();

      if (isWithTime) {
        result += " (";
        if (convertedDateTime.hour < 10)
          result += "0" + convertedDateTime.hour.toString();
        else
          result += convertedDateTime.hour.toString();
        result += ":";
        if (convertedDateTime.minute < 10)
          result += "0" + convertedDateTime.minute.toString();
        else
          result += convertedDateTime.minute.toString();
        result += ":";
        if (convertedDateTime.second < 10)
          result += "0" + convertedDateTime.second.toString();
        else
          result += convertedDateTime.second.toString();
        result += ")";
      }
    } else {
      if (convertedDateTime.hour < 10)
        result += "0" + convertedDateTime.hour.toString();
      else
        result += convertedDateTime.hour.toString();
      result += ":";
      if (convertedDateTime.minute < 10)
        result += "0" + convertedDateTime.minute.toString();
      else
        result += convertedDateTime.minute.toString();
    }

    return result;
  }

  static int age(String dateTimeToString) {
    DateTime birthDate = DateTime.parse(dateTimeToString);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1)
      age--;
    else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) age--;
    }
    return age;
  }
}
