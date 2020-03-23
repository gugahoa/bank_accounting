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
  * [Trade-offs](#trade-offs)
    * [Nominal Account vs Personal Account](#nominal-account-vs-personal-account)
    * [No balance column](#no-balance-column)
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

To properly understand the trade-offs being made here, and the path to the future, please read the wiki entry on [Double Entry Bookkeeping](https://github.com/gugahoa/bank_accounting/wiki/Double-Entry-Bookkeeping). If you already know about Double Entry Bookkeeping, keep in mind that we adopt the Traditional Approach to reason about debit and credit.

This model is enough to properly represent transactions between accounts, deposits to an account and consulting account balance.
As the system requirements evolve, you may need to extend this. We'll discuss in [Road to the Future](#road-to-the-future) what requirements would elicit what changes.

## Trade-offs

### Nominal Account vs Personal Account

Having an Accounts table instead of two separate tables, with a type column, would simplify the transactions between Personal Accounts, however, it would likely lead to a rewrite down the road. There are two main reasons why they were separated:

The first reason for separating them is to use the same vocabulary from the domain, inside the software. This will make software engineers and the rest of the company share the same vocabulary.

The second reason is that in the future, Personal Account and Nominal Account could be quite different. With Nominal Account having more internal information, and Personal Account having more information about fees and customer information.
We talk about personal account fees, other kinds of personal account and revenue in the [Road to the Future](#road-to-the-future) section.

### No balance column

A balance column can lead to inconsistencies, as it's a fact that is derived fro the transactions table. Adding it would mean that we have to program a routine to keep it in sync with the source of truth (Transactions table).
A better approach, discussed in [Road to the Future](#road-to-the-future) is to create a Personal Account Closed Balance table (same applies for Nominal Accounts) and only update it on every defined time window that makes sense.
Then the number of rows needed to calculate the balance would be 1 + all transactions from that account on the open period.
