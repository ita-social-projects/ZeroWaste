# frozen_string_literal: true

class FieldSerializer < ActiveModel::Serializer
  attributes :name, :result

  def name
    if object.name.present?
      object.name.parameterize.underscore
    else
      object.name
    end
  end

  def result
    object.result
  end
end
