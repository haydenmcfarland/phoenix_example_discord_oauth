# ExampleOauth

- utilizes Discord for OAuth
- allows the creation of Topics/Comments when logged in

## Usage

1. configure `dev.secrets.exs`

```elixir
import Config

config :ueberauth, Ueberauth.Strategy.Discord.OAuth,
  client_id: "*",
  client_secret: "*"

```
2. build and start containers

```
docker-compose up --build
```

![](https://github.com/haydenmcfarland/assets/blob/master/images/examples/example_oauth.gif?raw=true)
