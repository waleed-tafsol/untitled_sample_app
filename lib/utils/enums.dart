enum BaseUrls {
  api('https://api.brunos.kitchen/bruno/api/v1/'),
  google('AIzaSyAf8I5_7UDuc66z53Wbryj7m98Ofee44lg');

  final String url;

  const BaseUrls(this.url);
}

enum Screens {
  login("Login");

  final String text;

  const Screens(this.text);
}

enum SharedPreferencesKeys {
  authToken("auth_token");

  final String text;

  const SharedPreferencesKeys(this.text);
}

enum RegExpPattern {
  email(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    'Please enter a valid email address.',
  ),
  name(r'^[a-zA-Z]{3,}$', 'Enter valid name'),
  phone(r'^\+61[2-9]\d{8}$', 'Please enter a valid Australian phone number');

  const RegExpPattern(this.pattern, this.errorMessage);

  final String pattern;
  final String errorMessage;
}

enum EndPoints {
  signIn('auth/login');

  final String url;

  const EndPoints(this.url);
}

enum LoginWith {
  email('Email'),
  phone('Phone');

  final String value;

  const LoginWith(this.value);
}
