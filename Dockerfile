FROM maven:alpine

RUN apk update && apk add git
RUN git clone https://github.com/swagger-api/swagger-codegen.git
WORKDIR /swagger-codegen
RUN git checkout v2.2.3
RUN mvn clean package && mvn install
WORKDIR /
RUN git clone https://github.com/jeremeevans/typescript-aurelia-fetch-client-generator.git
WORKDIR typescript-aurelia-fetch-client-generator
RUN sed s/2.2.3.SNAPSHOT/2.2.3/ -i pom.xml
RUN mvn package

VOLUME "/output"
WORKDIR /

CMD java \ 
    -cp "/typescript-aurelia-fetch-client-generator/target/typescript-aurelia-fetch-client-swagger-codegen-1.0.0.jar:/swagger-codegen/modules/swagger-codegen-cli/target/swagger-codegen-cli.jar" \
    io.swagger.codegen.Codegen \
    -i $URL \
    -l typescript-aurelia-fetch-client \
    -o /output 
