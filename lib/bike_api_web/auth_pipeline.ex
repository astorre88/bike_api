defmodule BikeApi.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline, otp_app: :bike_api,
                              module: BikeApi.Guardian,
                              error_handler: BikeApi.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
