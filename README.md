# Bank Accounting

This project is a demo of a simple bank accounting system, it features the following actions:

- Create an account with an initial deposit amount
- Transfer between accounts
- Consult account balance

To achieve this, the project implements a simple Double Entry Bookkeeping ([read more about it in the project wiki](https://github.com/gugahoa/bank_accounting/wiki/Double-Entry-Bookkeeping)) system, that can be expanded upon.
The design decisions, trade-offs and how to extend the system can be found on the [CONTRIBUTING.md](./CONTRIBUTING.md) file.

## Table of Contents

<!--ts-->
  * [Bank Accounting](#bank-accounting)
  * [Table of Contents](#table-of-contents)
  * [Getting Started](#getting-started)
    * [Prerequisites](#prerequisites)
    * [Running without Docker](#running-without-docker)
    * [Running with Docker](#running-with-docker)
  * [Running Tests](#running-tests)
    * [Running tests without Docker](#running-tests-without-docker)
    * [Running tests with Docker](#running-tests-with-docker)
    * [Testing manually](#testing-manually)
  * [Endpoints](#endpoints)
  * [Contributing](#contributing)
  * [Design Decisions](#design-decisions)
<!--te-->

## Getting Started

These instructions will walk you through on how to run this project locally, for development and testing purposes.
There are no production deployment instructions, as this project isn't being used in production.

### Prerequisites

To run this project, you can use Docker or install Elixir, Phoenix and PostgreSQL locally.

### Running with Docker

Install Docker via the [official installation guide](https://docs.docker.com/install/)
Install Docker Compose also via the [official installation guide](https://docs.docker.com/compose/install/)

After that, it should be as simple as running the following command

```sh
docker-compose up
```

You will still retain live reload functionalities using docker because it's mounting your project directory into the container.

> The project image also installs PostgreSQL client, so if you need you can attach to the container and use psql there.

### Running without Docker

Elixir has a great [installation guide](https://elixir-lang.org/install.html) that should cover your needs.
After installing Elixir, follow the [Phoenix installation guide](https://hexdocs.pm/phoenix/installation.html#contenta).
And finally, install PostgreSQL 12 following this [installation guide](https://wiki.postgresql.org/wiki/Detailed_installation_guides).

Finally, you can run the project. First, change the database hostname, user and password at `config/dev.exs` to what you configured during the PostgreSQL installation.

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

This should leave you with a properly configured development environment. After that, run the following command

```sh
iex -S mix phx.server
```

## Running Tests

### Running tests with Docker

Run the following command to run the database:
```sh
docker-compose up db
```

Then run the following command to run the test suite:
```sh
docker-compose run web mix test
```

### Running tests without Docker

First change the db hostname at `config/test.exs`, as it assumes the Docker environment is being used.

To run the test suite, run the following command:
```sh
mix test
```

### Testing manually

If you're testing manually without Docker, be sure to run the `seed.exs` script found at `priv/repo/seeds.exs` with the following command:

```sh
mix run priv/repo/seeds.exs
```

## Endpoints

The project has 4 endpoints:
```
  auth_path  POST  /api/login                BankAccountingWeb.AuthController :login
  auth_path  POST  /api/signup               BankAccountingWeb.AuthController :signup
ledger_path  POST  /api/transfer/:from/:to   BankAccountingWeb.LedgerController :transfer
ledger_path  GET   /api/balance/:account_id  BankAccountingWeb.LedgerController :balance
```

The POST endpoints expect a JSON object as body.

`/api/login` expects:
```
{
  "email": "email_address",
  "password": "password"
}
```

`/api/signup` expects:
```
{
  "email": "email_address",
  "password": "password",
  "initial_deposit": 42
}
```

`/api/transfer/:from/:to` expects:
```
{
  "amount": 42
}
```

## Contributing

Please read [CONTRIBUTING.md](./CONTRIBUTING.md)

## Design Decisions

Please read [Design Decisions](./CONTRIBUTING.md#design-decisions) section found at [CONTRIBUTING.md](./CONTRIBUTING.md)
