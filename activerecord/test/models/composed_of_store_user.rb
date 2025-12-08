# frozen_string_literal: true

ActiveRecord::Schema.define do
  create_table :composed_of_store_users, force: true do |t|
    t.text :settings
    t.text :preferences
  end
end

class ComposedOfStoreUser < ActiveRecord::Base
  self.table_name = :composed_of_store_users
  store :settings, accessors: [:currency, :amount], coder: JSON
  store :preferences, accessors: [:theme], coder: JSON

  class Money
    attr_reader :currency, :amount
    def initialize(currency, amount)
      @currency, @amount = currency, amount
    end
    def ==(other)
      other.is_a?(Money) && self.currency == other.currency && self.amount == other.amount
    end
  end

  composed_of :money, class_name: "ComposedOfStoreUser::Money", mapping: [%w[currency currency], %w[amount amount]]
end
