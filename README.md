# Bank Accounting

This projects is a demo of a simple bank accounting system, it features the following actions:

- Create an account with a initial deposit amount
- Transfer between accounts
- Consult account balance

To achieve this, the project implements a simple Double Entry Bookkeeping system, that can be expanded upon.
The design decisions, trade-offs and how to extend the system can be found on the CONTRIBUTING.md file.

## Getting Started

These instructions will walk you though on how to run this project locally, for development and testing purposes.
There's no production deployment instructions, as this project is not for production use, but to give a solid base and understanding of the Double Entry Bookkeeping system.

### Prerequisites

To run this project, you can install Elixir, Phoenix and PostgreSQL locally, or use Docker.

### Running without Docker

Elixir has a great [installation guide](https://elixir-lang.org/install.html) that should cover your needs.
After installing Elixir, follow the [Phoenix installation guide](https://hexdocs.pm/phoenix/installation.html#contenta).
And finally, install PostgreSQL 12 following this [installation guide](https://wiki.postgresql.org/wiki/Detailed_installation_guides).

Finally, you can run the project. First, change the database hostname, user and password at `config/dev.exs` to what you configured during the postgres installation.

After that, create the database with the command below.

```sh
mix ecto.create
```

Run the migrations with

```sh
mix ecto.migrate
```

With the database created, create the seed data with

```sh
mix run priv/repo/seeds.exs
```

This should leave you with a properly cofigured development environment.


### Running with Docker

Install Docker via the [official installation guide](https://docs.docker.com/install/)
Install Docker Compose also via the [official installation guide](https://docs.docker.com/compose/install/)

After that, it should be as simple as running the following command

```sh
docker-compose up
```

You will still retaing live reload functionalities using docker because it's mounting your project directory into the container.

> The project image also installs postgresql client, so if you need you can attach to the container and use psql there.
