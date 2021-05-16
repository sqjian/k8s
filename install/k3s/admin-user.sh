kubectl create -f yaml/dashboard.admin-user.yml -f yaml/dashboard.admin-user-role.yml
kubectl -n kubernetes-dashboard describe secret admin-user-token | grep ^token