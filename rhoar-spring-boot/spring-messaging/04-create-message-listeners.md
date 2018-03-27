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

In the last section we added a dependency to our `FruitsController` class for a class called `JmsTemplate`. If you re-open ``src/main/java/com/example/service/FruitController.java``{{open}} you can see this snippet near the top:

```java
private FruitRepository repository;
private JmsTemplate jmsTemplate;

@Autowired
public FruitController(FruitRepository repository, JmsTemplate jmsTemplate) {
    this.repository = repository;
    this.jmsTemplate = jmsTemplate;
}
```

This setup injects and instance of a `JmsTemplate` into the Controller. As the name implies: the `JmsTemplate` class is the primary abstraction we will use to send Messages to JMS Destinations using Spring. With the `JmsTemplate` we can send messages to Queues asynchronously. When a `MessageConverter` is registered (like the Jackson Converter we covered earlier) the `JmsTemplate` will also automatically serialize our Java Objects for us!

We left a TODO in the `createFruit()` method for sending said JMS Message. Copy the below content into the method at that TODO (or use the `Copy to Editor` button):

<pre class="file" data-filename="src/main/java/com/example/service/FruitController.java" data-target="insert" data-marker="// TODO JMS Message send here">
jmsTemplate.convertAndSend("fruitMailbox", fruit);
</pre>

This one line of code will serialize our `Fruit` input to a JSON string and send that JSON to the `fruitMailbox` JMS Queue _asynchronously_. Note that the String here _must match_ the String we supplied to the `@JmsListener(destination = STRING_HERE)` annotation from our Receiver. While these Queue names are generally kept in configuration files we hard-code them here for simplicity.

**4. Test the service from a web browser locally**

Run the application by executing the below command:

``mvn spring-boot:run``{{execute}}

In the interest of time, we will skip creating test cases for the service and instead test it directly in our web browser.

When the console reports that Spring is up and running access the web page by either click the Web Browser Tab or use [this](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/) link.

![Local Web Browser Tab](../../assetsmiddleware/rhoar-getting-started-spring/web-browser-tab.png)

If everything works the web page should look something like this:

![Fruit List](../../assetsmiddleware/rhoar-getting-started-spring/fruit-list.png)

Now that we have implemented the `createFruit()` function try typing a new Fruit into the `Add a Fruit` text box and click the `Save` button. The page should automatically refresh however the new Fruit may or may not show up immediately. If it doesn't simply refresh the page again. But _why does that happen_?

Recall that we said that the `jmsTemplate.convertAndSend()` method was *asynchronous*. This means that the code in our controller will not wait for the `convertAndSend()` method to complete before moving on and returning the redirect to the user. If this happens before the `convertAndSend()` method completes it will look like it didn't work. A quick refresh can show us it actually did. In more complex applications the web application would be responding to events when the Message is actually sent but this is out of scope for this scenario.

Press **CTRL+C** to stop the application.

## Congratulations

You have now learned how to how to create JMS Queue listeners and how to send JMS Messages with Spring Boot! 