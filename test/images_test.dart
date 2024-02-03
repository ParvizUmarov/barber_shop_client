import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:barber_shop/resources/resources.dart';

void main() {
  test('images assets test', () {
    expect(File(Images.barber).existsSync(), isTrue);
    expect(File(Images.barberShopLogo).existsSync(), isTrue);
    expect(File(Images.barbershopSalon).existsSync(), isTrue);
    expect(File(Images.errorIcon).existsSync(), isTrue);
    expect(File(Images.firstStores).existsSync(), isTrue);
    expect(File(Images.hairdresser).existsSync(), isTrue);
    expect(File(Images.logo).existsSync(), isTrue);
    expect(File(Images.logo2).existsSync(), isTrue);
    expect(File(Images.salon).existsSync(), isTrue);
    expect(File(Images.secondStores).existsSync(), isTrue);
    expect(File(Images.shop).existsSync(), isTrue);
    expect(File(Images.success).existsSync(), isTrue);
    expect(File(Images.thirdStores).existsSync(), isTrue);
    expect(File(Images.userAvatar).existsSync(), isTrue);
  });
}
