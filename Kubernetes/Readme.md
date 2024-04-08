Prerequisites
---------
1. K8s cluster needed
2. Db details in the ```database-secret.yml``` need to be updated. This can be done in the pipline during thd deployment processs.
3. Set up the build agent to deploy the application to the cluster.
    This may be accomplished by completing the bleow steps
     * cloning the repository
     * changing the directory to ```Kubernetes/deployment-rbac/```
     * running ```kubectl apply -f *.yml -n <namespace>``` 
     * Configure the deployment tool (eg: jenkins) to use this service account

### Commands that can be used in the pipeline
- To install/update the application
  Database: ```kubectl apply -f Kubernetes/database/*.yml -n <namespace>```
  Wordpress: ```kubectl apply -f Kubernetes/wordpress/*.yml -n <namespace>```
- You can access the application by the url : http://<your_node_ip>>:31000
- To delete application
  use ```kubectl delete```  insted of ```kubectl apply``` in the above commands


