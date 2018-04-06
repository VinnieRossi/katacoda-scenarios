# Deploy to OpenShift Application Platform

<!-- Before we deploy the application to OpenShift we need to add health checks so that OpenShift can correctly detect if our application is working. For this simple application we will simply leverage another Spring Boot project: Spring Actuator.

**1. Add a health check**

Spring Boot provides a nice feature for health checks called Actuator. Actuator is a project which exposes health data under the API path `/health` that is collected during application runtime automatically. All we need to do to enable this feature is to add the following dependency to ``pom.xml``{{open}} at the **TODO** comment..

<pre class="file" data-filename="pom.xml" data-target="insert" data-marker="<!-- TODO: Add Actuator dependency here -->">
    &lt;dependency&gt;
      &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;
      &lt;artifactId&gt;spring-boot-starter-actuator&lt;/artifactId&gt;
    &lt;/dependency&gt;
</pre> -->

**1. Deploy the application to OpenShift**

Run the following command to deploy the application to OpenShift

``mvn package fabric8:deploy -Popenshift``{{execute}}

There's a lot that happens here so lets break it down:

The `mvn package` piece of the above command instructs Maven to run the package lifecycle. This builds a Spring Boot JAR file which is a Fat Jar containing all dependencies necessary to run our application.

For the deployment to OpenShift we are using the [Fabric8](https://fabric8.io/) tool through the `fabric8-maven-plugin` which is configured in our ``pom.xml``{{open}} (found in the `<profiles/>` section). Configuration files for Fabric8 are contained in the ``src/main/fabric8``{{open}} folder mentioned earlier.

After the Maven build has finished, it will typically take less than 20 sec for the application to be available. To verify that everything is started run the following command and wait for it to report that the replication controller successfully rolled out:

``oc rollout status dc/rhoar-training``{{execute}}

You should see output in the console similar to `replication controller "rhoar-training" successfully rolled out`. If you take another look at your OpenShift web view, you should see that your application now displays on the Overview page.



## Congratulations

You have now learned how to deploy a Spring Boot application to OpenShift Container Platform. In our next step, we will navigate through OpenShift's web console in order to view our application and learn about health checks.