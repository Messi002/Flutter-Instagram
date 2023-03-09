void main(List<String> args) {
  final s = ["h", "e", "l", "l", "o"];
  final reversed = reversedString(s);
  print(reversed);
}

List<String> reversedString(List<String> list) {
  int i = 0;
  int j = list.length - 1;
  List<String> temp = [];

  while (j >= i) {
    String letter = list[j];
    temp.add(letter);
    j--;
  }

  return temp;
}
