enum AllWeekDays {
  segundaFeira,
  tercaFeira,
  quartaFeira,
  quintaFeira,
  sextaFeira,
  sabado,
  domingo,
}

extension AllWeekDaysExtension on AllWeekDays {
  String get nome {
    switch (this) {
      case AllWeekDays.segundaFeira:
        return "Segunda-feira";
      case AllWeekDays.tercaFeira:
        return "Terça-feira";
      case AllWeekDays.quartaFeira:
        return "Quarta-feira";
      case AllWeekDays.quintaFeira:
        return "Quinta-feira";
      case AllWeekDays.sextaFeira:
        return "Sexta-feira";
      case AllWeekDays.sabado:
        return "Sábado";
      case AllWeekDays.domingo:
        return "Domingo";
    }
  }
}
