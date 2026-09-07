void main() {
    List<String> names = ['mario', 'luigi', 'yoshi', 'luigi', 'chun-li'];
    List<String> uniqueNames = names.toSet().toList();
    print(uniqueNames);
}