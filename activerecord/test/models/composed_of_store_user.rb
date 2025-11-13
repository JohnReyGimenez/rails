# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table :composed_of_store_users do |t|
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

    def to_s
      "#{currency} #{amount}"
    end

    def ==(other)
      other.is_a?(Money) &&
        self.currency == other.currency &&
        self.amount == other.amount
    end
  end

  store :settings, accessors: [:currency, :amount], coder: JSON

  composed_of :money,
              class_name: "ComposedOfStoreUser::Money",
              mapping: [%w[currency currency], %w[amount amount]]
end
