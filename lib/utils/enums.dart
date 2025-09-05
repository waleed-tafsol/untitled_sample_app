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

enum EndPoints {
  signIn('auth/login');

  final String url;

  const EndPoints(this.url);
}
