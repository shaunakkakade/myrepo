# Deploy Spring Boot Netflix OSS app to IBM Bluemix Cloud Foundry

## Introduction

This project builds and deploys a sample solution built on Netflix OSS and Spring Boot to IBM Bluemix Cloud Foundry. 
The sample Spring Boot app performs basic CRUD opertaion against MySQL database. It registers itself to Eureka server which runs as a Cloud Foundry application as well. The consumer app can access the app through Zuul proxy which in turn looks up the service infomation from Eureka.

The project provides:

  - Build artifacts for Eureka, Zuul and Hello Spring Boot sample app
  - Build and deploy script
  - Application configuration file

This project depends on other 3 repositories for Eureka, Zuul and Hello-Service build:

 - https://github.com/ibm-solution-engineering/netflixbluemix-core - Contains Eureka, Zuul, and Nginx applications
 - https://github.com/ibm-solution-engineering/netflixbluemix-mysql - Contains MySQL-based microservice

## Setup the local development environment

### Prerequisites

- Install Java JDK 1.8 and ensure it is available in your PATH

### Download source code

- Clone this repository.
     **`git clone https://github.com/ibm-solution-engineering/netflixbluemix-cf.git`**

- Clone the netflix core repository (if you haven't setup the Container based environment)
     **`git clone https://github.com/ibm-solution-engineering/netflixbluemix-core.git`**
  
- Clone the netflix MySQL App repository 
     **`git clone https://github.com/ibm-solution-engineering/netflixbluemix-mysql.git`**

## Build and Deploy the solution to Bluemix

 - Deploy all components
   Login your Bluemix space:
   **`cf login`**

   Build and deploy all component:
   **`$ ./deployApp.sh all`**
   
 - Deploy individual components
   Login your Bluemix space:
   **`cf login`**

   **`$ ./deployApp.sh eureka`**
   or
   **`$ ./deployApp.sh helloapp`**
   or
    **`$ ./deployApp.sh zuul`**
    
    
## Validate deployment
Use the following links to validate a successful solution deployment to Bluemix Cloud Foundry.

- Access Eureka Server Console:  
    [http://eureka-server-spring.mybluemix.net/](http://eureka-server-spring.mybluemix.net/) 

- Access the Spring Boot app directly:  
    [http://hello-springboot-app.mybluemix.net/app/index.html](http://hello-springboot-app.mybluemix.net/app/index.html)  

- Access the Spring Boot app through Zuul Proxy:  
    [http://zuul-spring-boot.mybluemix.net/hello-service/app/index.html](http://zuul-spring-boot.mybluemix.net/hello-service/app/index.html)    
    You should be able to perform CRUD operation using the App.

