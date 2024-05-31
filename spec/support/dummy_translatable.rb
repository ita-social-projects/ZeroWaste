class DummyTranslatable
  include Translatable

  attr_accessor :uk_name

  translates :name

  def initialize(en_name: "Diapers", uk_name: "Підгузки")
    @en_name = en_name
    @uk_name = uk_name

    define_en_name if @en_name
  end

  private

  # Define en_name only if en_name is present for testing case with uk defaul locale
  # when en_name not exist at all
  def define_en_name
    define_singleton_method(:en_name) { @en_name }
  end
end
