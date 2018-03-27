# Review the base structure of the application

For your convenience, this scenario has been created with a base project using the Java programming language and the Apache Maven build tool.

Initially the project is almost empty and doesn't do anything. Start by reviewing the base project's content by executing a ``tree``{{execute}} in your terminal.

The output should look something like this:

```sh
.
|-- pom.xml
`-- src
    `-- main
        |-- fabric8
        |   |-- credentials-secret.yml
        |   |-- deployment.yml
        |   `-- route.yml
        |-- java
        |   `-- com
        |       `-- example
        |           |-- Application.java
        |           `-- service
        `-- resources
            |-- application-local.properties
            |-- application-openshift.properties
            `-- static
                `-- index.html
```


Except for the `fabric8` directory and the `index.html`, this matches what you would get if you generated an empty project using the [Spring Initializr](https://start.spring.io). For the moment you can ignore the content of the fabric8 folder (we will discuss this later).

One thing that differs slightly is the ``pom.xml``{{open}} file.

As you review the content, you will notice that there are a lot of **TODO** comments. **Do not remove them!** These comments are used as markers for later exercises in this scenario. 

Notice that we are not using the default BOM (Bill of material) that Spring Boot projects typically use. We are using a BOM provided by Red Hat as part of the [Snowdrop](http://snowdrop.me/) project instead. We use this BOM to make sure that we are using only the dependency versions supported by Red Hat.

```xml
  <dependencyManagement>
    <dependencies>
      <dependency>
        <groupId>me.snowdrop</groupId>
        <artifactId>spring-boot-bom</artifactId>
        <version>${spring-boot.bom.version}</version>
        <type>pom</type>
        <scope>import</scope>
      </dependency>
    </dependencies>
  </dependencyManagement>
```

**1. Adding Apache Tomcat to the application**

Since our application will be a web application we need to use a servlet container like Apache Tomcat or Undertow. Since Red Hat offers support for Apache Tomcat (e.g., security patches, bug fixes, etc.) we will use it here. 

>**NOTE:** Undertow is another an open source project that is maintained by Red Hat and therefore Red Hat plans to add support for Undertow shortly.

To add Apache Tomcat to our project add the following lines in the ``pom.xml``{{open}} (If you left the TODO comments in you can click the `Copy to Editor` button to do this automatically).

<pre class="file" data-filename="pom.xml" data-target="insert" data-marker="<!-- TODO: Add web (tomcat) dependency here -->">
    &lt;dependency&gt;
      &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;
      &lt;artifactId&gt;spring-boot-starter-web&lt;/artifactId&gt;
    &lt;/dependency&gt;
</pre>

There are other dependencies brought in by this Spring Starter POM. We will revisit these later in the scenario.

You may notice that there is no `<version>` tag here. That's because the version numbers are managed and automatically derived by the BOM we included earlier. 

**2. Test the application locally**

As we develop the application we want to be able to test and verify our change at different stages. One way we can do that locally is by using the `spring-boot` maven plugin.

Run the application by executing the following command (it should exit automatically as we do not have any web code yet):

``mvn spring-boot:run``{{execute}}

>**NOTE:** The Katacoda terminal window is like your local terminal. Everything that you run here you should be able to execute on your local computer as long as you have `Java SDK 1.8` and `Maven` installed. In later steps, we will also use the `oc` command line tool for OpenShift commands.

**3. Verify the application**

To begin with, click on the **Local Web Browser** tab in the console frame of this browser window, which will open another tab or window of your browser pointing to port 8080 on your client.

![Local Web Browser Tab](../../../assetsmiddleware/rhoar-getting-started-spring/web-browser-tab.png)

or use [this](https://[[HOST_SUBDOMAIN]]-8080-[[KATACODA_HOST]].environments.katacoda.com/) link.

You should now see an HTML page that looks like this:

![Local Web Browser Tab](../../../assetsmiddleware/rhoar-getting-started-spring/web-page.png)

As you can probably guess by now the application we are building is a Fruit repository where we create different kinds of fruits.

>**NOTE:** None of the buttons work at this stage since we haven't implemented services for them yet.

**4. Stop the application**

Before moving on, click in the terminal window and then press **CTRL-C** to stop the running application!

## Congratulations

You have now successfully executed the first step in this scenario. In next step of this scenario we will add the logic to be able to read a list of fruits from the database.
