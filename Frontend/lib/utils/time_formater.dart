class TimeFormater {
  static String getDuration(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
    // return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  static int getMinutes(Duration duration) {
    int twoDigits(int n) {
      if (n >= 10) return n;
      return n;
    }

    return twoDigits(duration.inMinutes.remainder(60));
  }

  static int getSeconds(Duration duration) {
    int twoDigits(int n) {
      if (n >= 10) return n;
      return n;
    }

    return twoDigits(duration.inSeconds.remainder(60));
  }
}
