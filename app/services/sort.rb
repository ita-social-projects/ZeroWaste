class Sort
  attr_accessor :collection, :params

  def initialize(collection, params)
    @collection = collection
    @params     = params
  end

  def sort
    collection.order(sorting_params)
  end

  private

  def sorting_params
    params.nil? ? "id asc" : (params[:sort].presence || "id asc")
  end
end
