class Laptop {
    turnOn(){
        print('Laptop turned on');
    }

    turnOff(){
        print('Laptop turned off');
    }
}

class MacBook implements Laptop {
    @override
    turnOn(){
        print('MacBook turned on');
    }

    turnOff(){
        print("MacBook turned off");
    }
}

void main(){
    var macBook = MacBook();
    macBook.turnOn();
    macBook.turnOff();
}