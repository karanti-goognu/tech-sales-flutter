import 'dart:io';

class CheckInternet{
  CheckInternet._();

  static const int DEFAULT_PORT = 53;
  static const Duration DEFAULT_TIMEOUT = const Duration(seconds: 10);


  static final List<AddressCheckOptions> defaultAddresses = List.unmodifiable([
    AddressCheckOptions(
      InternetAddress('1.1.1.1'),
      port: DEFAULT_PORT,
      timeout: DEFAULT_TIMEOUT,
    ),
    AddressCheckOptions(
      InternetAddress('8.8.4.4'),
      port: DEFAULT_PORT,
      timeout: DEFAULT_TIMEOUT,
    ),
    AddressCheckOptions(
      InternetAddress('208.67.222.222'),
      port: DEFAULT_PORT,
      timeout: DEFAULT_TIMEOUT,
    ),
  ]);


  static Future<AddressCheckResult> isHostReachable(
      AddressCheckOptions options,
      ) async {
    Socket? sock;
    try {
      sock = await Socket.connect(
        options.address,
        options.port,
        timeout: options.timeout,
      );
      sock.destroy();
      return AddressCheckResult(options, true);
    } catch (e) {
      sock?.destroy();
      return AddressCheckResult(options, false);
    }
  }

  static List<AddressCheckOptions> addresses = defaultAddresses;

  static Future<bool>  hasConnection() async {
    List<AddressCheckResult> _lastTryResults = <AddressCheckResult>[];
    List<Future<AddressCheckResult>> requests = [];
    for (var addressOptions in addresses) {
      requests.add(isHostReachable(addressOptions));
      AddressCheckResult _ =await isHostReachable(addressOptions);
      if(_.isSuccess){
        return true;
      }
    }
    _lastTryResults = List.unmodifiable(await Future.wait(requests));

    return _lastTryResults.map((result) => result.isSuccess).contains(true);
  }


}

class AddressCheckResult {
  final AddressCheckOptions options;
  final bool isSuccess;

  AddressCheckResult(
      this.options,
      this.isSuccess,
      );
}


class AddressCheckOptions {
  final InternetAddress address;
  final int port;
  final Duration timeout;

  AddressCheckOptions(
      this.address, {
        this.port = CheckInternet.DEFAULT_PORT,
        this.timeout = CheckInternet.DEFAULT_TIMEOUT,
      });
}