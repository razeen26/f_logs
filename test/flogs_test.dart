// // ignore_for_file: unused_local_variable
//
// import 'package:f_logs/f_logs.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:logging_task_flog/flogs.dart';
//
// void main() {
//   group('TESTING FLOGS', () {
//     test('FLOGS CONFIGURATION TEST', () {
//       expect(FlogFunctions.configFunction().isDevelopmentDebuggingEnabled, true);
//       expect(FlogFunctions.configFunction().timestampFormat, TimestampFormat.TIME_FORMAT_FULL_3);
//       expect(FlogFunctions.configFunction().formatType, FormatType.FORMAT_CUSTOM);
//       expect(
//         FlogFunctions.configFunction().fieldOrderFormatCustom,
//         [FieldName.TIMESTAMP, FieldName.LOG_LEVEL, FieldName.CLASSNAME, FieldName.METHOD_NAME, FieldName.TEXT, FieldName.EXCEPTION, FieldName.STACKTRACE],
//       );
//       expect(FlogFunctions.configFunction().customOpeningDivider, '{');
//       expect(FlogFunctions.configFunction().customClosingDivider, '}');
//     });
//   });
//
//   group('FLOG FUNCTIONALITIES TEST', () {
//     test('FLOG TEST', () {
//       FlogsTest log = FlogsTest();
//       expect(log.FlogsFunctionTest(message: 'Test Message'), true);
//     });
//   });
// }
