import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import '../utils/constants.dart';

class Info {
  BigInt id;
  String product;
  String source;
  String destination;
  String remark;
  String time;
  EthereumAddress address;

  Info(this.id, this.product, this.source, this.destination, this.remark,
      this.time, this.address);
}

Future<DeployedContract> loadContract() async {
  String abi = await rootBundle.loadString('assets/abi.json');
  String contractAddress = contractAddress1;

  final contract = DeployedContract(ContractAbi.fromJson(abi, 'Example'),
      EthereumAddress.fromHex(contractAddress));
  return contract;
}

Future<String> callFunction(String funcname, List<dynamic> args,
    Web3Client ethClient, String privateKey) async {
  //
  //
  EthPrivateKey credential = EthPrivateKey.fromHex(privateKey);
  DeployedContract contract = await loadContract();
  final ethFunction = contract.function(funcname);
  final result = await ethClient.sendTransaction(
      credential,
      Transaction.callContract(
          contract: contract, function: ethFunction, parameters: args),
      chainId: null,
      fetchChainIdFromNetworkId: true);
  return result;
  //
}

Future<List<dynamic>> ask(
    String funcName, List<dynamic> args, Web3Client ethClient) async {
  final contract = await loadContract();
  final ethFunction = contract.function(funcName);
  final result =
      ethClient.call(contract: contract, function: ethFunction, params: args);
  return result;
}

Future<List> detail(int id, Web3Client ethClient) async {
  List<dynamic> result = await ask('show', [BigInt.from(id)], ethClient);
  return result;
}

Future<String> add(int id, String name, Web3Client ethClient) async {
  var response =
      await callFunction('add', [BigInt.from(id), name], ethClient, key);

  return response;
}
