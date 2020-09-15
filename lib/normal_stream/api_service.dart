class ApiService {
  Future<String> fetchData(String input) async {
    await Future.delayed(Duration(seconds: 1));
    print(input + " World");
    return input + " World";
  }
}
