class User < ApplicationRecord
  include Clearance::User

  def name
    email
  end
end
