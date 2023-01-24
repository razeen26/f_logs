// ignore_for_file: non_constant_identifier_names, unused_import

import 'package:f_logs/f_logs.dart';

class FlogFunctions {
  static logInfo(String msg) {
    FLog.info(text: msg);
  }

  static void logException(String msg, String exceptionMsg) {
    FLog.logThis(text: msg, exception: exceptionMsg, type: LogLevel.SEVERE);
  }

  static logError(String msg) {
    FLog.error(text: msg);
  }

  static void logWarning(String msg) {
    FLog.warning(text: msg);
  }

  static void logTrace(String msg) {
    FLog.trace(text: msg);
  }

  static void logDebug(String msg) {
    FLog.debug(text: msg);
  }

  static void printLogs() {
    FLog.printLogs();
  }

  static void printFileLogs() {
    FLog.printFileLogs();
  }

  static void clearLogs() {
    FLog.clearLogs();
  }

  static void exportLogs() {
    FLog.exportLogs();
  }

  static LogsConfig configFunction() {
    return FLog.getDefaultConfigurations()
      ..isDevelopmentDebuggingEnabled = true
      ..timestampFormat = TimestampFormat.TIME_FORMAT_FULL_3
      ..formatType = FormatType.FORMAT_CUSTOM
      ..fieldOrderFormatCustom = [
        FieldName.TIMESTAMP,
        FieldName.LOG_LEVEL,
        FieldName.CLASSNAME,
        FieldName.METHOD_NAME,
        FieldName.TEXT,
        FieldName.EXCEPTION,
        FieldName.STACKTRACE,
      ]
      ..customOpeningDivider = "{"
      ..customClosingDivider = "}";
  }
}

// class FlogsTest {
//   bool FlogsFunctionTest({String? message}) {
//     FLog.info(text: 'entry');
//     FLog.debug(text: 'message: $message');
//     FLog.error(text: "$message");
//     FLog.warning(text: "$message");
//     FLog.trace(text: "$message");
//     FLog.severe(text: "$message");
//     return true;
//   }
// }
