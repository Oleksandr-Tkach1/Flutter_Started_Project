import 'package:bounty_hub_client/data/models/api/request/auth_request.dart';
import 'package:bounty_hub_client/data/models/api/response/token_response.dart';
import 'package:bounty_hub_client/data/source/login_data_source.dart';
import 'package:bounty_hub_client/network/constants.dart';
import 'package:bounty_hub_client/network/server_api.dart';

class LoginRepository extends LoginDataSource {

  final RestClient client;

  LoginRepository(this.client);

  @override
  Future<void> authenticate(String email, String captchaCode) {
    return client.authenticate(AuthRequest(email, captchaCode, Constants.captchaType, Constants.captchaSecret, Constants.domain));
  }

  @override
  Future<TokenResponse> confirmCode(String email, String code) {
    return client.confirmCode(email, code, 'password');
  }
}