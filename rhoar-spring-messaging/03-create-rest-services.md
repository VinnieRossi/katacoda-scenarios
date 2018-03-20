# Create REST services for the fruit web application

RESTful web services are one of the core use cases for the Spring Boot framework as Spring makes it very easy to create HTTP APIs serving a variety of data types.

**1. Add a REST Controller**

To make these models available to our application we need to create a Spring Controller. Controllers are the **C** in the MVC pattern which mediate between our views and our internal models / business logic. Here we need to create a Spring `@Controller` annotated Java class. For this you need to click on the following link which will open an empty file in the editor: ``src/main/java/com/example/service/FruitController.java``{{open}}

Then, copy the below content into the file (or use the `Copy to Editor` button):

<pre class="file" data-filename="src/main/java/com/example/service/FruitController.java" data-target="replace">
package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;

@Controller
@RequestMapping(value = "/api/fruits")
public class FruitController {

    private FruitRepository repository;
    private JmsTemplate jmsTemplate;

    @Autowired
    public FruitController(FruitRepository repository, JmsTemplate jmsTemplate) {
        this.repository = repository;
        this.jmsTemplate = jmsTemplate;
    }

    @GetMapping
    @ResponseBody
    public List<Fruit> getAll() {
        return StreamSupport.stream(repository.findAll().spliterator(), false).collect(Collectors.toList());
    }

    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping
    public String createFruit(@RequestBody(required = false) Fruit fruit) {
        // TODO JMS Message send here
        return "redirect:/";
    }

}
</pre>

>**NOTE:** You can ignore the `JmsTemplate` field for now. We will revisit this in the next section.

The `@Controller` annotation tells Spring that this class is a HTTP Controller and the `@RequestMapping` annotation identifies it as a Controller meant to handle requests to the `/api/fruits` URI. Here we have two kinds of responses. The `getAll()` method returns a JSON list of all Fruits we have stored in our Database.
The `createFruit()` method triggers a save to the Database for a new fruit and then returns a *redirect* to the root view (the main page of our application in this case). This redirect is a convenience action we will describe later.

It is worth noting that there is also a second annotation that exists: `@RestController`. This annotation is a convenience annotation for Controllers who only return data and not views. It removes the need to annotate your data-returning methods with the `@ResponseBody` annotation. Since we return both data and views in this Controller, however, we use the standard `@Controller`.

**2. Test the service from a web browser locally**

Run the application by executing the below command:

``mvn spring-boot:run``{{execute}}

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

In next step of this scenario you will learn how to send Messages to a JMS Queue.