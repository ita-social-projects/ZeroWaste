module GlobalHelpers
  def compare_fields(first_object, second_object, fields)
    fields.each do |attr|

      expect(first_object[attr]).to eq second_object[attr]
    end
  end
end
