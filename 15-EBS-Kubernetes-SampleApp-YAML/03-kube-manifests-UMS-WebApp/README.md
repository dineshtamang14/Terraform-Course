## Connect to MySQL Database Pod
```t
# Connect to MySQL Database 
kubectl run -it --rm --image=mysql:5.6 --restart=Never mysql-client -- mysql -h mysql -pdbpassword11

# Verify usermgmt schema got created which we provided in ConfigMap
mysql> show schemas;
mysql> use webappdb;
mysql> show tables;
mysql> select * from user;

## Sample Output for above query
+--------+----------------------------+------------+-----------+--------------------------------------------------------------+--------+-----------+
| userid | email_address              | first_name | last_name | password                                                     | ssn    | user_name |
+--------+----------------------------+------------+-----------+--------------------------------------------------------------+--------+-----------+
|    101 | admin101@stacksimplify.com | Dinesh     | smith     | $2a$10$w.2Z0pQl9K5GOMVT.y2Jz.UW4Au7819nbzNh8nZIYhbnjCi6MG8Qu | ssn101 | admin101  |
+--------+----------------------------+------------+-----------+--------------------------------------------------------------+--------+-----------+
1 row in set (0.00 sec)
mysql> 

Observation:
1. If UserMgmt WebApp container successfully started, it will connect to Database and create the default user named admin101
Username: admin101
Password: password101
```