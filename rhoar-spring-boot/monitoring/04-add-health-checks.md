# Implementing Health Checks

Now that our project has been deployed to OpenShift and we've verified that we're able to hit our endpoint, it's time to add a health check to the application.

**1. View Health Checks**

Our application is now up and running on OpenShift and accessible to all users. However how do we handle an application failure? Without constantly manually veriifying the application there would be no way to know when the application crashes. Luckily OpenShift can handle this issue by using a probe for health checks.

There are two types of probes that we can create; a `liveness probe` and a `readiness probe`. Liveness probes are used to check if the container is still running. Readiness probes are used to determine if containers are ready to service requests. We're going to be creating a health check,  a type of liveness probe.

Our health check will continually poll the application to ensure that the application is up and healthy. If the check fails, OpenShift will be alerted and restart the container, spinning up a brand new instance. You can read more about the specifics [here](https://docs.openshift.org/latest/dev_guide/application_health.html).

Since a lack of health checks can cause container issues if they crash, OpenShift will alert you with a warning message if your project is lacking one. 

Go back to overview and click on your deployment.
![Application Deployment](../../assets/middleware/rhoar-monitoring/application-deployment.png)

Click on `Configuration` and we can see the warning message here.
![Missing Health Checks](../../assets/middleware/rhoar-monitoring/missingHealthChecks.png)


Since we have a Spring Boot application we have an easy option for implementation of health checks. We're able to pull in the `Spring Actuator` library.

**2. Add Health Checks with Actuator**

Spring Actuator is a project which exposes health data under the API path `/health` that is collected during application runtime automatically. All we need to do to enable this feature is to add the following dependency to ``pom.xml``{{open}} at the **TODO** comment..

<pre class="file" data-filename="pom.xml" data-target="insert" data-marker="<!-- TODO: Add Actuator dependency here -->">
    &lt;dependency&gt;
      &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;
      &lt;artifactId&gt;spring-boot-starter-actuator&lt;/artifactId&gt;
    &lt;/dependency&gt;
</pre>

Now run the following command again to re-deploy the application to OpenShift:

``mvn package fabric8:deploy -Popenshift``{{execute}}

And verify with this command:

``oc rollout status dc/rhoar-training``{{execute}}

Now let's navigate to our health endpoint. Click the link [here]() and we should now see the following response, confimring that our application is up and running properly:

```json 
{"status":"UP"}
```

**3.Other Spring Actuator endpoints for monitoring**

The `/health` endpoint isn't the only endpoint that Spring Actuator provides out of the box. We're going to take a closer look at a few of the different endpoints so we can see how they help us with monitoring our newly deployed application, specifically the `/metrics` and `/beans` endpoints. You can look at all the endpoints [here](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-endpoints.html).

Unlike the `/health` endpoint however, some of these endpoints can return sensitive information and require authentication. For simplicity purposes we will be removing this security requirement in order to hit the endpoints, but this is not recommended for a production environment with sensitive data. Pull up the application.properties file ``application.properties``{{open}} and add this code to disable endpoint security.

<pre class="file" data-filename="application.properties" data-target="insert" data-marker="# TODO: Add Security preference here">
management.security.enabled=false
</pre>

Now redeploy the application so the changes are reflected and hit the `/health` endpoint again [here](). Since we've removed the security we should be getting a new response with much more content that looks something like:

```json

```

Navigating to the `/metrics` endpoint [here]() will display different types of metric data about the application including memory usage, heap, processors, threads, classes loaded, and some HTTP metrics in a response that looks like:

```json

```

In addition to the different monitoring endpoints we also have informational endpoints like the `/beans` endpoint [here](), which will show all of the configured beans in the application. Spring Actuator provides multiple informational endpoints on top of the monitoring endpoints that can prove useful for information gathering about your deployed Spring application and can be helpful when debugging your applications in OpenShift.

## Congratulations

You have now included a health check in your Spring Boot application that's living in the OpenShift Container Platform. Click Summary for more details and suggested next steps.
