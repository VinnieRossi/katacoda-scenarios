# Create the Fruit Basket Model and View

Spring MVC is a framework around the Model/View/Controller pattern which provides the developer with a set of tools and abstractions for building MVC-driven applications. 

**1. Create a Model**

The *M* in MVC, our Model, forms the basis for the domain that we are working with. In Spring MVC models are just plain old Java objects (POJOs). So first we need to create a Java class file that will model our Fruit objects. For that, you need to click on the following link, which opens the empty file in the editor: ``src/main/java/com/example/service/Fruit.java``{{open}}

Then, copy the below content into the file (or use the `Copy to Editor` button):

<pre class="file" data-filename="src/main/java/com/example/service/Fruit.java" data-target="replace">
package com.example.service;

public class Fruit {

    private String name;
    private int weight;

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

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
        this.weight = weight;
    }
}
</pre>

As you can see this is a Plain-Old-Java-Object (POJO). Nothing fancy here yet!

**2. Add a REST Controller**

To make these models available to our application we need to create a Spring Controller. Controllers are the **C** in the MVC pattern which mediate between our views and our internal models / business logic. Here we need to create a Spring `@RestController` annotated Java class. For this you need to click on the following link which will open an empty file in the editor: ``src/main/java/com/example/service/FruitController.java``{{open}}

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

}
</pre>

The `@RestController` annotation tells Spring that this is a special kind of Controller meant to be returning data (not views) when called. If we used the standard Spring `@Controller` annotation instead we would have to also annotate the `getAll()` method (and any other API methods for that matter) with the `@ResponseBody` annotation. `@RestController` implies the `@ResponseBody` annotation for us so we don't have to type it every time!

Normally you would be wiring in Repositories or Services to do actual business logic. We cover these topics in subsequent modules.

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

## Congratulations

You have now learned how to how to create RESTful Web APIs with Spring Boot! 

In next step of this scenario, you will learn how to access and login to your OpenShift environment. 