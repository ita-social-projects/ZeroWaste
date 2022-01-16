class Calculators::PreferableService

  def initialize(params)
    @preferable = params.fetch(:preferable, nil)
    @slug = params.fetch(:slug, nil)
  end

  def perform!
    if @preferable.to_i == 1
        Calculator.where.not(slug: @slug).update_all(preferable: false)
      end
    end

end
