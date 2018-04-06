# Navigate OpenShift and understanding Health Checks

Now that our project has been deployed to OpenShift we are able to see it in OpenShift's web view. From there we can see information about our project and verify that we're able to connect to it through OpenShift.

**1. View Health Checks**

Now our app is up everything is perfect. Except! what if it goes down?
We need OpenShift to know if the app crashes so that it can spin up another instance. Here is a link [here](https://docs.openshift.org/latest/dev_guide/application_health.html)

Go back to overview and click on your deployment. You should see this image: <IMAGE>
Click on `Configuration` and take a look at all the info here. Oh no! We have an error about missing health checks! <IMAGE>

There are two types of health checks, but ours can serve a multi purpose. We are going to use Spring Actuator since it's a spring library and openshift loves spring.
Spring Boot provides a nice feature for health checks called Actuator. We're gonna use that. 

**2. Add Health Checks**

Actuator is a project which exposes health data under the API path `/health` that is collected during application runtime automatically. All we need to do to enable this feature is to add the following dependency to ``pom.xml``{{open}} at the **TODO** comment..

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

Now navigate to health endpoint. See what it is? neat.

**3.Other Spring Actuator endpoints**

Look at all these other endpoints. You can't hit them without auth. OR put in this line (debug only) and try hitting some of the endpoints to see what type of data you get back.

(endpoints)[https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-endpoints.html]

In order to get awesome links, need to disable security. Put this code in this file, but don't do this in prod.

<pre class="file" data-filename="application.properties" data-target="insert" data-marker="# TODO: Add Security preference here">
management.security.enabled=false
</pre>

## Congratulations

You have now included a health check in your Spring Boot application that's living in the OpenShift Container Platform. In our next step? click summary?