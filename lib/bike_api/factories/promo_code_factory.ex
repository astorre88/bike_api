defmodule BikeApi.PromoCodeFactory do
  @moduledoc false

  alias BikeApi.Events.PromoCode

  defmacro __using__(_opts) do
    quote do
      def promo_code_factory do
        %PromoCode{
          active: false,
          amount: 100
        }
      end

      def with_event(%PromoCode{} = promo_code, event) do
        %{promo_code | event: event}
      end
    end
  end
end
