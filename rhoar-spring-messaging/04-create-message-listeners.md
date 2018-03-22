# Create JMS Message Listeners

The Java Message Service (JMS) is a standard designed to allow applications to create, send, and receive Messages to form loosely coupled components. Messaging between components is typically asynchronous and is a very common pattern in distributed systems. 

Spring Boot offers abstractions for the JMS standard that make it very quick and easy to create messages from Java objects, send them to destination queues using the familiar Template pattern (akin to Spring's RestTemplate or JdbcTemplate), and to create Receivers (or Listeners) for specific types of messages on Queues.

**1. Create a Message Listener**

To receive messages from a JMS Queue we'll need a class that listens for particular messages. These components (called `Listeners` or `Receivers`) in Spring Boot are `@Component` classes with a method annotated with `@JmsListener`. For this you need to click on the following link which will open an empty file in the editor: ``src/main/java/com/example/service/FruitReceiver.java``{{open}}

Then, copy the below content into the file (or use the `Copy to Editor` button):

<pre class="file" data-filename="src/main/java/com/example/service/FruitReceiver.java" data-target="replace">
package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

@Component
public class FruitReceiver {

    private FruitRepository repository;

    @Autowired
    public FruitReceiver(FruitRepository repository) {
        this.repository = repository;
    }

    @JmsListener(destination = "fruitMailbox")
    public void receiveMessage(Fruit fruit) {
        System.out.println("Received: " + fruit);
        repository.save(fruit);
    }

}
</pre>

This class is pretty similar to our controller classes. We annotate the class with `@Component` to get the class picked up by Spring's Component Scanning. Spring will manage this class' lifecycle and dependencies for us. For dependencies we are autowiring an instance of the `FruitRepository` class to save Fruits received on the Queue to the database.

The `@JmsController` annotation is what sets this class up for JMS Message handling. We're essentially creating a binding: whenever a message of type `Fruit` is sent to the `fruitMailbox` destination (for all intents and purposes: the target Queue) this method will be called by Spring for processing.

There also exists a second annotation parameter, `connectionFactory`, that we can use if we have a custom `ConnectionFactory` Bean but we don't use that here because we are defaulting to use the `ConnectionFactory` Spring Boot automatically creates.

**2. Message Serialization**

Notice that the argument to our `receiveMessage()` method is our domain class: a `Fruit`. We're not accepting any custom types or wrapper objects. This is because Spring magic, under the hood, can convert the raw messages coming into the Queue into our custom objects if we meet a few criteria. For our purposes we are going to send and receive these messages as JSON strings because we have a bit of infrastructure readily available to us due to our Web dependencies.

Under the hood Spring uses a library called Jackson to serialize and deserialize Java objects to and from JSON respectively. This magic is already happening in our REST Controllers - when we returned the `List<Fruit>` from our Controller Spring Boot automagically converted that object to JSON for us without being given any configuration! That is Jackson at work.

With JMS we do require a tiny bit of configuration. For this you need to click on the following link which will open an empty file in the editor: ``src/main/java/com/example/MessageConfig.java``{{open}}

Then, copy the below content into the file (or use the `Copy to Editor` button):

<pre class="file" data-filename="src/main/java/com/example/MessageConfig.java" data-target="replace">
package com.example;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jms.annotation.EnableJms;
import org.springframework.jms.support.converter.*;

@Configuration
@EnableJms
public class MessageConfig {

    @Bean
    public MessageConverter jacksonJmsMessageConverter() {
        MappingJackson2MessageConverter converter = new MappingJackson2MessageConverter();
        converter.setTargetType(MessageType.TEXT);
        converter.setTypeIdPropertyName("_type");
        return converter;
    }

}
</pre>

This `@Configuration` class does two things for us. With the `@EnableJms` annotation we effectively "turn on" Spring Boot's JMS configuration which registers scanning for components with the `@JmsListener` annotation. This is how we tell Spring to search for these classes. 

The single Bean in this class is our `MessageConverter`. Spring Boot uses this class to automatically serialize/deserialize JMS messages. Registering this Bean means that Spring Boot will automatically pick it up and use it for our JMS Messages.

**3. Revisit the Controller**

In the last section we prepared our controller with the following lines:

```java
private FruitRepository repository;
private JmsTemplate jmsTemplate;

@Autowired
public FruitController(FruitRepository repository, JmsTemplate jmsTemplate) {
    this.repository = repository;
    this.jmsTemplate = jmsTemplate;
}
```

This setup injects and instance of a `JmsTemplate` into the Controller. The `JmsTemplate` class is the primary abstraction we will use to send Messages to JMS Destinations using Spring.

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

You have now learned how to how to create JMS Queue listeners and how to send JMS Messages with Spring Boot! 