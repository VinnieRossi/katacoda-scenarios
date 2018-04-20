# Deploy to OpenShift and Test Application

**1. Deploy the application to OpenShift**

Run the following command to deploy the application to OpenShift

``mvn package fabric8:deploy -Popenshift``{{execute}}

There's a lot that happens here so lets break it down:

The `mvn package` piece of the above command instructs Maven to run the package lifecycle. This builds a Spring Boot JAR file which is a Fat Jar containing all dependencies necessary to run our application.

For the deployment to OpenShift we are using the [Fabric8](https://fabric8.io/) tool through the `fabric8-maven-plugin` which is configured in our ``pom.xml``{{open}} (found in the `<profiles/>` section). Configuration files for Fabric8 are contained in the `src/main/fabric8` folder mentioned earlier.

**2. Connection to the application**

Now that our application is deployed, navigate to our route in the OpenShift Web View or click [here](https://spring-boot-circuit-breaker-greeting-dev.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/). We should see the following screen, meaning everything was successful:

Either click on the route link through the OpenShift web view or click this link [here](http://spring-boot-circuit-breaker-greeting-dev.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/) in order to view our application.


![Circuit Breaker page](../../assets/middleware/rhoar-microservices/circuit-mainpage.png)


**3. Test current functionality**

``curl http://spring-boot-circuit-breaker-greeting-dev.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/api/greeting``{{execute}}

``curl -X PUT -H "Content-Type: application/json" -d '{"state": "fail"}' http://spring-boot-circuit-breaker-greeting-dev.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/api/state``{{execute}}

``curl http://spring-boot-circuit-breaker-greeting-dev.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/api/greeting``{{execute}}

## Congratulations

You have now learned how to deploy a Spring Boot application to OpenShift Container Platform and we've tested our current application. In our next step, we will trip the Circuit breaker and see how the functionality changes.