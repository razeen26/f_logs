String getAsset(String desc) {
  String icon;
  switch (desc) {
    case 'overcast clouds':
      icon = 'overcast_cloud.png';
      break;
    case 'clear sky':
      icon = 'sun.png';
      break;
    case 'broken clouds':
      icon = 'cloud_sun.png';
      break;

    case 'light rain':
      icon = 'light-rain.png';
      break;

    case 'scattered clouds':
      icon = 'cloud_sun.png';
      break;

    case 'few clouds':
      icon = 'cloud.png';
      break;

    case 'moderate rain':
      icon = 'light-rain.png';
      break;

    case 'rain':
      icon = 'rainy.png';
      break;

    case 'snow':
      icon = 'snow.png';
      break;

    case 'mist':
      icon = 'mist.png';
      break;
    default:
      icon = 'cancel.png';
  }

  return icon;
}
