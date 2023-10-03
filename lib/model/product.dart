import 'package:hive/hive.dart';

/// this is generate person name adapter
part 'product.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  late final num productId;
}
