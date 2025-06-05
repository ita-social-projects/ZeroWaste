# frozen_string_literal: true

class Account::CalculatorsController < Account::BaseController
  load_and_authorize_resource
  before_action :check_constructor_flipper

  def index
    @q           = collection.ransack(params[:q])
    @calculators = @q.result.page(params[:page])
  end

  def show
    @calculator = resource
    @calculator = resource
  end

  def new
    @calculator = Calculator.new

    @calculator.fields.build
    @calculator.formulas.build
  end

  def edit
    @calculator = resource
  end

  def create
    @calculator = Calculator.new(calculator_params)

    if @calculator.save
      redirect_to account_calculator_path(slug: @calculator), notice: t("notifications.calculator_created")
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @calculator = resource

    if updater
      redirect_to edit_account_calculator_path(slug: @calculator), notice: t("notifications.calculator_updated")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def duplicate
    @calculator   = resource
    @copy         = @calculator.dup
    @copy.en_name = "#{@calculator.en_name} (copy)"
    @copy.uk_name = "#{@calculator.uk_name} (копія)"

    attach_logo(@copy, @calculator) if @calculator.logo_picture.attached?

    if @copy.save
      duplicate_association(:fields)
      duplicate_association(:formulas)
      redirect_to account_calculator_path(slug: @copy), notice: t("notifications.calculator_duplicated")
    else
      redirect_to account_calculators_path, alert: t("notifications.calculator_not_duplicated")
    end
  end

  def destroy
    @calculator = resource

    @calculator.destroy

    redirect_to account_calculators_path, notice: t("notifications.calculator_deleted"), status: :see_other
  end

  private

  def collection
    Calculator.ordered_by_name
  end

  def resource
    collection.friendly.find(params[:slug])
  end

  def calculator_params
    params.require(:calculator).permit(
      :id, :en_name, :uk_name, :color, :logo_picture, :uk_notes, :en_notes,
      formulas_attributes: [:id, :expression, :en_label, :uk_label, :calculator_id, :en_unit, :uk_unit, :priority, :formula_image, :relation, :_destroy],
      fields_attributes: [:id, :en_label, :uk_label, :var_name, :kind, :_destroy,
        categories_attributes: [:id, :en_name, :uk_name, :price, :_destroy]]
    )
  end

  def updater
    Calculator.transaction do
      @calculator.update(calculator_params)
    end
  end

  def check_constructor_flipper
    return if Flipper[:constructor_status].enabled?

    raise ActionController::RoutingError, "Constructor flipper is disabled"
  end

  def attach_logo(copy, original)
    copy.logo_picture.attach(
      io: StringIO.new(original.logo_picture.download),
      filename: original.logo_picture.filename.to_s,
      content_type: original.logo_picture.content_type
    )
  end

  def duplicate_association(association_name)
    @calculator.public_send(association_name).each do |record|
      new_record            = record.dup
      new_record.calculator = @copy
      new_record.save(validate: false)
    end
  end
end
