# cash-register-app
This is a simulation app of a cash register that is able to compute the total price of the shopping cart,
given a serie of items added to the shopping cart and some discount rules applicable to the different
products.

## Architecture
I choose to use an hexagonal architecture to improve separation of the business logic (the hexagon) from
outside dependencies. This also goes towards the defined objective of being adaptable and extensible.

The requirements define the following entities, that are part of the hexagon:
- Product: represents a product to be add to the cart and is defined by a code, a name and a price.
- Cart: is the cart where the products are being added and should provide an interface to calculate the total price.
- CartItem: represents an item in the Cart, containing a certain quantity of a specific product. It has
a method to calculate the total item price.
- Checkout: represents the checkout of the shopping cart and can apply discount rules.
- PriceRule: represents a rule that can be applied to the price of a particular product based on some conditions.

To interact with the application, since the requirements are not explicitly asking for UI or API
interfaces, I would define a simple inbound adapter consisting of a CLI interface, in order to save some time avoiding to set-up a web UI.

### Price rules
The requirements are defining these three rules:
- buy-one-get-one-free: buy one product (green tea in the requirements) and get one for free.
- buy-three-drop-price-to-x: buy three or more products (strawberries in the requirements) and have a special price.
- buy-three-drop-price-to-percent-of-original-price: buy three or more products (coffees in the requirements) and have a special price expressed in percentual of the original price.

All these rules can be expressed with two basic rules:

- buy-x-drop-price-to-y: allow to drop the price to a specific value (absolute value or percent of original value) as you buy X or more than X products.
- buy-x-get-y-free: allow to have Y free as you buy X.

## Language
The language I choose is Ruby because it allows rapid development and takes quickly into an MVP.

## Build and run with Docker

```
docker build -t cash-register-app .
docker run --rm -it cash-register-app
```

## Usage with CLI

Once running, the CLI will show the available products and is waiting for input.
The user can introduce the code of the product that he wants to add to the shopping cart.
Once he pressed enter, the new shopping cart total will be shown.
Is it possible to exit from the app by typing "EXIT".

## Run specs

```
docker run --rm cash-register-app rspec
```

## Further developments

### App

- add an outbound port and adapter to load rules (and not having them hard coded)
- decouple the Checkout from CLI

### Specs

- use fixtures instead of instantiating products on specs
- add more specs

### CI/CD

- add pipelines to check code (running rubocop and specs)
