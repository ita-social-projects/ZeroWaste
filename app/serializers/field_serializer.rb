# frozen_string_literal: true

class FieldSerializer < ActiveModel::Serializer
  attributes :name, :result

  def name
    object.name.parameterize.underscore
  end
end
