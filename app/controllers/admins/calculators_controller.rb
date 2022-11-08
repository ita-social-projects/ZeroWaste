# frozen_string_literal: true

module Admins
  class CalculatorsController < BaseController
    before_action :calculator, only: %i[edit update destroy]
    load_and_authorize_resource

    def show
      # TODO: fill it
    end

    def edit
      collect_fields_for_form
    end

    def create
      @calculator = Calculator.new(calculator_params)
      if @calculator.save
        redirect_to admins_calculators_path,
                    notice: t('notifications.calculator_created')
      else
        render action: 'new'
      end
    end

    def update
      if updater
        redirect_to edit_admins_calculator_path(@calculator),
                    notice: t('notifications.calculator_updated')
      else
        collect_fields_for_form
        render action: 'edit'
      end
    end

    def destroy
      @calculator.destroy!
      redirect_to admins_calculators_path,
                  notice: t('notifications.calculator_deleted')
    end

    private

    def calculator
      @calculator = Calculator.friendly.find(params[:slug])
    end

    def collect_fields_for_form
      @form_fields = collect_fields_for_kind('form')
      @parameter_fields = collect_fields_for_kind('parameter')
      @result_fields = collect_fields_for_kind('result')
    end

    def collect_fields_for_kind(kind)
      @calculator
        .fields
        .select { |field| field.kind == kind }
        .sort_by { |field| field.created_at || Time.zone.now }
    end

    def calculator_params
      params.require(:calculator).permit(
        :name, :locale, :slug, :preferable,
        fields_attributes: %i[
          locale selector label name value unit from to type kind _destroy
        ]
      )
    end

    def updater
      Calculator.transaction do
        ::Calculators::PreferableService.new(calculator_params).perform!
        @calculator.update(calculator_params)
      end
    end
  end
end
