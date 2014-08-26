module Identifiable
  extend ActiveSupport::Concern

  module ClassMethods
    def identitire_field field
      define_method("create_identifier_#{field}") do |replace: false|
      if self[field].nil? || replace
        begin
          self[field] = generate_uuid
        end while self.class.exists?(field => self[field])
      end
      self[field]
      end

      before_validation(on: :create) { self.send "create_identifier_#{field}"}

      validates "#{field}", uniqueness: true, presence: true
    end
  end

  def generate_uuid
    SecureRandom.uuid
  end

end
