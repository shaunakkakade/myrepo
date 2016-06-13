#!/bin/bash

##############################################################################
##
##  Build and Deploy Netflix OSS Spring Boot apps to IBM Bluemix Cloud Foundry
##  Author: gangchen@us.ibm.com
##
##############################################################################

BASEDIR=$(pwd)

  function help() {
      echo ""
      echo "Script to build and deploy Netflix Spring Boot app to Bluemix Cloud Foundry"
      echo ""
      echo "    deployApp.sh command"
      echo "    command   -    all | eureka | helloapp | zuul "
      echo "                   deployApp.sh all  - deploy all components to Bluemix"
      echo "                   You can choose to deploy a single component by passing the component name"
  }


  function deployEureka(){

    echo
    echo "Build and Deploy the Eureka server"
    cd ../netflixbluemix-core/eurekaserver
    ./gradlew build
    cp build/libs/eureka-spring-boot-0.1.0.jar ${BASEDIR}/eureka_server/

    echo "Deploy the Eureka server to Bluemix"
    cd ${BASEDIR}/eureka_server
    cf push
    cd ${BASEDIR}
    echo "Eureka Server has been successfully deployed to IBM Bluemix"
    echo "You can open Eureka console at: http://eureka-server-spring.mybluemix.net/"

  }

  function deployHelloApp() {

    echo "Update the Spring Boot configuratino file"
    cp ../netflixbluemix-mysql/microservice/src/main/resources/application.yml ../netflixbluemix-mysql/microservice/src/main/resources/application.yml.bak
    cp  hello_springboot_app/application.yml ../netflixbluemix-mysql/microservice/src/main/resources/application.yml

    echo "Build and Deploy the Sample Hello Service"
    cd ../netflixbluemix-mysql/microservice
    ./gradlew build
    cp build/libs/gs-spring-boot-0.1.0.jar ${BASEDIR}/hello_springboot_app/

    echo "Deploy the Sample Hello SpringBoot app to Bluemix"
    cd ${BASEDIR}/hello_springboot_app
    cf push
    cd ${BASEDIR}
    echo "Sample SpringBoot app has been successfully deployed to IBM Bluemix"
    echo "You can test the app at: http://hello-springboot-app.mybluemix.net/app/index.html"

    cd ${BASEDIR}
    cp ../netflixbluemix-mysql/microservice/src/main/resources/application.yml.bak ../netflixbluemix-mysql/microservice/src/main/resources/application.yml
  }

  function deployZuulProxy() {

    echo "Update the Spring Boot configuratino file"
    cp ../netflixbluemix-core/zuulproxy/src/main/resources/application.yml ../netflixbluemix-core/zuulproxy/src/main/resources/application.yml.bak
    cp  zuul_proxy/application.yml ../netflixbluemix-core/zuulproxy/src/main/resources/application.yml

    echo "Build and Deploy the Zuul Proxy"
    cd ../netflixbluemix-core/zuulproxy
    ./gradlew build
    cp build/libs/zuul-spring-boot-0.1.0.jar ${BASEDIR}/zuul_proxy/

    cd ${BASEDIR}/zuul_proxy
    cf push
    cd ${BASEDIR}
    echo "Zuul Proxy has been successfully deployed to IBM Bluemix"
    echo "Now you can access the sample app through Zuul proxy: http://zuul-spring-boot.mybluemix.net/hello-service/app/index.html"

    cd ${BASEDIR}
    cp ../netflixbluemix-core/zuulproxy/src/main/resources/application.yml.bak ../netflixbluemix-core/zuulproxy/src/main/resources/application.yml

  }

if [ $# -eq 1 ];
then
  COMMAND=${1}

  case "${COMMAND}" in
    eureka)
      deployEureka
      ;;
    helloapp)
      deployHelloApp
      ;;
    zuul)
      deployZuulProxy
      ;;
    *)
         echo "Unknown command: ${1}"
         help
         exit 1
         ;;
  esac
else
    # show help
    help
    exit 1
fi
