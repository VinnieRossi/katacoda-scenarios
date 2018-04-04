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

**2. Deploy a JBoss AMQ Instance**

In order to deploy a JBoss AMQ instance we first need to create a Service Account for the AMQ Broker to run as. To do this we need to execute the following commands. Click on each command or copy/paste into the editor terminal:

``echo '{"kind": "ServiceAccount", "apiVersion": "v1", "metadata": {"name": "amq-service-account"}}' | oc create -f -``{{execute}}
``oc policy add-role-to-user view system:serviceaccount:amq-demo:amq-service-account``{{execute}}

Next we need to add SSL keys. When deploying AMQ to OpenShift we are required to provide SSL keys. If you do not have your own enterprise keys (such as for a Dev environment) you can create your own. Execute the following to create the SSL keys:

``keytool -genkey -noprompt -trustcacerts -alias broker -keyalg RSA -keystore broker.ks -keypass password -storepass password -dname "cn=Dev, ou=engineering, o=company, c=US"``{{execute}}
``keytool -export -noprompt -alias broker -keystore broker.ks -file broker_cert -storepass password``{{execute}}
``keytool -genkey -noprompt -trustcacerts -alias client -keyalg RSA -keystore client.ks -keypass password -storepass password -dname "cn=Dev, ou=engineering, o=company, c=US"``{{execute}}
``keytool -import -noprompt -trustcacerts -alias broker -keystore client.ts -file broker_cert -storepass password``{{execute}}

Next we will import these certificates into OpenShift as secrets:

``oc secrets new amq-app-secret broker.ks && \
oc secrets add sa/amq-service-account secret/amq-app-secret``{{execute}}

Finally we can deploy AMQ: (TODO NOT WORKING)

``oc process amq63-persistent-ssl -p APPLICATION_NAME=amq63 -p MQ_USERNAME=admin -p MQ_PASSWORD=admin -p AMQ_STORAGE_USAGE_LIMIT=1gb -p IMAGE_STREAM_NAMESPACE=openshift -p AMQ_TRUSTSTORE_PASSWORD=password -p AMQ_KEYSTORE_PASSWORD=password -p AMQ_SECRET=amq-app-secret -p AMQ_KEYSTORE=broker.ks -p AMQ_TRUSTSTORE=broker.ks -n amq-demo | oc create -f - && \
oc create route passthrough --service amq63-amq-tcp-ssl && \
oc create route passthrough --service amq63-amq-stomp-ssl && \
oc create route passthrough --service amq63-amq-amqp-ssl && \
oc create route passthrough --service amq63-amq-mqtt-ssl``{{execute}}

**3. Deploy the application to OpenShift**

Run the following command to deploy the application to OpenShift

``mvn package fabric8:deploy -Popenshift``{{execute}}

There's a lot that happens here so lets break it down:

The `mvn package` piece of the above command instructs Maven to run the package lifecycle. This builds a Spring Boot JAR file which is a Fat Jar containing all dependencies necessary to run our application.

For the deployment to OpenShift we are using the [Fabric8](https://fabric8.io/) tool through the `fabric8-maven-plugin` which is configured in our ``pom.xml``{{open}} (found in the `<profiles/>` section). Configuration files for Fabric8 are contained in the ``src/main/fabric8``{{open}} folder mentioned earlier.

After the Maven build as finished, it will typically take less than 20 sec for the application to be available. To verify that everything is started run the following command and wait for it to report replication controller successfully rolled out:

``oc rollout status dc/rhoar-training``{{execute}}

You should see output in the console similar to `replication controller "rhoar-training" successfully rolled out`. Then you can either go to the OpenShift web console and click on the route or click [here](http://rhoar-training-dev.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com)

You should see the same web application as before. The scheduled Producer will continue to deploy messages so clicking refresh should change the values shown every 3 seconds.

## Congratulations

You have now learned how to deploy a Spring Boot JMS application and a JBoss AMQ resource to the OpenShift Container Platform.

Click Summary for more details and suggested next steps.
