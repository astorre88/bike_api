# BikeApi

  ## Setup

  ```sh
  mix deps.get
  ```

  ```sh
  cp config/dev.exs config/dev.secret.exs
  ```

  Generate secret key:
  ```sh
  mix guardian.gen.secret
  ```
  and copy it.

  Paste following text to dev.secret.exs:
  ```sh
  use Mix.Config

  config :bike_api, BikeApi.Guardian,
    issuer: "bike_api",
    secret_key: "paste secret key here"
  ```

  Create DB and run migrations:
  ```sh
  mix ecto.create && mix ecto.migrate
  ```

  ## Run the project

  ```sh
  mix phx.server
  ```

  ## Run tests

  ```sh
  mix test
  ```

  ## Test examples

  * curl -X POST http://localhost:4000/api/v1/sign_up -H "Content-Type: application/json" -d '{"user": {"email": "test_user@gmail.com", "password": "password", "password_confirmation": "password"}}'
    ```sh
    {
      "data": {
        "id": 1,
        "email": "test_user@gmail.com"
      }
    }
    ```
  * curl -X POST -i http://localhost:4000/api/v1/sign_in -H "Content-Type: application/json" -d '{"email": "test_user@gmail.com", "password": "password"}'
    ```sh
    {
      "jwt": token
    }
    ```
  * curl -X GET http://localhost:4000/api/v1/profile -H "Content-Type: application/json" -H "Authorization: Bearer token"
    ```sh
    {
      "data": {
        "id": 1,
        "email": "test_user@gmail.com"
      }
    }
    ```
  * curl -X POST http://localhost:4000/api/v1/events -H "Content-Type: application/json" -H "Authorization: Bearer token" -d '{"event": {"name": "football", "lat": 52.512649, "lon": -0.133057, "radius": 2}}'
    ```sh
    {
      "data": {
        "radius": 2,
        "name": "football",
        "lon": -0.133057,
        "lat": 52.512649,
        "id": 1
      }
    }
    ```
  * curl -X POST http://localhost:4000/api/v1/promo_codes -H "Content-Type: application/json" -H "Authorization: Bearer token" -d '{"promo_code": {"amount": 1000, "expirates_at": "2018-10-14T08:20:32.22", "active": false, "event_id": 1}}'
    ```sh
    {
      "data": {
        "id": 1,
        "expirates_at": "2018-10-14T08:20:32.22Z",
        "event_id": 1,
        "amount": 1000,
        "active": false
      }
    }
    ```
  * curl -X GET http://localhost:4000/api/v1/promo_codes\?active\=false -H "Content-Type: application/json" -H "Authorization: Bearer token"
    ```sh
    {
      "data": [
        {
          "id": 1,
          "expirates_at": "2018-10-14T08:20:32.22Z",
          "event_id": 1,
          "amount": 1000,
          "active": false
        }
      ]
    }
    ```
  * curl -X POST http://localhost:4000/api/v1/promo_codes/14/check -H "Content-Type: application/json" -H "Authorization: Bearer token" -d '{"trip": {"origin": {"lat": 51.512649, "lon": -0.133057}, "destination": {"lat": 53.512649, "lon": 1.133057}}}'
    ```sh
    {
      "data": {
        "id": 1,
        "expirates_at": "2018-10-14T08:20:32.22Z",
        "event_id": 1,
        "amount": 1000,
        "active": false
      }
    }
    ```
