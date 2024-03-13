import 'package:faker/faker.dart';

class RandomUserAgent {
  late RandomGenerator random;
  late Faker faker;

  RandomUserAgent() {
    random = RandomGenerator(seed: 63833423);
    faker = Faker.withGenerator(random);
  }

  String generate() {
    return faker.internet.userAgent(osName: 'windows');
  }
}
