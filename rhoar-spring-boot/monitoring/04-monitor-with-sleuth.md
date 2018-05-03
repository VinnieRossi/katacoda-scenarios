# Additional Monitoring

Our health check is nice to determine if our application is online and healthy but it would be nice if we had some additional tools for debugging and monitoring our application. For that, we're going to be using a Spring library known as `Spring Cloud Sleuth`, a tracing tool that will assist in our logging.

**1. Sleuth and Tracing**

Spring Cloud Sleuth is a project that was created to help developers track flows as requests travel throughout their systems. Sleuth uses similar terminology to Dapper, but we'll go over a quick overview to make sure we're all on teh same page.

The concept of Tracing is simple; track a request as it passes through our system and periodically log the request so we can see if/when the requests became corrupted. If we log at every entry and exit point of all of our components we can greatly decrease the time spent debugging. We're able to very quickly narrow down where and when the application entered a failure state.

If we were to have a request that went through multiple services and then returned, the entire lifecycle would be the full `trace`. As it passes through the different entry and exit points it enters a new `span` of its lifecycle, which is why we call those `Spans`. Since a single `trace` can have multiple `spans`, we create a single `traceID` for our component but multiple `spanIDs`, depending on the span that it's currently in.

Luckily for us Sleuth handles all of these complexities! All we have to do is include the library in our project and we're good to go! To include Sleuth we have to add the required dependency to our pom file:

<pre class="file" data-filename="pom.xml" data-target="insert" data-marker="<!-- TODO: Add Sleuth dependency here -->">
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-sleuth</artifactId>
</dependency>
</pre>

Add some base logging and view log

`log.info("Entering application");`
`timer 3 seconds`
`log.info("Leaving application");`

Add zipkin to see visuals?

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-zipkin</artifactId>
</dependency>
```


## Congratulations

We've now added Sleuth to our application, allowing us to quickly and easily monitor and debug our application by including however much logging we think is reasonable. You can view the Github profile and readme for Sleuth [here](https://github.com/spring-cloud/spring-cloud-sleuth). 