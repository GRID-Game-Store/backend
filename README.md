# Project GRID

This is backend part of educational GRID project. Instruction describes how to clone and run the project on your local
machine.

## Getting Started

These instructions will help you get a copy of the project and running it on your local machine for development and
testing purposes.

## How to Run

This application requires
pre-installed [JDK 17](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html) or
higher. [See more.](https://www.oracle.com/java/technologies/downloads/#jdk19-windows)

* Clone this repository

```
git clone https://github.com/GRID-Game-Store/backend
```

* Make sure you are using JDK 17 and Maven
* You can build the project and run the tests by running ```mvn clean package```
  or
  ```mvn install / mvn clean install```

### Run Spring Boot app using Maven:

Now you can launch the server 8082.

* run Spring Boot app using Maven:
  ```mvn spring-boot:run```
* [optional] Run Spring Boot app with``` java -jar command
  java -jar target/backend-0.0.1-SNAPSHOT.jar```

### Run Spring Boot app using Docker:
To run Spring Boot app using Docker:
* Run the Docker Compose file inside backend folder:
  ```docker-compose -f docker-compose.yml up```

[Link to documentation](https://github.com/GRID-Game-Store/documentation/blob/main/backend/docker.md)

### Built With:

* Maven - Build tool
* Spring Boot - Web framework
* JUnit - Testing framework

## Authors:

* [SEM24](https://github.com/SEM24)
