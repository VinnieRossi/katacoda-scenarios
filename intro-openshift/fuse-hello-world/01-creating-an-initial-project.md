Make sure you have follow the Step 1 and 2 step of Hello world developers.redhat.com
And now we are ready to login to OpenShift and deploy our application on the platform.

#Setup OpenShift

To login to the OpenShift use the following command in the **_Terminal_** frame:

``oc login -u developer -p developer``{{execute}}

This will log you in using the credentials:

* **Username:** ``developer``
* **Password:** ``developer``

You should see the output:

```
Login successful.

Now we need to create a Project space in OpenShift for our API.  In OpenShift we can create a new project by running

    oc new-project <projectname>
```

For our project lets create a project called ``fuselab`` by running the command:

``oc new-project fuselab``{{execute}}

You should see output similar to:

```
Now using project "fuselab" on server "https://172.17.0.41:8443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app centos/ruby-22-centos7~https://github.com/openshift/ruby-ex.git

to build a new example application in Ruby.
```

Now switch to the **_Dashboard_** frame (Click on the tab next to the Terminal tab) and login to the OpenShift web console using the
same credentials you used above.

![Web Console Login](../../assets/intro-openshift/fuse-hello-world/01-web-console-login.png)

This should take you to the list of projects you have access to. As we only
created the one project, all you should see is ``fuselab``.

![List of Projects](../../assets/intro-openshift/fuse-hello-world/01-list-of-projects.png)

Click on ``fuselab `` to be taken to the project **_Overview_** page for ``fuselab``.

![Project Overview](../../assets/intro-openshift/fuse-hello-world/01-project-overview.png)

As the project is currently empty, you should be presented with an **_Add to Project_** button. Click **_Continue_** on to see how to add the first application to this project.
