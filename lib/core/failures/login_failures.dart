abstract class AuthenticationFailures {}

class ServerFailures extends AuthenticationFailures {}

class DataParsingFailures extends AuthenticationFailures {}

class WrongLoginInfoFailures extends AuthenticationFailures {}

class EmptyUsernameFailures extends AuthenticationFailures {}

class EmptyPasswordFailures extends AuthenticationFailures {}

class InvalidEmailFailures extends AuthenticationFailures {}

class SpacingPasswordFailures extends AuthenticationFailures {}

class LessThan8CharsPasswordFailures extends AuthenticationFailures {}
