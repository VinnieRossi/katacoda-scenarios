In this scenario you will learn more about developing Spring Boot applications using the [Red Hat OpenShift Application Runtimes](https://developers.redhat.com/products/rhoar) platform. We will be building a simple
Spring Boot Web Application using the Model/View/Controller pattern with Spring's MVC framework. 

## What is MVC?

Going too in-depth into MVC is outside the scope of this training, but we're going to be covering what an implementation of a **Model-View-Controller** setup looks like using Spring. This means that we'll be creating a **Model** that will be modeling some (fake) data, a **View** so the user will be able to see that data, and a **Controller** that will be responsible for controlling how that data is modified. For the *Model* and *Controller* we'll be using a lot of the built in Spring `@Attributes` and we'll explain those as we come by them, but for the *View* we're also going to be using a library called **Thymeleaf** that we'll be taking a look at as well.