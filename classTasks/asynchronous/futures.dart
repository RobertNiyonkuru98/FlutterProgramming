Future<String> getUserName() async {
    return Future.delayed(Duration(seconds: 2), () => 'Mark');
}