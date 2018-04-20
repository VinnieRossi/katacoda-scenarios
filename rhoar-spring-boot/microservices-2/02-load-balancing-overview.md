# Load Balancing

As its name suggests, Load Balancing is the process of balancing the amount of traffic that a system receives by spreading it across multiple resources. It's a useful process that has multiple applications and benefits that we'll take a look at.

**1. Why use Load Balancing?**

As we mentioned, the act of load balancing is done with a Load Balancer and evenly spreads traffic to multiple resources. However the only use of a Load Balancer doesn't have to be for pure efficiency reasons. Because all we're really doing is directing traffic, nothing stops us from directing traffic to specific resources over others for reasons other than balancing traffic.

`A/B testing` is a prime example of functionality that we can achieve through load balancing that isn't directly related to performance. A/B testing is the process of having two slightly different versions of the same application and deploying both. Maybe the first version has a button that we want our users to click on in the top left corner while the second version put the same button in the top right. With Load Balancing we can direct some amount of our traffic to both scenarios and see which ones illicit the desired response from our users. 

In this simple example there may be no reason to filter which users see which outcome so we might pick the participants randomly. However if we wish to make a change be visible to only a smaller subset of our users, let's say all users that are visiting our application from outside of the United States, this is also possible. This is a powerful concept that can be used to continually improve an application through monitoring and measuring small changes made in a production environment with actual users.

On top of testing, we can also use Load Balancing to help implement different deployment strategies that give us some advantages. One of those is the `Blue/Green Deployment` strategy. 
You can read more about `Blue/Green Deployment` [here](https://martinfowler.com/bliki/BlueGreenDeployment.html).

Another example of a deployment strategy that Load Balancing let's us take advantage of is the `Canary Deploment` strategy. Also known as `Phased Rollout` or `Incremental Rollout`, this concept is a simple one. The core concept is that we have some new version of our application that we want to release to production. However since many things can go wrong when moving versions

You can read more about `Canary Deployment` [here](https://martinfowler.com/bliki/CanaryRelease.html).

**2. How Load Balancing is handled in OpenShift**

Load Balancing is functionality built into OpenShift by default.


## Congratulations

Now that we've gone over what Load Balancing is and common use cases, our next step will take a look into another topic that comes up often when discussing microservices, and that's `Service Discovery`.
