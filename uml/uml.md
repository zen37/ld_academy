
```mermaid
classDiagram
    class Employee {
        -string firstName
        -string lastName
        -string email
        -DateTime dateOfBirth
        -string position
        -decimal salary
        -string updatedBy
        -DateTime? updatedAt
        +Create(employee: EmployeeCreateDto): void
        +Update(updateDto: EmployeeUpdateDto, updatedBy: string): void
        +Get(): Employee
    }

    class Project {
        -string name
        -string description
        -DateTime startDate
        -DateTime? endDate
        -string updatedBy
        -DateTime? updatedAt
        +Create(project: ProjectCreateDto): void
        +Update(updateDto: ProjectUpdateDto, updatedBy: string): void
        +Get(): Project
    }

    class EmployeeProject {
        -DateTime startDate
        -DateTime? endDate
        -string role
        +AssignEmployeeToProject(employee: Employee, project: Project): void
        +RemoveEmployeeFromProject(employee: Employee, project: Project): void
    }

    class Task {
        -string name
        -string description
        -DateTime dueDate
        -string status
        -DateTime? completedAt
        +Create(task: TaskCreateDto, project: Project): void
        +Update(taskDto: TaskUpdateDto): void
        +Get(): Task
    }


    Project "1" --> "0..*" Task : consists of
    Employee "1" --> "0..*" EmployeeProject : assigned to
    Project "1" --> "0..*" EmployeeProject : has
    Task "1" --> "0..*" EmployeeProject : involvess
```


# Review

Show a line between Employee and Project and a dotted line from that line that goes to EmployeeProject
Project 'consists of' Task not 'contains'
Add constraints not null to the db diagram
EmployeeProject
Show the link between Task and EmployeeProject