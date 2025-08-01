enum AllDaysWeek {
  segundaFeira,
  tercaFeira,
  quartaFeira,
  quintaFeira,
  sextaFeira,
  sabado,
  domingo,
}

extension AllDaysWeekExtension on AllDaysWeek {
  String get nome {
    switch (this) {
      case AllDaysWeek.segundaFeira:
        return "Segunda-feira";
      case AllDaysWeek.tercaFeira:
        return "Terça-feira";
      case AllDaysWeek.quartaFeira:
        return "Quarta-feira";
      case AllDaysWeek.quintaFeira:
        return "Quinta-feira";
      case AllDaysWeek.sextaFeira:
        return "Sexta-feira";
      case AllDaysWeek.sabado:
        return "Sábado";
      case AllDaysWeek.domingo:
        return "Domingo";
    }
  }
}
