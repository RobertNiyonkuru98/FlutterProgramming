void main() {
    Map<String, int> salaries = {
        'Mario' : 50000,
        'Luigi' : 45000,
        'Peach' : 90000,
        'Yoshi' : 60000,
    };

    String topEarner = '';
    int highestSalary = 0;

    for (var entry in salaries.entries) {
        if (entry.value > highestSalary) {
            highestSalary = entry.value;
            topEarner = entry.key;
        }
    }

    print('The highest earner is $topEarner with a salary of \$$highestSalary.');
}