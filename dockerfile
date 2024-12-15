from postgres:14

ADD ./current_dump.sql /docker-entrypoint-initdb.d/current_dump.sql

COPY . .

ARG POSTGRES_USER
ARG POSTGRES_PASSWORD

ENV POSTGRES_DB='research_control_system_database'
ENV POSTGRES_USER=${POSTGRES_USER}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}

EXPOSE 5432