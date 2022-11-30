import 'package:url_launcher/url_launcher.dart';

class MapsUtils
{
  MapsUtils._();

  // latitude longtitude
  static Future<void> openMapWithPosition(double latitude, double longtitude) async
  {
    Uri googleMapUrl = Uri.parse ("https://www.google.com/maps/search/?api=1&query=$latitude,$longtitude");
    //String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longtitude";

    if(await launchUrl(googleMapUrl))
    {
      await launchUrl(googleMapUrl);
    }
    else
    {
      throw "Could not open the map";
    }
  }

  // text address
  static Future<void>openMapWithAddress(String fullAddress) async
  {
    String query = Uri.encodeComponent(fullAddress);
    Uri googleMapUrl = Uri.parse ("https://www.google.com/maps/search/?api=1&query=$query");

    //String googleMapUrl = "https://www.google.com/maps/search/?api=1&query=$query";

    if(await canLaunchUrl(googleMapUrl))
    {
      await launchUrl(googleMapUrl);
    }
    else
    {
      throw "Could not open the map";
    }

  }
}

