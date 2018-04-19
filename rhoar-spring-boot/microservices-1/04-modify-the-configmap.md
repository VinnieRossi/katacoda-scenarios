# Making modifications to the Configuration Map

**1. Modify the ConfigMap**

NOTE SAME NAME Update the deployed ConfigMap configuration.
``oc edit configmap app-config``{{execute}}

NOTE DEPLOY NAME Deploy the new version of your application so the ConfigMap configuration changes are picked up.
``oc rollout latest dc/spring-boot-configmap-greeting``{{execute}}

**1. Test changes**


## Congratulations

You have now learned how to handle Externalized Configuration with ConfigMaps through OpenShift. By creating a configmap, we're able to modify application properties on the fly and simply rollout the new changes to have our application 