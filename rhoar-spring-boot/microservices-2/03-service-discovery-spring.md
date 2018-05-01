# Service Discovery and Load Balancing with Spring

Now that we've seen what OpenShift comes with out of the box, let's take a look at other options available to us within the Spring ecosystem.

**1. Spring Libraries - Eureka and Ribbon**


TALK ABOUT LIBRARIES HERE

Netflix Ribbon includes Eureka for service discovery + load balancing?
We're going to be looking at how Spring handles Service Discovery with a popular Netflix library known as `Eureka`. Eureka is a REST service that's used for You can view the library and check out the `README.md` [here](https://github.com/Netflix/eureka).
Eureka blah blah. Using project from here: https://github.com/spring-guides/gs-service-registration-and-discovery. Eureka on port `8761`
(need second terminal)

**2. Deploy Eureka Service**

When integrating the Eureka library with an existing spring application there are three main changes that have to be made.

1. First we must include the dependency in the existing service pom file. ``eureka-service/pom.xml``{{open}}
This can be done by adding this snippet to the pom, although we've already added it to ours:

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-eureka</artifactId>
    <version>1.1.5.RELEASE</version>
</dependency>
```

2. The second important step is that we must add the `@EnableEurekaServer` annotation to our main application file, right where we start our Spring application. We can see that in the following file: ``eureka-service/src/main/java/hello/EurekaServiceApplication.java``{{open}}

```java
@EnableEurekaServer
@SpringBootApplication
public class EurekaServiceApplication {
    
    public static void main(String[] args) {
        SpringApplication.run(EurekaServiceApplication.class, args);
    }
}
```

3. The last step is to add some default properties into our `application.properties` file. Again we've already added ours, as seen here: ``eureka-service/src/main/resources/application.properties``{{open}}

```yaml
server.port=8761

eureka.client.register-with-eureka=false
eureka.client.fetch-registry=false

logging.level.com.netflix.eureka=OFF
logging.level.com.netflix.discovery=OFF
```

Since our application already has Eureka integrated, navigate to our service project location and build the project so that we're able to access it locally:

``cd eureka-service/``{{execute}}

``mvn spring-boot:run``{{execute}}

After that's finished building successfully, click the link [here](https://[[HOST_SUBDOMAIN]]-8761-[[KATACODA_HOST]].environments.katacoda.com/) to look at our web view for our Eureka Discovery Client. Note that it's exposed on the port that we set in our `application.properties` file.

![Eureka client](../../assets/middleware/rhoar-microservices/eureka-client.png)

<!-- https://2886795327-8761-simba02.environments.katacoda.com/ -->
<!-- ``mvn package fabric8:deploy -Popenshift``{{execute}} -->

**3. Deploy Eureka Client**
DEPLOY CLIENT AND VERIFY REGISTERED

1. dependency
``eureka-client/pom.xml``{{open}}

2. `@EnableDiscoveryClient`
``eureka-client/src/main/java/hello/EurekaClientApplication.java``{{open}}

3. properties in application.properties
``eureka-client/src/main/resources/application.properties``{{open}}



``cd code/eureka-client/``{{execute}}

``mvn spring-boot:run``{{execute}}

now go on client, see that it's registered

<!-- 
https://spring.io/guides/gs/service-registration-and-discovery/

http://www.baeldung.com/spring-cloud-netflix-eureka
http://www.baeldung.com/spring-cloud-rest-client-with-netflix-ribbon

 -->

## Congratulations

We've now gone over two important core concepts when dealing with a microservice architecture and took a look at how OpenShift handles all of the heavy lifting for us in regards to Load Balancing and Service Discovery!
