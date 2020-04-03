class DateFormater {

  static String format(String dateTimeToString, {bool isWithTime = false}) {
    
    DateTime convertedDateTime = DateTime.parse(dateTimeToString);
    String result = "";

    if(convertedDateTime.day < 10)
      result += "0" + convertedDateTime.day.toString();
    else
      result += convertedDateTime.day.toString();
    result += "/";
    if(convertedDateTime.month < 10)
      result += "0" + convertedDateTime.month.toString();
    else
      result += convertedDateTime.month.toString();
    result += "/" + convertedDateTime.year.toString();

    if(isWithTime)
    {
      result += " (";
      if(convertedDateTime.hour < 10)
        result += "0" + convertedDateTime.hour.toString();
      else
        result += convertedDateTime.hour.toString();
      result += ":";
      if(convertedDateTime.minute < 10)
        result += "0" + convertedDateTime.minute.toString();
      else
        result += convertedDateTime.minute.toString();
      result += ":";
      if(convertedDateTime.second < 10)
        result += "0" + convertedDateTime.second.toString();
      else
        result += convertedDateTime.second.toString();
      result += " )";
    }

    return result;

  }
}