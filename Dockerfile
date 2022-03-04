FROM openjdk:8
COPY . .

RUN apt update
RUN apt install -y expect

ENTRYPOINT ["/bin/sh","run_edit.sh"]
