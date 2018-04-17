# Download the initial project

While the [Spring Initializr](https://start.spring.io) tool very handy for creating Spring Applications quickly, there was still some configuration that was required on our side to get the project into a ready state for OpenShift. Luckily OpenShift provides a tool that will allow us to skip these additional steps when generating a Spring Boot application that's destined for OpenShift deployment!

**1. Introducing the RHOAR Launcher** 
The Red Hat OpenShift Application Runtime (RHOAR) Launcher is a tool that will allow us to generate a Spring Boot application with the exact configurations that we need to plug into OpenShift in as few steps as possible. It's a quick and easy-to-follow multi-step process that can be found [here](https://developers.redhat.com/launch/filtered-wizard/all). It will require an OpenShift account, so make sure that you have your login information handy.

To get started, simply click the `Launch Your Project` button.

**2. Running through the Launcher**
The first section that we run into is asking about Deployment type. The `OpenShift Online` deployment will take multiple steps for you, creating a github repository with all of the new project's code and automatically hooking up Continuous Delivery on the newly created respository's master branch. That's pretty powerful! But for learning purposes, we're going to stick with the second option to `Build and run locally`. Click the button to continue.

The next page is introducing us to a few different types of base projects known as "Missions". They're simple projects that have been created with a mission in mind, one simple function that they wish to convey to the user. For simplicity's sake, we're going to choose the `REST API Level 0` mission, a basic application which will just respond to the user through a simple REST API. Select the radio button and click Next:

![REST API](../../assets/middleware/rhoar-creating-applications-for-cloud/rest-api.png)

The next choice is Runtime. Since we're sticking with Spring Boot, this one is an easy choice. Click Spring Boot and then Next.

![Spring Boot](../../assets/middleware/rhoar-creating-applications-for-cloud/spring-boot.png)

This screen will ask for project information. We can keep the defaults and click Next again.

This brings us to the review page. If everything looks good, go ahead and click the `Download as ZIP file` button to get your base project locally. 

Unzip the application and load it into STS (same as before) and take a look at the files. You'll see that the project already has the fabric8 folder and the ``pom.xml``{{open}} file has already had some configurations built in for OpenShift. Our application is ready to be deployed.


## Congratulations

You have now successfully executed the second step in this scenario. In next step we will go over one option to deploy our application to the OpenShift Container Platform via Fabric8. This example is extremely simple as it is meant to only introduce you to Spring Boot and RHOAR.