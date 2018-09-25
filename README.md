# BikeApi

  * events model(name:string place:place radius:integer)
  * promo_codes model(price:integer active:false:boolean event_id:integer)
  * trip model(pickup:place destination:place)
  * POST `/api/v1/promo_codes`
    ```sh
    {
      "promo_code": {
        "amount": 5,
        "expirates_at": "2018-09-26",
        "radius": 10
      },
      "event": {
        "id": 1
      }
    }
    ```
  * GET `/api/v1/promo_codes?active=true` (default: all)
  * PATCH `/api/v1/events`
    ```sh
    {
      "event": {
        "radius": 5
      }
    }
    ```
  * POST `/api/v1/promo_codes/1/check`
    ```sh
    {
      "trip": {
        "origin": "Address1",
        "destination": "Address2"
      }
    }
    ```
    - returns promo_code with polyline or error
