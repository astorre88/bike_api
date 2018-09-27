defmodule BikeApi.UserFactory do
  @moduledoc false

  alias BikeApi.Accounts.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %User{
          email: sequence(:email, &"email-#{&1}@example.com"),
          password: "password",
          password_confirmation: "password"
        }
      end
    end
  end
end
