#ssh root@host01 "docker pull registry.access.redhat.com/jboss-fuse-6/fis-java-openshift:latest"
ssh root@host01 'until $(oc status &> /dev/null); do sleep 1; done && sleep 5 && (oc login -u system:admin >> /opt/logs && oc project openshift >> /opt/logs && oc create -f https://raw.githubusercontent.com/jboss-fuse/application-templates/master/fis-image-streams.json >> /opt/logs)'


