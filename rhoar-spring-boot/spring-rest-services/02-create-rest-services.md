# Create REST services for the fruit web application

RESTful web services are one of the core use cases for the Spring Boot framework as Spring makes it very easy to create HTTP APIs serving a variety of data types. For this scenario we will be building a RESTful JSON API to create and store Fruits in a virtual basket.

**1. Create a Model**

First we need to create a Java class file that will model our Fruit objects. For that, you need to click on the following link, which opens the empty file in the editor: ``src/main/java/com/example/service/Fruit.java``{{open}}

Then, copy the below content into the file (or use the `Copy to Editor` button):

<pre class="file" data-filename="src/main/java/com/example/service/Fruit.java" data-target="replace">
package com.example.service;

public class Fruit {

    private String name;

    public Fruit() {
    }

    public Fruit(String type) {
        this.name = type;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
</pre>

As you can see this is a Plain-Old-Java-Object (POJO). Nothing fancy here yet!

**2. Add a REST Controller**

Controllers are the **C** in the MVC pattern which mediate between our views and our internal models / business logic. Here we need to create a Spring `@RestController` annotated Java class. For this you need to click on the following link which will open an empty file in the editor: ``src/main/java/com/example/service/FruitController.java``{{open}}

Then, copy the below content into the file (or use the `Copy to Editor` button):

<pre class="file" data-filename="src/main/java/com/example/service/FruitController.java" data-target="replace">
package com.example.service;

import java.util.List;
import java.util.Arrays;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/api/fruits")
public class FruitController {

    @GetMapping
    public List<Fruit> getAll() {
        return Arrays.asList(
            new Fruit("Cherry"), new Fruit("Apple"), new Fruit("Banana")
        );
    }

    // TODO PathVariable

}
</pre>

The `@RestController` annotation tells Spring that this is a special kind of Controller meant to be returning data (not views) when called. If we used the standard Spring `@Controller` annotation instead we would have to also annotate the `getAll()` method (and any other API methods for that matter) with the `@ResponseBody` annotation. `@RestController` implies the `@ResponseBody` annotation for us so we don't have to type it every time!

For the sake of simplicity here we are just returning a static List of Fruit objects. Normally this information would come from a repository of some kind. This is covered in other scenarios.

**2. Test the service from a web browser locally**

Run the application by executing the below command:

``mvn spring-boot:run``{{execute}}

>**NOTE:** The `spring-boot-crud-booster` [here](https://github.com/snowdrop/spring-boot-crud-booster) has test cases for REST that you can review if interested. 

In the interest of time, we will skip creating test cases for the service and instead test it directly in our web browser.

When the console reports that Spring is up and running navigate to [the new REST API](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/api/fruits). You should see something like this in your browser:

```json
[{name":"Cherry"},{name":"Apple"},{name":"Banana"}]
```

Spring automatically serialized our Fruit models to JSON, created the appropriate HTTP header for clients, and returned that JSON to the client!

>**NOTE:** JSON is not the only Media Type supported in Spring Boot. JSON is simply the default chosen by the framework.

Press **CTRL+C** to stop the application.

## Congratulations

You have now learned how to how to create RESTful Web APIs with Spring Boot! 

In next step of this scenario, you will learn how to access and login to your OpenShift environment. 