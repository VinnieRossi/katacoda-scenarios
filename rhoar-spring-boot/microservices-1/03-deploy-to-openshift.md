# Deploy to OpenShift Application Platform

**1. Additional Configuration**

Before we deploy the application, we have to make a few changes so our application runs smoothly using External Configurations.

The first step is we're going to assign view access rights to the our deveoper account. We have to do this before deploying the application, so that it's able to access the OpenShift API in order to read the contents of the ConfigMap. We can do that with the following command:

``oc policy add-role-to-user view -n $(oc project -q) -z default``{{execute}}

The next step is to create our ConfigMap configuration and deploy it to OpenShift using:

``oc create configmap app-config --from-file=greeting-service/src/main/etc/application.properties``{{execute}}

>**NOTE:** The only two parameters this command needs are the name of the ConfigMap to create and the file location. This command is creating a ConfigMap named `app-config`. We're going to be using that name in future commands. If you decide to manually run the command or give the ConfigMap a different name, make sure you modify the other commands accordingly.

Now we're ready to deploy!

**2. Deploy the application to OpenShift**

Run the following command to deploy the application to OpenShift

``mvn package fabric8:deploy -Popenshift``{{execute}}

There's a lot that happens here so lets break it down:

The `mvn package` piece of the above command instructs Maven to run the package lifecycle. This builds a Spring Boot JAR file which is a Fat Jar containing all dependencies necessary to run our application.

For the deployment to OpenShift we are using the [Fabric8](https://fabric8.io/) tool through the `fabric8-maven-plugin` which is configured in our ``pom.xml``{{open}} (found in the `<profiles/>` section). Configuration files for Fabric8 are contained in the `src/main/fabric8` folder mentioned earlier.

**3. Connection to the application via the Route**

Now that our application is deployed to OpenShift, how do external users access it? The answer is with a route. By using a route, we are able to expose our services and allow for external connections at a given hostname. Open the OpenShift web view and we can see the route that was created for our application. Navigate to the Overview page and expand our deployment tab. Under the `ROUTES External Traffic` section we should see our provided route.
![Routes](../../assets/middleware/rhoar-monitoring/overviewRoutes.png)



## Congratulations

You have now learned how to deploy a Spring Boot application to OpenShift Container Platform, as well as access the application via an external route. In our next step, we will navigate through OpenShift's web console in order to view our application and learn about health checks.