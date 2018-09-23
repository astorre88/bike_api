defmodule BikeApi.Factory do
  use ExMachina.Ecto, repo: BikeApi.Repo

  alias BikeApi.Accounts.User

  def user_factory do
    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: "password",
      password_confirmation: "password"
    }
  end
end
