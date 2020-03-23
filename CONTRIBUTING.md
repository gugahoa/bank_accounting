# Contributing

When contributing to this project, first read the [Design Decisions](#design-decisions) that were made to get here, and what's the vision on how to extend and when. Before making a pull request, it's recommended to open an issue to discuss the changes.

## Table of Contents

<!--ts-->
  * [Contributing](#contributing)
  * [Table of Contents](#table-of-contents)
  * [Pull Request Process](#pull-request-process)
  * [Design Decisions](#design-decisions)
    * [Why Double Entry Bookkeeping](#why-double-entry-bookkeeping)
    * [Database Model](#database-model)
<!--te--> 
## Pull Request Process

1. Ensure that any new dependency is added to mix.exs, and the compilation works from a clean pull from the branch
2. Update the README.md if necessary, and the [Design Decisions](#design-decisions) section
3. Ensure that the [Database Model](#database-model) is up to date
4. Ensure you have tests covering the core parts of the pull request
5. Open the PR and ask for a review from any maintainer. The sign-off from one maintainer is already enough to merge the PR.

## Design Decisions

Here you'll find all design decisions that were made to arrive at the current architecture, for technical design decisions, you'll find them as in-code documentation.

### Why Double Entry Bookkeeping?

Although this project aims to be a simple bank accounting system, developing a homegrown system that only works for the proposed features are prone to errors and maintainability issues, as we would reinvent the wheel in most cases.
That's why we're adopting the Double Entry Bookkeeping approach, that's tried and true in the accounting industry.

Double Entry Bookkeeping can be used as a financial tracking system, but not all financial tracking systems can be used as a Double Entry Bookkeeping system.
So to improve maintainability, we're adopting it, and simplifying what we'll implement from it, but still paving the road to a full-blown Double Entry Bookkeeping system if necessary.

### Database Model

![double entry bookkeeping model](./bank_accounting_model.png)
