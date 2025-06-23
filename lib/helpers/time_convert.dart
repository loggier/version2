String timeConvert(String horaCompleta) {
  // Separar la hora en sus componentes (horas, minutos y segundos)
  List<String> componentes = horaCompleta.split(' ');

  // Obtener los valores de horas, minutos y segundos
  int horas = 0;
  int minutos = 0;
  int segundos = 0;

  if (componentes.length >= 3) {
    horas = int.parse(componentes[0].replaceAll('h', ''));
    minutos = int.parse(componentes[1].replaceAll('min', ''));
    segundos = int.parse(componentes[2].replaceAll('s', ''));
  } else if (componentes.length == 2) {
    minutos = int.parse(componentes[0].replaceAll('min', ''));
    segundos = int.parse(componentes[1].replaceAll('s', ''));
  } else if (componentes.length == 1) {
    segundos = int.parse(componentes[0].replaceAll('s', ''));
  }

  // Calcular la hora total en segundos
  int totalSegundos = horas * 3600 + minutos * 60 + segundos;

  // Verificar si la hora es menor a 24 horas
  if (totalSegundos >= 86400) {
    return '24h';
  }

  // Obtener el equivalente máximo de 24 horas
  int horasMaximas = totalSegundos ~/ 3600;

  // Formatear la hora resultante en el formato deseado
  String horaCorta = '$horasMaximas h';

  return horaCorta;
}