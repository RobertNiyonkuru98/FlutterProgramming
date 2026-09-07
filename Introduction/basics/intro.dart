// void main() {

    /* First script */
    // for (int i = 0; i < 5; i++) {
    //     print('hello ${i + 1}');
    // }

    // print('hello');

    /* Variables*/
    // String name = 'chun-li';
    // print(name);

    // bool isNight = false;
    // print(isNight);

    // dynamic name = 'chun-li';
    // name = 30;
    // print(name);

    /* Functions */
    // print('something');
    // String greet = greeting();
    // int age = getAge();
    // print(age);
    // print(greet);

    /* Lists */
    // List<String> names = ['chun-li', 'yoshi', 'mario'];
    // names.add('luigi');
    // names.remove('yoshi');
    // print(names);

    /* Classes */
    // User userOne = User('luigi', 25);
    // print(userOne.username);
    // // userOne.login();

    // User userTwo = User('mario', 30);
    // print(userTwo.username);

    // SuperUser userThree = SuperUser('yoshi', 20);
    // print(userThree.username);
    // userThree.publish();


   

// }

// class User {

//     String username;
//     int age;

//     User(this.username, this.age);

//     void login() {
//         print('user logged in');
//     }
// }

// String greeting() =>'hello';

// int getAge() => 30;

// class SuperUser extends User {

//     SuperUser(String username, int age) : super(username, age);
//     void publish() {
//         print('published update');
//     }
// }
void main() {
    print(study());
}
study() {
     List fiveTo10 = [5,6,7,8,9,10,];
    List numbers = [1,2,3,4,...fiveTo10,11,12];
    print(fiveTo10);
    print(numbers);
}