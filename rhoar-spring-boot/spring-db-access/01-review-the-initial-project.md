# TODO 

# Review the base structure of the application

For your convenience, this scenario has been created with a base project using the Java programming language and the Apache Maven build tool. Initially the project contains a couple web-oriented files which are out of scope for this module. See the Spring MVC / Rest Services module for more details. These files are in place to give a graphical view of the Database content. Start by reviewing the base project's content by executing a ``tree``{{execute}} in your terminal.

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

One thing to note differs slightly from a standard Spring Boot project (like what you get from the [Spring Initializr](https://start.spring.io)) is the ``pom.xml``{{open}} file.

As you review the content you will notice that there are a couple **TODO** comments. **Do not remove them!** These comments are used as markers for later exercises in this scenario. 

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

As it stands this project will not run or compile. In the next section we will add the dependencies and class files necessary to run the application.

## Congratulations

You have now successfully executed the first step in this scenario. In next step of this scenario we will add the logic to be able to read a list of fruits from the database.
