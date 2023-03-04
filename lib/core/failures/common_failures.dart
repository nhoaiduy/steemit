import 'failures.dart';

class ServerFailures extends Failures {
  ServerFailures({String? messageKey})
      : super(content: "Server Failures", messageKey: messageKey);
}

class AuthorizationFailures extends Failures {
  AuthorizationFailures({String? messageKey})
      : super(content: "Authorization Failures", messageKey: messageKey);
}

class ResponseDataParsingFailures extends Failures {
  ResponseDataParsingFailures({String? messageKey})
      : super(
            content: "Response Data Parsing Failures", messageKey: messageKey);
}

class DataParsingFailures extends Failures {
  DataParsingFailures({String? messageKey})
      : super(content: "Data Parsing Failures", messageKey: messageKey);
}
