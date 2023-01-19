import 'package:hive/hive.dart';

import 'breakModel.dart';

class BreakModelAdapter extends TypeAdapter<BreakModel> {
  @override
  final typeId = 0;

  @override
  BreakModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var r = reader.read();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): r,
    };
    return BreakModel(breakStart: fields[0].toString() , breakEnd: fields[1].toString() , totalBreakTime:  fields[2].toString());
  }

  @override
  void write(BinaryWriter writer, BreakModel obj) {
    writer.writeByte(3);
    // writer.writeByte(2);
    writer.writeByte(0);
    writer.write(obj.breakStart);
    writer.writeByte(1);
    writer.write(obj.breakEnd);
    writer.writeByte(2);
    writer.write(obj.totalBreakTime);

  }
}

// Future<void> initHive() async {
//   // await Hive.initFlutter();
//   Hive.registerAdapter(BreakModelAdapter());
// }