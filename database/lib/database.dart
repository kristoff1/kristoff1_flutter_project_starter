library database;

///EXAMPLE OF EXPORT
//Initiator
export 'src/initiator/database_initiator.dart';
export 'src/initiator/mixin/database_initiator_mixin.dart';

export 'src/database_interface.dart';
export 'src/const/item/topic_keys.dart';
export 'src/const/item/content_keys.dart';

//Exceptions
export 'src/exceptions/count_exception.dart';
export 'src/exceptions/delete_exception.dart';
export 'src/exceptions/initiation_exception.dart';
export 'src/exceptions/migrating_exception.dart';
export 'src/exceptions/insert_exception.dart';
export 'src/exceptions/query_exception.dart';
export 'src/exceptions/update_exception.dart';

/// A Calculator.
class Calculator {
  /// Returns [value] plus 1.
  int addOne(int value) => value + 1;
}
