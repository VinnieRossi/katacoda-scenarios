# Deploy to OpenShift Application Platform with Fabric8

Now that we've seen how to deploy the application through the launcher in the web view, let's try to deploy our application using Fabric8.

**1. Log in to the OpenShift Container Platform**

We're going to be using the OpenShift Container Application Platform that Katacoda sets up for us automatically, saving us the time of having to set up an OpenShift instance locally. There is a perfect copy of the application that we've just downloaded and modified already set up for us locally for OpenShift to access. We can verify this by executing a ``tree``{{execute}} command. The layout should perfectly match our previously setup application.

Since we have our application set up locally, the next step is to log in to the OpenShift platform. To do that, we will use the `oc` command and then specify a username and password like this:

``oc login -u developer -p developer``{{execute}}


**2. Create a Project**

[Projects](https://docs.openshift.com/container-platform/3.6/architecture/core_concepts/projects_and_users.html#projects) are a top-level concept to help you organize your deployments. An OpenShift project allows a community of users (or a user) to organize and manage their content in isolation from other communities. Each project has its own resources, policies (who can or cannot perform actions), and constraints (quotas and limits on resources, etc.). Projects act as a wrapper around all the application services and endpoints you (or your teams) are using for your work.

For this scenario let's create a project that you will use to house your application. 

``oc new-project dev --display-name="Dev - Spring Boot App"``{{execute}}


**3. Deploy the application to OpenShift**

Run the following command to deploy the application to OpenShift:

``mvn package fabric8:deploy -Popenshift``{{execute}}

There's a lot that happens here so lets break it down:

The `mvn package` piece of the above command instructs Maven to run the package lifecycle. This builds a Spring Boot JAR file which is a Fat Jar containing all dependencies necessary to run our application.

For the deployment to OpenShift we are using the [Fabric8](https://fabric8.io/) tool through the `fabric8-maven-plugin` which is configured in our ``pom.xml``{{open}} (found in the `<profiles/>` section). Configuration files for Fabric8 are contained in the ``src/main/fabric8``{{open}} folder mentioned earlier.

This step may take some time to do the Maven build and the OpenShift deployment. After the build completes you can verify that everything is started by running the following command:

``oc rollout status dc/rhoar-training``{{execute}}

You should see output in the console similar to `replication controller "rhoar-training" successfully rolled out`. Then you can either go to the OpenShift web console and click on the route or click [here](http://rhoar-training-dev.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com). You should see the same page as before, the only difference was in our strategy of deployment.

## Congratulations

You have now learned how to deploy a Spring Boot application to OpenShift Container Platform with Fabric8.

Click Summary for more details and suggested next steps.
