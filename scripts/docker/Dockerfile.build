FROM cryogen:8-jdk_1.8_2.8.1

RUN rm -rf /tmp/app
ADD app /tmp/app

RUN lein ring war

#CMD ["java", "-jar", "target/app.jar"]
