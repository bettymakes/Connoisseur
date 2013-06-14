
- Index - display many products (20 items)

- Error handling on status 404?

---

- Show - display a specific product page
    - search by product name? (typically its by ID #)
    - extend this: show this product inventory availability at various stores

---

- Economy - display 10 drinks that are cheap to drink
    - `result.each { |item| item["price_per_liter_of_alcohol_in_cents"] }`
    - "price_per_liter_of_alcohol_in_cents"

---

- Airmiles - display products that offer bonus reward miles
    - "has_bonus_reward_miles"

---

- Promotions - display products that offer value-added promos
    - "has_valued_added_promotions"
        - "value_added_promotion_description"
    - "has_limited_time_offer"

---

- Category - display products by category
    - "Lager/Pilsner"
