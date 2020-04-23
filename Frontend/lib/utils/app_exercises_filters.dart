class AppExercisesFilters {
  static bool filterMode = false;
  static bool abs = false;
  static bool forearms = false;
  static bool biceps = false;
  static bool back = false;
  static bool shoulders = false;
  static bool hamstrings = false;
  static bool calves = false;
  static bool pectorals = false;
  static bool quadriceps = false;
  static bool triceps = false;

  static bool areAllDisabled() {
    if (abs == false &&
        forearms == false &&
        biceps == false &&
        back == false &&
        shoulders == false &&
        hamstrings == false &&
        calves == false &&
        pectorals == false &&
        quadriceps == false &&
        triceps == false) return true;
    return false;
  }

  static String allEnabledFiltersToString() {
    String result = "";
    if (abs) result += "Abdominaux, ";
    if (forearms) result += "Avant-bras, ";
    if (biceps) result += "Biceps, ";
    if (back) result += "Dos, ";
    if (shoulders) result += "Épaules, ";
    if (hamstrings) result += "Ischios, ";
    if (calves) result += "Mollets, ";
    if (pectorals) result += "Pectoraux, ";
    if (quadriceps) result += "Quadriceps, ";
    if (triceps) result += "Triceps, ";
    if (result.length != 0) result = result.substring(0, result.length - 2);
    return result;
  }

  static List<String> allEnabledFiltersToList() {
    List<String> result = List<String>();
    if (abs) result.add("Abdominaux");
    if (forearms) result.add("Avant-bras");
    if (biceps) result.add("Biceps");
    if (back) result.add("Dos");
    if (shoulders) result.add("Épaules");
    if (hamstrings) result.add("Ischios");
    if (calves) result.add("Mollets");
    if (pectorals) result.add("Pectoraux");
    if (quadriceps) result.add("Quadriceps");
    if (triceps) result.add("Triceps");
    return result;
  }

  static void disableAll() {
    filterMode = false;
    abs = false;
    forearms = false;
    biceps = false;
    back = false;
    shoulders = false;
    hamstrings = false;
    calves = false;
    pectorals = false;
    quadriceps = false;
    triceps = false;
  }
}
