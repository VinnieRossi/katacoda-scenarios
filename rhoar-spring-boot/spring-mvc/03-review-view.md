# Review the Home View

There are a number of View libraries supported by Spring MVC. One that has gained a lot of popularity and support is [Thymeleaf](https://www.thymeleaf.org/). Thymeleaf is often considered a HTML extension as Thymeleaf views are HTML with a couple of Thymeleaf tags added. The benefit of this over something like JSPs is that Thymeleaf views still open in Web Browsers without the need for a running server. While this won't be a full in-depth overview of Thymeleaf we will cover some of the basics.

For our application we will use Thymeleaf. We already added the Spring Boot Starter POM for Thymeleaf in the first step. Spring Boot has a convention for Thymeleaf views: if a Thymeleaf View resides in the `src/main/resources/templates` folder it will automatically register that View for us. We have added the Home view for you so let's open that view: `src/main/resources/templates/home.html`{{open}}

The first thing to notice in this file is the `<html xmlns:th="http://www.thymeleaf.org">` tag. The `xmlns:th` describes the Thymeleaf namespace and assigns it to the `th` prefix. This gives us access to the Thymeleaf tag attributes.

We then skip down to the Form: `<form action="#" th:action="@{/api/fruits}" th:object="${fruitForm}" method="post">`. As you can see this is a standard HTML `<form>` with two Thymeleaf tags added.

`th:action` is our first Thymeleaf tag. 