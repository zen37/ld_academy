# REST API

## 1. What is REST

### Definition
**REST (Representational State Transfer)** is an architectural style for building distributed systems, especially web services. It was defined by Roy Fielding in his 2000 doctoral dissertation.

### Key Characteristics
- **Resource-Oriented**: Each piece of data is treated as a resource, identified by a URI.
- **Representation**: Resources can be retrieved in various representations (e.g., JSON, XML, HTML).
- **State Transfer**: Clients and servers communicate resource “state” via uniform interfaces (HTTP methods).

### Why It Matters
REST’s simplicity, scalability, and use of standard web technologies (HTTP, URIs, JSON) have made it a popular choice for creating APIs. A well-designed RESTful service is easy to consume, evolve, and maintain.

---

## 2. The Six Constraints of REST

Roy Fielding identified six architectural constraints that define what makes a service truly RESTful:

1. **Client-Server**  
   - Separation of concerns: The server handles data storage and logic; the client focuses on the user interface and user experience.

2. **Stateless**  
   - Each request from the client to the server must contain all information necessary to service the request.  
   - The server does not keep any client-specific session state.

3. **Cacheable**  
   - Responses must be labeled as cacheable or non-cacheable.  
   - Proper caching improves network efficiency and performance.

4. **Uniform Interface**  
   - All requests look the same and follow consistent rules.  
   - Typically involves using standard HTTP verbs (GET, POST, PUT, PATCH, DELETE), resource URLs, and hypermedia.

5. **Layered System**  
   - Allows for systems to be composed in hierarchical layers (e.g., load balancers, proxies).  
   - Improves scalability and security.

6. **Code on Demand (Optional)**  
   - Servers can temporarily extend client functionality by transferring executable code (e.g., JavaScript).  
   - This is an optional constraint and not all RESTful services use it.

---

## 3. HTTP Methods

In REST, we use standard HTTP methods (also called “verbs”) to perform actions on resources. The most common ones are:

1. **GET**  
   - Retrieves a representation of the resource.  
   - Is safe and idempotent.

2. **POST**  
   - Creates new resources or initiates actions.  
   - Neither safe nor idempotent.

3. **PUT**  
   - Replaces an existing resource entirely.  
   - Idempotent.

4. **PATCH**  
   - Partially updates a resource.  
   - Neither safe nor inherently idempotent.

5. **DELETE**  
   - Removes a resource.  
   - Idempotent.

### Less Common HTTP Methods
- **HEAD**: Retrieves metadata similar to a GET request but without the response body.  
- **OPTIONS**: Describes communication options for the target resource.

---

## 4. Resource Naming

### Principles of Resource URLs
- **Nouns, Not Verbs**:  
  - Endpoints typically represent resources (“/users”, “/orders”) instead of actions (“/getUsers”, “/updateOrder”).
- **Hierarchical Structure**:  
  - Use path segments to express relationships, e.g., `GET /users/123/orders/456`.
- **Pluralization**:  
  - Prefer plural resource names for collections (e.g., “users” instead of “user”).
- **Consistency**:  
  - Adopt consistent patterns across the API for clarity and discoverability.
- **Filtering & Queries**:  
  - Additional details like searches or filters often go in the query string (`GET /users?role=admin`).

### Importance of Good Resource Naming
- Makes the API intuitive and user-friendly.  
- Reduces confusion for both developers consuming and maintaining the API.

---

## 5. Idempotence

### Definition
**Idempotence** means that multiple identical requests should result in the same final state as a single request.

### Examples
- **PUT**:  
  - Sending the same PUT request multiple times produces the same resource state each time.
- **DELETE**:  
  - Deleting the same resource repeatedly has the same final outcome: the resource is gone.
- **POST**:  
  - Typically *not* idempotent because multiple identical POST requests can create multiple resources.

### Why It’s Important
- Idempotent methods allow clients and servers to retry requests safely if needed.  
- They simplify error handling and reconnection logic.

---

## 6. Safety

### Definition
A method is considered **safe** if it does not modify server data.

### Safe Methods
- **GET**, **HEAD**, **OPTIONS**  
  - By definition, these should only *retrieve* or *describe* the resource, not change it.

### Non-Safe Methods
- **POST**, **PUT**, **PATCH**, **DELETE**  
  - Any method that can alter the resource state is *not* safe.

### Rationale
- Safe methods allow caching and certain performance optimizations.  
- They also give clients a way to retrieve data without worrying about side effects.

---

## Final Thoughts

A well-designed REST API:
- Follows the **six constraints** to be genuinely RESTful.  
- Uses **HTTP methods** appropriately to reflect the intended operation.  
- Chooses clear and consistent **resource naming** conventions.  
- Understands and applies the concepts of **idempotence** and **safety** to manage the effects of repeated calls or failures.

Embracing these guidelines results in cleaner, more efficient, and more reliable APIs.


## HTTP Status Codes

https://www.restapitutorial.com/httpstatuscodes

## Resources

https://www.restapitutorial.com/resourcess