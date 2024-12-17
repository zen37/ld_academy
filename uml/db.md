``` python
from graphviz import Digraph

def generate_er_diagram():
    dot = Digraph()
    dot.attr(rankdir='LR', size='12')

    # Entities
    dot.node('Employee', 'Employee\n- EmployeeId (PK)\n- Name\n- Email', shape='box')
    dot.node('Project', 'Project\n- ProjectId (PK)\n- ProjectName\n- StartDate\n- EndDate', shape='box')
    dot.node('Task', 'Task\n- TaskId (PK)\n- TaskName\n- Status\n- DueDate\n- ProjectId (FK)\n- EmployeeId (FK)', shape='box')
    dot.node('History', 'History\n- HistoryId (PK)\n- EntityType\n- EntityId (FK)\n- ChangeLog\n- UserId\n- ChangeType\n- Timestamp', shape='box')

    # Relationship table for Employee and Project
    dot.node('EmployeeProject', 'EmployeeProject\n- EmployeeId (FK)\n- ProjectId (FK)', shape='box')

    # Relationships with dual cardinalities
    dot.edge('Employee', 'EmployeeProject', label='1', taillabel='1', headlabel='0..N')
    dot.edge('EmployeeProject', 'Project', label='0..N', taillabel='0..N', headlabel='1')
    dot.edge('Project', 'Task', label='1', taillabel='1', headlabel='0..N')
    dot.edge('Task', 'Employee', label='0..1', taillabel='0..1', headlabel='0..N')
    dot.edge('History', 'Employee', label='0..N', taillabel='0..N', headlabel='1')
    dot.edge('History', 'Project', label='0..N', taillabel='0..N', headlabel='1')
    dot.edge('History', 'Task', label='0..N', taillabel='0..N', headlabel='1')

    return dot

er_diagram = generate_er_diagram()
er_diagram.render('er_diagram', format='png', cleanup=True)
er_diagram.view()

```

``` mermaid
erDiagram
    EMPLOYEE {
        string employee_id
        string first_name
        string last_name
        string position
    }
    EMPLOYEE_PROJECT {
        string employee_project_id
        string role
        date start_date
        date end_date
    }
    PROJECT {
        string project_id
        string project_name
        string description
        date start_date
        date end_date
    }
    TASK {
        string task_id
        string task_name
        string status
        date due_date
    }
    HISTORY {
        string history_id
        string action
        date action_date
    }

    EMPLOYEE ||--o{ EMPLOYEE_PROJECT : "resolves"
    PROJECT ||--o{ EMPLOYEE_PROJECT : "resolves"
    EMPLOYEE_PROJECT }|..|{ EMPLOYEE : "has"
    EMPLOYEE_PROJECT }|..|{ PROJECT : "belongs to"
    PROJECT ||--o{ TASK : "includes"
    EMPLOYEE ||--o{ TASK : "assigned to"
    EMPLOYEE ||--o{ HISTORY : "records"
    PROJECT ||--o{ HISTORY : "records"
    TASK ||--o{ HISTORY : "records"
```

### Entity Attributes:
- **EMPLOYEE**: `employee_id`, `first_name`, `last_name`, `position`
- **EMPLOYEE_PROJECT**: `employee_project_id`, `role`, `start_date`, `end_date`
- **PROJECT**: `project_id`, `project_name`, `description`, `start_date`, `end_date`
- **TASK**: `task_id`, `task_name`, `status`, `due_date`
- **HISTORY**: `history_id`, `action`, `action_date`

``` mermaid

erDiagram
    EMPLOYEE {
        string employee_id
        string first_name
        string last_name
        string position
    }
    EMPLOYEE_PROJECT {
        string employee_project_id
        string role
        date start_date
        date end_date
    }
    PROJECT {
        string project_id
        string project_name
        string description
        date start_date
        date end_date
    }
    TASK {
        string task_id
        string task_name
        string status
        date due_date
    }
    HISTORY {
        string history_id
        string action
        date action_date
    }

    EMPLOYEE ||--o{ EMPLOYEE_PROJECT : "resolves"
    PROJECT ||--o{ EMPLOYEE_PROJECT : "resolves"
    EMPLOYEE_PROJECT }|..|{ EMPLOYEE : "has"
    EMPLOYEE_PROJECT }|..|{ PROJECT : "belongs to"
    PROJECT ||--o{ TASK : "includes"
    EMPLOYEE ||--o{ TASK : "assigned to"
    EMPLOYEE ||--o{ HISTORY : "records"
    PROJECT ||--o{ HISTORY : "records"
    TASK ||--o{ HISTORY : "records"

    %% Cardinalities shown as labels
    EMPLOYEE_PROJECT ||--o{ EMPLOYEE : "1..n"
    EMPLOYEE_PROJECT ||--o{ PROJECT : "1..n"
    PROJECT ||--o{ TASK : "1..n"
    EMPLOYEE ||--o{ TASK : "0..n"
    EMPLOYEE ||--o{ HISTORY : "1..n"
    PROJECT ||--o{ HISTORY : "1..n"
    TASK ||--o{ HISTORY : "1..n"


