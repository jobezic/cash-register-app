# frozen_string_literal: true

module Adapters
  # A command line interface for interacting with the checkout system.
  #
  # This class serves as a UI adapter in a hexagonal architecture. It allows users
  # to type product codes interactively. Each product added updates the cart and
  # displays the running total based on fixed pricing rules.
  #
  # Usage:
  #   cli = Adapters::CLI.new(checkout: checkout, catalog: catalog)
  #   cli.start
  #
  # Dependencies:
  # - `checkout`: an instance of Checkout that knows how to apply pricing rules
  # - `catalog`: a Hash of product code => Product
  #
  # This adapter does not modify pricing rules or product definitions at runtime.
  class CLI
    def initialize(checkout:, catalog:)
      @checkout = checkout
      @cart = Cart.new
      @catalog = catalog
    end

    def start
      puts 'Welcome to the CLI Checkout!'
      puts 'Available products:'

      show_products

      puts "\nType product codes to add them to the cart. Type 'exit' to quit.\n\n"

      main_loop

      puts "\nFinal total: €#{format('%.2f', @checkout.total(@cart))}"
      puts 'Goodbye!'
    end

    private

    def show_products
      @catalog.each_value do |product|
        puts "- #{product.name} (#{product.code}): €#{product.price}"
      end
    end

    def main_loop # rubocop:disable Metrics/MethodLength
      loop do
        print '> '
        input = gets.strip.upcase
        break if input == 'EXIT'

        product = @catalog[input]
        if product
          @cart.add(product, 1)
          total = @checkout.total(@cart)
          puts "Added #{product.name}. Current total: €#{format('%.2f', total)}"
        else
          puts "Unknown product code: #{input}"
        end
      end
    end
  end
end
