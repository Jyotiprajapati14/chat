class CredentialsMdl {
  String emailId;
  String password;

  CredentialsMdl({this.emailId = '', this.password = ''});

  factory CredentialsMdl.fromJson(Map<String, dynamic> json) =>
      CredentialsMdl(emailId: json["emailId"], password: json["password"]);

  Map<String, dynamic> toJson() => {"emailId": emailId, "password": password};
}
