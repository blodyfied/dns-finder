#!/bin/bash
clear
echo "  *******   ****     **  ********       ******** **               ** "
echo " /**////** /**/**   /** **//////       /**///// //               /** "
echo " /**    /**/**//**  /**/**             /**       ** *******      /**  *****  ****** "
echo " /**    /**/** //** /**/********* *****/******* /**//**///**  ****** **///**//**//* "
echo " /**    /**/**  //**/**////////**///// /**////  /** /**  /** **///**/******* /** / "
echo " /**    ** /**   //****       /**      /**      /** /**  /**/**  /**/**////  /** "
echo " /*******  /**    //*** ********       /**      /** ***  /**//******//******/*** "
echo " ///////   //      /// ////////        //       // ///   //  //////  ////// /// "
echo
echo
echo "- DNS offensive response - by Blodyfied"
echo
# Solicitar al usuario que ingrese un dominio
read -p "Enter the domain: " dominio
echo
# Verificar si se proporcionó un dominio
if [ -z "$dominio" ]; then
  echo "No domain provided"
  echo
  exit 1
fi

# Obtener la IP pública del dominio usando dig
IP=$(dig +short $dominio | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')

# Verificar si se obtuvo una IP
if [ -z "$IP" ]; then
  echo "Failed to get domain IP $dominio"
  echo
  exit 1
fi

# Mostrar la IP pública
echo "The public IP of the domain $dominio is: $IP"
# Usar la API ipinfo.io para obtener información de geolocalización
location=$(curl -s https://ipinfo.io/$IP/json)

# Extraer información relevante (ciudad, región, país, coordenadas)
city=$(echo $location | grep -Po '"city": *\K"[^"]*"' | tr -d '"')
region=$(echo $location | grep -Po '"region": *\K"[^"]*"' | tr -d '"')
country=$(echo $location | grep -Po '"country": *\K"[^"]*"' | tr -d '"')
loc=$(echo $location | grep -Po '"loc": *\K"[^"]*"' | tr -d '"')

# Mostrar la ubicación y coordenadas
echo "Location: $city, $region, $country"
echo "Coordinates: $loc"
