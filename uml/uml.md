classDiagram
    class Employee {
    }

    class Project {
    }

    class Task {
    }

    Employee "0..*" o-- "0..*" Project : works on
    Project "1" *-- "many" Task : consists of
    Employee "1" o-- "many" Task : assigned to
    Project "0..*" o-- "0..*" Employee : has