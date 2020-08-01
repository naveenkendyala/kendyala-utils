#QUARKUS-DEMO:

#Agenda
# Bring Everyone Upto Speed on UseCase
#Developer Life :: IDE, Project and Work 

#Create a simple demo project
mvn io.quarkus:quarkus-maven-plugin:1.3.2.Final:create -DprojectGroupId=com.demo -DprojectArtifactId=quarkus-api -DclassName="com.demo.ToDoResource" -Dpath="/todos"

#Create using the Red Hat's Build of the Quarkus
mvn io.quarkus:quarkus-maven-plugin:1.3.4.Final-redhat-00004:create \
    -DprojectGroupId=com.demo \
    -DprojectArtifactId=quarkus-api \
    -DplatformGroupId=com.redhat.quarkus \
    -DplatformArtifactId=quarkus-universe-bom \
    -DplatformVersion=1.3.4.Final-redhat-00004 \
    -DclassName="com.demo.ToDoResource" \
    -Dpath="/todos"


#Start the Application in a DEV Mode
#Remove Files under the Test folder

#Modify Greeting
Show                [Hot-Reload Functionality, Startup Time]
Highlight           [Developer Joy]

#List Extensions
mvn quarkus:list-Extensions

#Add Extensions
mvn quarkus:add-extensions -Dextension="jdbc"

ToDo Entity:
@Id
private String id;
private String task;
private String isComplete;


ToDo Service:
@Inject
EntityManager em;

@Transactional
public void upsertToDo(ToDo todo) {
em.merge(todo);
}

@Transactional
public List<ToDo> listToDos() {
TypedQuery<ToDo> query = em.createQuery("SELECT t FROM ToDo t", ToDo.class);
return query.getResultList();
}

# Configuration file
# key = value
# quarkus.datasource.url=jdbc:h2:mem:default
# quarkus.datasource.driver=org.h2.Driver
# quarkus.datasource.username=username-default
# quarkus.datasource.min-size=3
# quarkus.datasource.max-size=13
# quarkus.hibernate-orm.database.generation=drop-and-create
# quarkus.hibernate-orm.log.sql=true
%dev.quarkus.hibernate-orm.sql-load-script = import-data.sql

quarkus.datasource.jdbc.url=jdbc:mysql://localhost:3306/quarkus_api_db
quarkus.datasource.db-kind=mysql
quarkus.datasource.jdbc.driver=com.mysql.cj.jdbc.Driver
quarkus.datasource.username=root
quarkus.datasource.password=demo
quarkus.datasource.max-size=8
quarkus.datasource.min-size=2
quarkus.hibernate-orm.database.generation=drop-and-create
quarkus.hibernate-orm.log.sql=true


import-data.sql
INSERT INTO ToDo (id,task,isComplete) VALUES ('1','Presentation','COMPLETE');
INSERT INTO ToDo (id,task,isComplete) VALUES ('2','Demo','IN-PROGRESS');