
# Milbase skeleton

Project skeleton built with Elixir, Phoenix framework and Absinthe Graphql

## Getting Started

Graphql is awesome, elixir is awesome too. How to combine these two things? This skeleton created as a template for you who wants to create a server app with elixir and graphql. As a template placeholder, this  
skeleton contains a classic user-post-comment schema which a user has many posts and a post has many comments.

### Prerequisites

What things you need to install?

 1. Elixir 1.9.2 and phoenix framework v1.4.11  ([installation](https://hexdocs.pm/phoenix/up_and_running.html))
 2. Postgres v10.11 ([installation](https://www.postgresql.org/))

Make sure you edit the config file at `./config/dev.exs` with your postgres credential

### Installing

A step by step to run the server.
```
> git clone https://github.com/suryakun/milbase-skeleton.git
> cd milbase-skeleton
~ > mix deps.get
~ > mix ecto.setup
~ > mix phx.server
```

Open `http://localhost:4000/api/graphiql` in your browser, then you are ready to play with the schema

![enter image description here](https://media.giphy.com/media/TfpvVDKMM6NdW4uT3x/giphy.gif)


## Running the tests

Still no test in this project. Any contribution will appreciated :)


## Deployment

See [this instruction](https://hexdocs.pm/phoenix/deployment.html) for deployment

## Built With

* [Elixir](https://elixir-lang.org/) - The programming language
* [Phoenix framework](http://www.phoenixframework.org/) - The web framework
* [Absinthe](https://hexdocs.pm/absinthe/overview.html) - Graphql plugin
* [Absinthe relay](https://hexdocs.pm/absinthe_relay/Absinthe.Relay.html) - Graphql pagination plugin
* [Guardian](https://github.com/ueberauth/guardian) - Authentication library
* [Comeonin](https://github.com/riverrun/comeonin) - Hashing library

## Contributing

There are many ways you can contribute to the development of Milbase skeleton, including:
-   reporting issues
-   improving documentation
-   sharing your experiences with others
- Pull, create new branch, push and create PR :)

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Surya surakhman** - *Initial work*

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Happy coding
* Happy coding
* Happy coding
