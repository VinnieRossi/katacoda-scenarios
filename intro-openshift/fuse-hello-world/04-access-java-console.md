After deployment through the JBoss Fuse Console to see the behavior of our new fuse application.  

The JBoss Fuse console provides in depth details into the Camel deployed as part of a Fuse application. This includes standard JVM resources such as memory and threads as well as JMX attributes and operations. The console also provides a full selection of tools used to drill into the Fuse implmentation.

To get there we start with selecting the Applications menu on the left and then select Pods.

![Select Pods menu](../../assets/intro-openshift/fis-deploy-app/04-step1-select-pod.png)

You will be taken directly to the pod detail page. Below the *Template* section on the page you will find a link named "Open Java Console". Go ahead and click it

![Select Java Console](../../assets/intro-openshift/fis-deploy-app/04-select-java-console.png)

You are now taken to the JBoss Fuse Hawtio console. Continue on to see how we can get better insight into the application.

Lets get started by taking a look at some statistics provided by the console.  Select the "Route Diagram" to see a more detailed implementation:

![Select Diagram route](../../assets/intro-openshift/fis-deploy-app/04-select-diagram-route.png)

The Route Diagram tab provides a graphical review of all the routes currently deployed in our API application.  After selecting this tab we should see something similar to what is pictured below; 5 routes represented as Enterprise Integration Patterns, or EIPs. Further details on EIPs can be found at the end of this scenario:

![Detail Camel Route](../../assets/intro-openshift/fis-deploy-app/04-detail-camel-route.png)

Once done, close the console by clicking the back link as shown below and then head back to our terminal:

![Close Hawtio Console](../../assets/intro-openshift/fis-deploy-app/04-hawtio-back-link.png)


Now lets tracing that output out our application in the Hawtio console.


![Camel stats update](../../assets/intro-openshift/fis-deploy-app/04-camel-stats-update.png)


You can clearly identify how many time the route has been called the excuted. Imangine you have a lot more route running, with this capability, you will have an overall idea on how your services are doing. 