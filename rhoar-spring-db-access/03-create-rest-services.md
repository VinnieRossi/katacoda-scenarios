# Create REST services for the Fruit Web Application

RESTful web services are one of the core use cases for the Spring Boot framework as Spring makes it very easy to create HTTP APIs serving a variety of data types. For this scenario we will be building a RESTful JSON API.

**1. Add a service**

To make these models available to our application we need to create a Spring Controller. Controllers are the **C** in the MVC pattern which mediate between our views and our internal models / business logic. Here we need to create a Spring `@RestController` annotated Java class. For this you need to click on the following link which will open an empty file in the editor: ``src/main/java/com/example/service/FruitController.java``{{open}}

Then, copy the below content into the file (or use the `Copy to Editor` button):

<pre class="file" data-filename="src/main/java/com/example/service/FruitController.java" data-target="replace">
package com.example.service;

import java.util.List;
import java.util.Objects;
import java.util.Spliterator;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/fruits")
public class FruitController {

    private final FruitRepository repository;

    @Autowired
    public FruitController(FruitRepository repository) {
        this.repository = repository;
    }

    @GetMapping
    public List<Fruit> getAll() {
        return StreamSupport.stream(repository.findAll().spliterator(), false).collect(Collectors.toList());
    }

//TODO: Add additional service calls here
}
</pre>

The `@RestController` annotation tells Spring that this is a special kind of Controller meant to be returning data (not views) when called. If we used the standard Spring `@Controller` annotation instead we would have to also annotate the `getAll()` method (and any other API methods for that matter) with the `@ResponseBody` annotation. `@RestController` implies the `@ResponseBody` annotation for us so we don't have to type it every time!

**2. Test the service from a web browser locally**

Run the application by executing the below command:

``mvn spring-boot:run``{{execute}}

>**NOTE:** The `spring-boot-crud-booster` [here](https://github.com/snowdrop/spring-boot-crud-booster) has test cases for REST that you can review if interested. 

In the interest of time, we will skip creating test cases for the service and instead test it directly in our web browser.

When the console reports that Spring is up and running access the web page by either click the Web Browser Tab or use [this](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/) link.

![Local Web Browser Tab](../assets/middleware/rhoar-getting-started-spring/web-browser-tab.png)

If everything works the web page should look something like this:

![Fruit List](../assets/middleware/rhoar-getting-started-spring/fruit-list.png)

Now if you navigate to [the new REST API](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/api/fruits) you should see something like this in your browser:

```json
[{name":"Cherry"},{name":"Apple"},{name":"Banana"}]
```

Spring automatically serialized our Fruit models to JSON, created the appropriate HTTP header for clients, and returned that JSON to the client!

>**NOTE:** JSON is not the only Media Type supported in Spring Boot. JSON is simply the default chosen by the framework.

Press **CTRL+C** to stop the application.

**3. Create additional services for update, create, and delete**

Add the following methods to the Fruit Controller at the TODO marker.

<pre class="file" data-filename="src/main/java/com/example/service/FruitController.java" data-target="insert" data-marker="//TODO: Add additional service calls here">
    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping
    public Fruit createFruit(@RequestBody(required = false) Fruit fruit) {
        verifyCorrectPayload(fruit);
        return repository.save(fruit);
    }

    @GetMapping("/{id}")
    public Fruit getFruit(@PathVariable("id") Long id) {
        verifyFruitExists(id);
        return repository.findOne(id);
    }

    @PutMapping("/{id}")
    public Fruit updateFruit(@PathVariable("id") Long id, @RequestBody(required = false) Fruit fruit) {
        verifyFruitExists(id);
        verifyCorrectPayload(fruit);

        fruit.setId(id);
        return repository.save(fruit);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping("/{id}")
    public void delete(@PathVariable("id") Integer id) {
        verifyFruitExists(id);
        repository.delete(id);
    }

    private void verifyFruitExists(Long id) {
        if (!repository.exists(id)) {
            throw new RuntimeException(String.format("Fruit with id=%d was not found", id));
        }
    }

    private void verifyCorrectPayload(Fruit fruit) {
        if (Objects.isNull(fruit)) {
            throw new RuntimeException("Fruit cannot be null");
        }

        if (!Objects.isNull(fruit.getId())) {
            throw new RuntimeException("Id field must be generated");
        }
    }
</pre>


**5. Run and verify**

Build and start the application again

``mvn spring-boot:run -DskipTests``{{execute}}

Now that we have implemented all the services we are now able to see fruits on the page as well as update, create, and delete them.

When the console reports that Spring is up and running access the web page by either click the Web Browser Tab or use [this](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/) link.

![Local Web Browser Tab](../../assets/middleware/rhoar-getting-started-spring/web-browser-tab.png)

## Congratulations

You have now learned how to how to create REST Services that access a database. 

In next step of this scenario, you will learn how to access and login to your openshift environment. 