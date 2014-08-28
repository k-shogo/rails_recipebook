class Message
  include ActiveModel::Model

  attr_accessor :type, :icon, :header, :body
end
