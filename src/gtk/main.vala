int main(string[] args) {
//  valac --pkg gtk+-3.0 Hello.vala main.vala -o Hello && ./Hello

  var hello = new Hello();
  return hello.run(args);
}
