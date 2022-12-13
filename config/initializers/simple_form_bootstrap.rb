# frozen_string_literal: true

# Please do not make direct changes to this file!
# This generator is maintained by the community around simple_form-bootstrap:
# https://github.com/rafaelfranca/simple_form-bootstrap
# All future development, tests, and organization should happen there.
# Background history: https://github.com/heartcombo/simple_form/issues/1561

# Uncomment this and change the path if necessary to include your own
# components.
# See https://github.com/heartcombo/simple_form#custom-components
# to know more about custom components.
# Dir[Rails.root.join('lib/components/**/*.rb')].each { |f| require f }

IS_VALID = 'is-valid'
IS_INVALID = 'is-invalid'
FORM_CHECK_LABEL = 'form-check-label'
FORM_GROUP = 'form-group'
FORM_GROUP_VALID = 'form-group-valid'
FORM_GROUP_INVALID = 'form-group-valid'
FORM_CONTROL = 'form-control'
INVALID_FEEDBACK = 'invalid-feedback'
FORM_TEXT = 'form-text text-muted'
FORM_CHECK = 'form-check'
FORM_CHECK_INPUT = 'form-check-input'
COL_FORM_LABEL = 'col-form-label pt-0'
INVALID_FEEDBACK_BLOCK = 'invalid-feedback d-block'
FLEX = 'd-flex flex-row justify-content-between align-items-center'
FORM_GROUP_ROW = 'form-group row'
COL_FORM_LABEL_SM = 'col-sm-3 col-form-label'
COL_SM = 'col-sm-9'
CUSTOM_CONTROL_INPUT = 'custom-control-input'
CUSTOM_CONTROL_LABEL = 'custom-control-label'

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Default class for buttons
  config.button_class = 'btn'

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = FORM_CHECK_LABEL

  # How the label text should be generated altogether with the required text.
  config.label_text = lambda { |label, required, _explicit_label|
    "#{label} #{required}"
  }

  # Define the way to render check boxes / radio buttons with labels.
  config.boolean_style = :inline

  # You can wrap each item in a collection of radio/check boxes with a tag
  config.item_wrapper_tag = :div

  # Defines if the default input wrapper class should be included in radio
  # collection wrappers.
  config.include_default_input_wrapper_class = false

  # CSS class to add for error notification helper.
  config.error_notification_class = 'alert alert-danger'

  # Method used to tidy up errors. Specify any Rails Array method.
  # :first lists the first message for each field.
  # :to_sentence to list all errors for each field.
  config.error_method = :to_sentence

  # add validation classes to `input_field`
  config.input_field_error_class = IS_INVALID
  config.input_field_valid_class = IS_VALID

  # vertical forms
  #
  # vertical default_wrapper
  config.wrappers :vertical_form, tag: 'div', class: FORM_GROUP,
                                  error_class: FORM_GROUP_INVALID,
                                  valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label
    b.use :input, class: FORM_CONTROL, error_class: IS_INVALID,
                  valid_class: IS_VALID
    b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK }
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # vertical input for boolean
  config.wrappers :vertical_boolean, tag: 'fieldset', class: FORM_GROUP,
                                     error_class: FORM_GROUP_INVALID,
                                     valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper, tag: 'div', class: FORM_CHECK do |bb|
      bb.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID,
                     valid_class: IS_VALID
      bb.use :label, class: FORM_CHECK_LABEL
      bb.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK }
      bb.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
    end
  end

  # vertical input for radio buttons and check boxes
  config.wrappers :vertical_collection, item_wrapper_class: FORM_CHECK,
                                        item_label_class: FORM_CHECK_LABEL,
                                        tag: 'fieldset', class: FORM_GROUP,
                                        error_class: FORM_GROUP_INVALID,
                                        valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: COL_FORM_LABEL do |ba|
      ba.use :label_text
    end
    b.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID,
                  valid_class: IS_VALID
    b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # vertical input for inline radio buttons and check boxes
  config.wrappers :vertical_collection_inline,
                  item_wrapper_class: 'form-check form-check-inline',
                  item_label_class: FORM_CHECK_LABEL, tag: 'fieldset',
                  class: FORM_GROUP, error_class: FORM_GROUP_INVALID,
                  valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: COL_FORM_LABEL do |ba|
      ba.use :label_text
    end
    b.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID,
                  valid_class: IS_VALID
    b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # vertical file input
  config.wrappers :vertical_file, tag: 'div', class: FORM_GROUP,
                                  error_class: FORM_GROUP_INVALID,
                                  valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label
    b.use :input, class: 'form-control-file', error_class: IS_INVALID,
                  valid_class: IS_VALID
    b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK }
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # vertical multi select
  config.wrappers :vertical_multi_select, tag: 'div', class: FORM_GROUP,
                                          error_class: FORM_GROUP_INVALID,
                                          valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.use :label
    b.wrapper tag: 'div', class: FLEX do |ba|
      ba.use :input, class: 'form-control mx-1', error_class: IS_INVALID,
                     valid_class: IS_VALID
    end
    b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # vertical range input
  config.wrappers :vertical_range, tag: 'div', class: FORM_GROUP,
                                   error_class: FORM_GROUP_INVALID,
                                   valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label
    b.use :input, class: 'form-control-range', error_class: IS_INVALID,
                  valid_class: IS_VALID
    b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # horizontal forms
  #
  # horizontal default_wrapper
  config.wrappers :horizontal_form, tag: 'div', class: FORM_GROUP_ROW,
                                    error_class: FORM_GROUP_INVALID,
                                    valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: COL_FORM_LABEL_SM
    b.wrapper :grid_wrapper, tag: 'div', class: COL_SM do |ba|
      ba.use :input, class: FORM_CONTROL, error_class: IS_INVALID,
                     valid_class: IS_VALID
      ba.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK }
      ba.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
    end
  end

  # horizontal input for boolean
  config.wrappers :horizontal_boolean, tag: 'div', class: FORM_GROUP_ROW,
                                       error_class: FORM_GROUP_INVALID,
                                       valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper tag: 'label', class: 'col-sm-3' do |ba|
      ba.use :label_text
    end
    b.wrapper :grid_wrapper, tag: 'div', class: COL_SM do |wr|
      wr.wrapper :form_check_wrapper, tag: 'div', class: FORM_CHECK do |bb|
        bb.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID,
                       valid_class: IS_VALID
        bb.use :label, class: FORM_CHECK_LABEL
        bb.use :full_error,
               wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
        bb.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
      end
    end
  end

  # horizontal input for radio buttons and check boxes
  config.wrappers :horizontal_collection, item_wrapper_class: FORM_CHECK,
                                          item_label_class: FORM_CHECK_LABEL,
                                          tag: 'div', class: FORM_GROUP_ROW,
                                          error_class: FORM_GROUP_INVALID,
                                          valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-3 col-form-label pt-0'
    b.wrapper :grid_wrapper, tag: 'div', class: COL_SM do |ba|
      ba.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID,
                     valid_class: IS_VALID
      ba.use :full_error,
             wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
      ba.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
    end
  end

  # horizontal input for inline radio buttons and check boxes
  config.wrappers :horizontal_collection_inline,
                  item_wrapper_class: 'form-check form-check-inline',
                  item_label_class: FORM_CHECK_LABEL, tag: 'div',
                  class: FORM_GROUP_ROW, error_class: FORM_GROUP_INVALID,
                  valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: 'col-sm-3 col-form-label pt-0'
    b.wrapper :grid_wrapper, tag: 'div', class: COL_SM do |ba|
      ba.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID,
                     valid_class: IS_VALID
      ba.use :full_error,
             wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
      ba.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
    end
  end

  # horizontal file input
  config.wrappers :horizontal_file, tag: 'div', class: FORM_GROUP_ROW,
                                    error_class: FORM_GROUP_INVALID,
                                    valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: COL_FORM_LABEL_SM
    b.wrapper :grid_wrapper, tag: 'div', class: COL_SM do |ba|
      ba.use :input, error_class: IS_INVALID, valid_class: IS_VALID
      ba.use :full_error,
             wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
      ba.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
    end
  end

  # horizontal multi select
  config.wrappers :horizontal_multi_select, tag: 'div', class: FORM_GROUP_ROW,
                                            error_class: FORM_GROUP_INVALID,
                                            valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: COL_FORM_LABEL_SM
    b.wrapper :grid_wrapper, tag: 'div', class: COL_SM do |ba|
      ba.wrapper tag: 'div', class: FLEX do |bb|
        bb.use :input, class: 'form-control mx-1', error_class: IS_INVALID,
                       valid_class: IS_VALID
      end
      ba.use :full_error,
             wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
      ba.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
    end
  end

  # horizontal range input
  config.wrappers :horizontal_range, tag: 'div', class: FORM_GROUP_ROW,
                                     error_class: FORM_GROUP_INVALID,
                                     valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label, class: COL_FORM_LABEL_SM
    b.wrapper :grid_wrapper, tag: 'div', class: COL_SM do |ba|
      ba.use :input, class: 'form-control-range', error_class: IS_INVALID,
                     valid_class: IS_VALID
      ba.use :full_error,
             wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
      ba.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
    end
  end

  # inline forms
  #
  # inline default_wrapper
  config.wrappers :inline_form, tag: 'span', error_class: FORM_GROUP_INVALID,
                                valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: 'sr-only'

    b.use :input, class: FORM_CONTROL, error_class: IS_INVALID,
                  valid_class: IS_VALID
    b.use :error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK }
    b.optional :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # inline input for boolean
  config.wrappers :inline_boolean, tag: 'span',
                                   class: 'form-check mb-2 mr-sm-2',
                                   error_class: FORM_GROUP_INVALID,
                                   valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID,
                  valid_class: IS_VALID
    b.use :label, class: FORM_CHECK_LABEL
    b.use :error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK }
    b.optional :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # bootstrap custom forms
  #
  # custom input for boolean
  config.wrappers :custom_boolean, tag: 'fieldset', class: FORM_GROUP,
                                   error_class: FORM_GROUP_INVALID,
                                   valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper,
              tag: 'div', class: 'custom-control custom-checkbox' do |bb|
      bb.use :input, class: CUSTOM_CONTROL_INPUT, error_class: IS_INVALID,
                     valid_class: IS_VALID
      bb.use :label, class: CUSTOM_CONTROL_LABEL
      bb.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK }
      bb.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
    end
  end

  # custom input switch for boolean
  config.wrappers :custom_boolean_switch, tag: 'fieldset', class: FORM_GROUP,
                                          error_class: FORM_GROUP_INVALID,
                                          valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper, tag: 'div',
                                   class: 'custom-control custom-switch' do |bb|
      bb.use :input, class: CUSTOM_CONTROL_INPUT, error_class: IS_INVALID,
                     valid_class: IS_VALID
      bb.use :label, class: CUSTOM_CONTROL_LABEL
      bb.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK }
      bb.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
    end
  end

  # custom input for radio buttons and check boxes
  config.wrappers :custom_collection, item_wrapper_class: 'custom-control',
                                      item_label_class: CUSTOM_CONTROL_LABEL,
                                      tag: 'fieldset', class: FORM_GROUP,
                                      error_class: FORM_GROUP_INVALID,
                                      valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: COL_FORM_LABEL do |ba|
      ba.use :label_text
    end
    b.use :input, class: CUSTOM_CONTROL_INPUT, error_class: IS_INVALID,
                  valid_class: IS_VALID
    b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # custom input for inline radio buttons and check boxes
  config.wrappers :custom_collection_inline,
                  item_wrapper_class: 'custom-control custom-control-inline',
                  item_label_class: CUSTOM_CONTROL_LABEL, tag: 'fieldset',
                  class: FORM_GROUP, error_class: FORM_GROUP_INVALID,
                  valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: 'legend', class: COL_FORM_LABEL do |ba|
      ba.use :label_text
    end
    b.use :input, class: CUSTOM_CONTROL_INPUT, error_class: IS_INVALID,
                  valid_class: IS_VALID
    b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # custom file input
  config.wrappers :custom_file, tag: 'div', class: FORM_GROUP,
                                error_class: FORM_GROUP_INVALID,
                                valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label
    b.wrapper :custom_file_wrapper, tag: 'div', class: 'custom-file' do |ba|
      ba.use :input, class: 'custom-file-input', error_class: IS_INVALID,
                     valid_class: IS_VALID
      ba.use :label, class: 'custom-file-label'
      ba.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK }
    end
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # custom multi select
  config.wrappers :custom_multi_select, tag: 'div', class: FORM_GROUP,
                                        error_class: FORM_GROUP_INVALID,
                                        valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.use :label
    b.wrapper tag: 'div', class: FLEX do |ba|
      ba.use :input, class: 'custom-select mx-1', error_class: IS_INVALID,
                     valid_class: IS_VALID
    end
    b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # custom range input
  config.wrappers :custom_range, tag: 'div', class: FORM_GROUP,
                                 error_class: FORM_GROUP_INVALID,
                                 valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label
    b.use :input, class: 'custom-range', error_class: IS_INVALID,
                  valid_class: IS_VALID
    b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK }
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # Input Group - custom component
  # see example app and config at https://github.com/rafaelfranca/simple_form-bootstrap
  # config.wrappers :input_group, tag: 'div', class: FORM_GROUP, error_class:
  #  FORM_GROUP_INVALID, valid_class: FORM_GROUP_VALID do |b|
  #   b.use :html5
  #   b.use :placeholder
  #   b.optional :maxlength
  #   b.optional :minlength
  #   b.optional :pattern
  #   b.optional :min_max
  #   b.optional :readonly
  #   b.use :label
  #   b.wrapper :input_group_tag, tag: 'div', class: 'input-group' do |ba|
  #     ba.optional :prepend
  #     ba.use :input, class: FORM_CONTROL, error_class: IS_INVALID,
  #                                         valid_class: IS_VALID
  #     ba.optional :append
  #   end
  #   b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK_BLOCK}
  #   b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  # end

  # Floating Labels form
  #
  # floating labels default_wrapper
  config.wrappers :floating_labels_form, tag: 'div', class: 'form-label-group',
                                         error_class: FORM_GROUP_INVALID,
                                         valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :input, class: FORM_CONTROL, error_class: IS_INVALID,
                  valid_class: IS_VALID
    b.use :label
    b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK }
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # custom multi select
  config.wrappers :floating_labels_select, tag: 'div',
                                           class: 'form-label-group',
                                           error_class: FORM_GROUP_INVALID,
                                           valid_class: FORM_GROUP_VALID do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, class: 'custom-select', error_class: IS_INVALID,
                  valid_class: IS_VALID
    b.use :label
    b.use :full_error, wrap_with: { tag: 'div', class: INVALID_FEEDBACK }
    b.use :hint, wrap_with: { tag: 'small', class: FORM_TEXT }
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :vertical_form

  # Custom wrappers for input types. This should be a hash containing an input
  # type as key and the wrapper that will be used for all inputs with specified
  # type.
  config.wrapper_mappings = {
    boolean: :vertical_boolean,
    check_boxes: :vertical_collection,
    date: :vertical_multi_select,
    datetime: :vertical_multi_select,
    file: :vertical_file,
    radio_buttons: :vertical_collection,
    range: :vertical_range,
    time: :vertical_multi_select
  }

  # enable custom form wrappers
  # config.wrapper_mappings = {
  #   boolean:       :custom_boolean,
  #   check_boxes:   :custom_collection,
  #   date:          :custom_multi_select,
  #   datetime:      :custom_multi_select,
  #   file:          :custom_file,
  #   radio_buttons: :custom_collection,
  #   range:         :custom_range,
  #   time:          :custom_multi_select
  # }
end
