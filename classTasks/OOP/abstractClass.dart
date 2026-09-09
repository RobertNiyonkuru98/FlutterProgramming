abstract class Vehicle {
    void start();
    void stop();
}

class Car extends Vehicle {
    @override
    void start(){
        print('Car started');
    }

    @override stop() {
        print('Car stopped');
    }
}

class Bike extends Vehicle {
    @override
    void start() {
        print('Bike started');
    }

    @override
    void stop(){
        print('Bike stopped');
    }
}

void main (){
    Car car = Car();
    car.start();
    car.stop();

    Bike bike = Bike();
    bike.start();
    bike.stop();
}