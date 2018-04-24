# Service Discovery

When we're handling a microservice architecture, it's very possible that we have multiple services across multiple servers or even multiple data servers. While the end user might not care much about the location of any of these services, our application is obviously highly concerned with the connection details for each service. This problem is addressed with `Service Discovery`.

**1. What is Service Discovery?**

As we mentioned, when services become spread out they become difficult to manage. It's tough to keep track of where each service is and what we need to connect to each service. Service Discovery is exactly what it sounds like, the process of discovering all of our exposed services and how to connect with them.

(https://appdev.openshift.io/docs/spring-boot-runtime.html#creating-a-basic-spring-boot-application_spring-boot)

**2. How Service Discovery is handled in OpenShift**

Service Discovery is functionality built into OpenShift by default. Discovers Service/Endpoint deployed on OpenShift and exposed behind a service or route using the service name matching a DNS entry.


## Congratulations

We've now gone over two important core concepts when dealing with a microservice architecture and took a look at how OpenShift handles all of the heavy lifting for us.
