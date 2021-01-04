import 'package:flutter/material.dart';

class Measures {
  Measures.of(BuildContext context)
      : value = MediaQuery.textScaleFactorOf(context);

  /// Size of [leading]
  double get leadingWith => iconSize * 2;

  /// Size of [Toolbar] (e.i: appBar, bottomAppBar)
  double get toolbarHeight => value * 58;

  /// Size of [Button]
  double get buttonHeight => value * 45;

  /// Size of [subTitle]
  double get subTitleSize => value * 24;

  /// Size of  [Title]
  double get titleSize => value * 25;

  /// Size of [Label]
  double get labelSize => value * 18;

  /// Size of [Hint]
  double get hintSize => value * 14;

  /// size of [Icon]
  double get iconSize => value * 25;

  /// [Elevation]
  double get elevation => value * 2;

  /// [Elevation]
  double get listTile => value * 10;

  /// TextScaleFactor
  final double value;
}

bool verifyPhone(String phone, String country) {
  phone = phone.split(' ').join();
  switch (phone.length) {
    case 8:
    case 10:
      return country.toLowerCase() == 'ci';
    case 12:
    case 14:
      if (phone.startsWith('+225')) {
        return true;
      }
      break;
    case 13:
    case 15:
      if (phone.startsWith('00225')) {
        return true;
      }
      break;
    default:
      return false;
  }
  return false;
}

bool checkVersion(String phone) {
  switch (phone.length) {
    case 10:
      return true;
    case 14:
      return true;
    case 15:
      return true;
    default:
      return false;
  }
}

typedef String UpdatePhoneFunc(String value);

UpdatePhoneFunc updatePhone(String phone) {
  switch (phone.length) {
    case 8:
      return (String value) => '$value$phone';
    case 12:
      return (String value) {
        var indice = '+225';
        return phone.replaceFirst(indice, '$indice $value');
      };
      break;
    case 13:
      return (String value) {
        var indice = '00225';
        return phone.replaceFirst(indice, '$indice $value');
      };
    default:
      return (_) => phone;
  }
}

UpdatePhoneFunc resetPhone(String phone) {
  switch (phone.length) {
    case 10:
      return (String value) => phone.replaceFirst(value, '');
    case 14:
      return (String value) {
        var indice = '+225';
        return phone.replaceFirst('$indice$value', '+225 ');
      };
      break;
    case 15:
      return (String value) {
        var indice = '00225';
        return phone.replaceFirst('$indice$value', '00225 ');
      };
    default:
      return (_) => phone;
  }
}

Phone label(String phone) {
  var characters = phone.characters;
  switch (characters.elementAt(0)) {
    case '3':
      return PhoneFixedOffAbidjan();
    case '2':
      return PhoneFixedOnAbidjan();
    default:
      return PhoneMobile();
  }
}

String networkToString(NETWORK network) {
  switch (network) {
    case NETWORK.MTN:
      return 'mtn';
    case NETWORK.MOOV:
      return 'moov';
    case NETWORK.ORANGE:
      return 'orange';
    default:
      return 'inconnu';
  }
}

String networkIndice(String phone) {
  var characters = phone.characters;
  switch (characters.length) {
    case 8:
      return characters.elementAt(1);
      break;
    case 10:
      return characters.elementAt(3);
      break;
    case 12:
      return characters.elementAt(5);
      break;
    case 13:
      return characters.elementAt(6);
      break;
    case 14:
      return characters.elementAt(7);
      break;
    case 15:
      return characters.elementAt(8);
    default:
      return '';
  }
}

enum NETWORK {
  MTN,
  MOOV,
  ORANGE,
  UNKNOWN,
}

abstract class Phone {
  String get name => 'MOBILE';

  NETWORK network(String c) {
    return NETWORK.UNKNOWN;
  }

  String format(NETWORK network) {
    return '';
  }
}

class PhoneMobile implements Phone {
  String get name => 'MOBILE';

  @override
  NETWORK network(String c) {
    switch (c) {
      case '0':
      case '1':
      case '2':
      case '3':
        return NETWORK.MOOV;
      case '4':
      case '5':
      case '6':
        return NETWORK.MTN;
      case '7':
      case '8':
      case '9':
        return NETWORK.ORANGE;
      default:
        return NETWORK.UNKNOWN;
    }
  }

  @override
  String format(NETWORK network) {
    switch (network) {
      case NETWORK.MOOV:
        return '01';
      case NETWORK.MTN:
        return '05';
      case NETWORK.ORANGE:
        return '07';
      default:
        return '';
    }
  }
}

class PhoneFixedOnAbidjan implements Phone {
  String get name => 'Fixe';

  @override
  NETWORK network(String c) {
    switch (c) {
      case '8':
        return NETWORK.MOOV;
      case '0':
        return NETWORK.MTN;
      default:
        return NETWORK.ORANGE;
    }
  }

  @override
  String format(NETWORK network) {
    switch (network) {
      case NETWORK.MOOV:
        return '21';
      case NETWORK.MTN:
        return '25';
      case NETWORK.ORANGE:
        return '27';
      default:
        return '';
    }
  }
}

class PhoneFixedOffAbidjan implements Phone {
  String get name => 'Fixe';

  @override
  NETWORK network(String c) {
    switch (c) {
      case '0':
        return NETWORK.MTN;
      default:
        return NETWORK.ORANGE;
    }
  }

  @override
  String format(NETWORK network) {
    switch (network) {
      case NETWORK.MTN:
        return '25';
      case NETWORK.ORANGE:
        return '27';
      default:
        return '';
    }
  }
}
