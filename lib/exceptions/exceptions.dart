class UnProcessedEntity {
  @override
  String toString() {
    return "Missing fields";
  }
}

class LoginFailed {
  @override
  String toString() {
    return "كلمة المستخدم او كلمة المرور خاطئة";
  }
}

class RedirectionNotFound implements Exception {
  @override
  String toString() {
    return "Too Many Redirection";
  }
}

class ResourceNotFound implements Exception {
  String message;
  ResourceNotFound(this.message);

  @override
  String toString() {
    return "Resource ${this.message} NotFound";
  }
}

class NoInternetConnection implements Exception {
  @override
  String toString() {
    return "لا يوجد اتصال بالانترنت";
  }
}

class PropertyIsRequired implements Exception {
  String field;
  PropertyIsRequired(this.field);
  @override
  String toString() {
    return '  Property ${this.field}  is field ';
  }
}
