# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table :composed_of_store_users, force: true do |t|
    t.text :settings
  end
end

class ComposedOfStoreUser < ActiveRecord::Base
  self.table_name = :composed_of_store_users

  class Money
    attr_reader :currency, :amount

    def initialize(currency, amount)
      @currency = currency
      @amount   = amount
    end

    # Essential for assert_equal to work
    def ==(other)
      other.is_a?(Money) &&
        self.currency == other.currency &&
        self.amount == other.amount
    end

    def to_s
      "#{currency} #{amount}"
    end
  end

  store :settings, accessors: [:currency, :amount], coder: JSON

  composed_of :money,
              class_name: "ComposedOfStoreUser::Money",
              mapping: [%w[currency currency], %w[amount amount]]
end
