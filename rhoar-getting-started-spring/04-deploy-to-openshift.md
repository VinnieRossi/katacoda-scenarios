# Deploy to OpenShift Application Platform

Before we deploy the application to OpenShift we need to add health checks so that OpenShift can correctly detect if our application is working. For this simple application we will simply leverage another Spring Boot project: Spring Actuator.

**1. Add a health check**

Spring Boot provides a nice feature for health checks called Actuator. Actuator is a project which exposes health data under the API path `/health` that is collected during application runtime automatically. All we need to do to enable this feature is to add the following dependency to ``pom.xml``{{open}} at the **TODO** comment..

<pre class="file" data-filename="pom.xml" data-target="insert" data-marker="<!-- TODO: ADD Actuator dependency here -->">
    &lt;dependency&gt;
      &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;
      &lt;artifactId&gt;spring-boot-starter-actuator&lt;/artifactId&gt;
    &lt;/dependency&gt;
</pre>

**2. Deploy the application to OpenShift**

Run the following command to deploy the application to OpenShift

``mvn package fabric8:deploy -Popenshift``{{execute}}

After the Maven build as finished, it will typically take less than 20 sec for the application to be available. To verify that everything is started run the following command and wait for it to report replication controller "fruits-s2i-1" successfully rolled out:

``oc rollout status dc/fruits``{{execute}}

Then either go to the openshift web console and click on the route or click [here](http://fruits-dev.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com)

Make sure that you can add, edit, and remove fruits, using the web application 

## Congratulations

You have now learned how to deploy a Spring Boot application to OpenShift Container Platform. This concludes the first learning scenario for Spring Boot. 

Click Summary for more details and suggested next steps.
