In this scenario you will learn more about developing Spring Boot applications using the [Red Hat OpenShift Application Runtimes](https://developers.redhat.com/products/rhoar) platform. We will be building a simple Spring Boot application with a Database Persistence layer backed by RHOAR's Database options.

## What we're covering

We're going to be taking the Fruit application that we've been working on in the past few modules and change it up a bit. We're going to be adding database access so that the changes we make to our application are actually stored somewhere. This means that any modifications that we make to our application will now persist if we were to refresh or navigate away from the application. 

For our database technology, we're going to be using `JPA` and `Hibernate`, as well as `H2` for a local database for testing. These are libraries that Spring provides and will help us when creating our repositories and managing our data.