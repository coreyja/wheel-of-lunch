class User < ApplicationRecord
  include Clearance::User

  alias_attribute :name, :email
end
