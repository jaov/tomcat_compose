# Why?
I made this to make development bearable in our legacy application

## Features
- Hotswap with TravaJDK 8 and DCEVM under debian slim because alpine was giving me trouble.
- Docker compose so you can add things like nginx and redis

## Use
Create a project with your template and `cd` into it.

```bash
cp .env.example .env \
&& mvn clean compile war:exploded \
&& docker-compose up
```

If you add new dependencies use `mvn compile war:exploded`. The way volumes are mounted if you `clean` you will lose the lib folder. If that happens just `docker-compose down && mvn compile war:exploded && docker-compose up`

## Postgres
I have postgres as the DB because that's what we use. You can put binary pg_dump backup files or sql dump files in the `postgres-init` folder, postgres will load them up using `restore.sh`. Remember to mark the name in `.env`.
