# frozen_string_literal: true

# These defaults are defined and maintained by the community at
# https://github.com/heartcombo/simple_form-bootstrap
# Please submit feedback, changes and tests only there.
ALERT_DANGER               = "alert alert-danger"
COL_FORM_LABEL             = "col-form-label pt-0"
COL_FORM_LABEL_SM          = "col-sm-3 col-form-label"
COL_FORM_LABEL_SM_PT       = "col-sm-3 col-form-label pt-0"
COL_SM                     = "col-sm-9"
IS_VALID                   = "is-valid"
IS_INVALID                 = "is-invalid"
FORM_CHECK_LABEL           = "form-check-label"
FORM_CHECK                 = "form-check"
FORM_CHECK_INPUT           = "form-check-input"
FORM_CONTROL               = "form-control"
FORM_GROUP                 = "form-group"
FORM_LABEL                 = "form-label"
FORM_LABEL_BLOCK           = "form-label d-block"
FORM_SELECT                = "form-select"
FORM_TEXT                  = "form-text"
FLEX                       = "d-flex flex-row justify-content-between align-items-center"
INVALID_FEEDBACK           = "invalid-feedback"
INVALID_FEEDBACK_BLOCK     = "invalid-feedback d-block"
MB                         = "mb-3"
ROW_MB                     = "row mb-3"

# Uncomment this and change the path if necessary to include your own
# components.
# See https://github.com/heartcombo/simple_form#custom-components
# to know more about custom components.
Dir[Rails.root.join("lib", "components", "**", "*.rb")].sort.each { |f| require f }

# Use this setup block to configure all options available in SimpleForm.
SimpleForm.setup do |config|
  # Default class for buttons
  config.button_class = "btn"

  # Define the default class of the input wrapper of the boolean input.
  config.boolean_label_class = FORM_CHECK_LABEL

  # How the label text should be generated altogether with the required text.
  config.label_text = lambda { |label, required, explicit_label| "#{label} #{required}" }

  # Define the way to render check boxes / radio buttons with labels.
  config.boolean_style = :inline

  # You can wrap each item in a collection of radio/check boxes with a tag
  config.item_wrapper_tag = :div

  # Defines if the default input wrapper class should be included in radio
  # collection wrappers.
  config.include_default_input_wrapper_class = false

  # CSS class to add for error notification helper.
  config.error_notification_class = ALERT_DANGER

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
  config.wrappers :vertical_form, class: MB do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: FORM_LABEL
    b.use :input, class: FORM_CONTROL, error_class: IS_INVALID, valid_class: IS_VALID
    b.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
    b.use :hint, wrap_with: { class: FORM_TEXT }
  end

  # vertical input for boolean
  config.wrappers :vertical_boolean, tag: "fieldset", class: MB do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper, class: FORM_CHECK do |bb|
      bb.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID, valid_class: IS_VALID
      bb.use :label, class: FORM_CHECK_LABEL
      bb.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
      bb.use :hint, wrap_with: { class: FORM_TEXT }
    end
  end

  # vertical input for radio buttons and check boxes
  config.wrappers :vertical_collection, item_wrapper_class: FORM_CHECK, item_label_class: FORM_CHECK_LABEL, tag: "fieldset", class: MB do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: "legend", class: COL_FORM_LABEL do |ba|
      ba.use :label_text
    end
    b.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID, valid_class: IS_VALID
    b.use :full_error, wrap_with: { class: INVALID_FEEDBACK_BLOCK }
    b.use :hint, wrap_with: { class: FORM_TEXT }
  end

  # vertical input for inline radio buttons and check boxes
  config.wrappers :vertical_collection_inline, item_wrapper_class: "form-check form-check-inline", item_label_class: FORM_CHECK_LABEL, tag: "fieldset", class: MB do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :legend_tag, tag: "legend", class: COL_FORM_LABEL do |ba|
      ba.use :label_text
    end
    b.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID, valid_class: IS_VALID
    b.use :full_error, wrap_with: { class: INVALID_FEEDBACK_BLOCK }
    b.use :hint, wrap_with: { class: FORM_TEXT }
  end

  # vertical file input
  config.wrappers :vertical_file, class: MB do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: FORM_LABEL
    b.use :input, class: FORM_CONTROL, error_class: IS_INVALID, valid_class: IS_VALID
    b.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
    b.use :hint, wrap_with: { class: FORM_TEXT }
  end

  # vertical select input
  config.wrappers :vertical_select, class: MB do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: FORM_LABEL
    b.use :input, class: FORM_SELECT, error_class: IS_INVALID, valid_class: IS_VALID
    b.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
    b.use :hint, wrap_with: { class: FORM_TEXT }
  end

  # vertical multi select
  config.wrappers :vertical_multi_select, class: MB do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: FORM_LABEL
    b.wrapper class: FLEX do |ba|
      ba.use :input, class: "form-select mx-1", error_class: IS_INVALID, valid_class: IS_VALID
    end
    b.use :full_error, wrap_with: { class: INVALID_FEEDBACK_BLOCK }
    b.use :hint, wrap_with: { class: FORM_TEXT }
  end

  # vertical range input
  config.wrappers :vertical_range, class: MB do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label, class: FORM_LABEL
    b.use :input, class: "form-range", error_class: IS_INVALID, valid_class: IS_VALID
    b.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
    b.use :hint, wrap_with: { class: FORM_TEXT }
  end

  # horizontal forms
  #
  # horizontal default_wrapper
  config.wrappers :horizontal_form, class: ROW_MB do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: COL_FORM_LABEL_SM
    b.wrapper :grid_wrapper, class: COL_SM do |ba|
      ba.use :input, class: FORM_CONTROL, error_class: IS_INVALID, valid_class: IS_VALID
      ba.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
      ba.use :hint, wrap_with: { class: FORM_TEXT }
    end
  end

  # horizontal input for boolean
  config.wrappers :horizontal_boolean, class: ROW_MB do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :grid_wrapper, class: "col-sm-9 offset-sm-3" do |wr|
      wr.wrapper :form_check_wrapper, class: FORM_CHECK do |bb|
        bb.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID, valid_class: IS_VALID
        bb.use :label, class: FORM_CHECK_LABEL
        bb.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
        bb.use :hint, wrap_with: { class: FORM_TEXT }
      end
    end
  end

  # horizontal input for radio buttons and check boxes
  config.wrappers :horizontal_collection, item_wrapper_class: FORM_CHECK, item_label_class: FORM_CHECK_LABEL, class: ROW_MB do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: COL_FORM_LABEL_SM_PT
    b.wrapper :grid_wrapper, class: COL_SM do |ba|
      ba.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID, valid_class: IS_VALID
      ba.use :full_error, wrap_with: { class: INVALID_FEEDBACK_BLOCK }
      ba.use :hint, wrap_with: { class: FORM_TEXT }
    end
  end

  # horizontal input for inline radio buttons and check boxes
  config.wrappers :horizontal_collection_inline, item_wrapper_class: "form-check form-check-inline", item_label_class: FORM_CHECK_LABEL, class: ROW_MB do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: COL_FORM_LABEL_SM_PT
    b.wrapper :grid_wrapper, class: COL_SM do |ba|
      ba.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID, valid_class: IS_VALID
      ba.use :full_error, wrap_with: { class: INVALID_FEEDBACK_BLOCK }
      ba.use :hint, wrap_with: { class: FORM_TEXT }
    end
  end

  # horizontal file input
  config.wrappers :horizontal_file, class: ROW_MB do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: COL_FORM_LABEL_SM
    b.wrapper :grid_wrapper, class: COL_SM do |ba|
      ba.use :input, class: FORM_CONTROL, error_class: IS_INVALID, valid_class: IS_VALID
      ba.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
      ba.use :hint, wrap_with: { class: FORM_TEXT }
    end
  end

  # horizontal select input
  config.wrappers :horizontal_select, class: ROW_MB do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: COL_FORM_LABEL_SM
    b.wrapper :grid_wrapper, class: COL_SM do |ba|
      ba.use :input, class: FORM_SELECT, error_class: IS_INVALID, valid_class: IS_VALID
      ba.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
      ba.use :hint, wrap_with: { class: FORM_TEXT }
    end
  end

  # horizontal multi select
  config.wrappers :horizontal_multi_select, class: ROW_MB do |b|
    b.use :html5
    b.optional :readonly
    b.use :label, class: COL_FORM_LABEL_SM
    b.wrapper :grid_wrapper, class: COL_SM do |ba|
      ba.wrapper class: FLEX do |bb|
        bb.use :input, class: "form-select mx-1", error_class: IS_INVALID, valid_class: IS_VALID
      end
      ba.use :full_error, wrap_with: { class: INVALID_FEEDBACK_BLOCK }
      ba.use :hint, wrap_with: { class: FORM_TEXT }
    end
  end

  # horizontal range input
  config.wrappers :horizontal_range, class: ROW_MB do |b|
    b.use :html5
    b.use :placeholder
    b.optional :readonly
    b.optional :step
    b.use :label, class: COL_FORM_LABEL_SM_PT
    b.wrapper :grid_wrapper, class: COL_SM do |ba|
      ba.use :input, class: "form-range", error_class: IS_INVALID, valid_class: IS_VALID
      ba.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
      ba.use :hint, wrap_with: { class: FORM_TEXT }
    end
  end

  # inline forms
  #
  # inline default_wrapper
  config.wrappers :inline_form, class: "col-12" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: "visually-hidden"

    b.use :input, class: FORM_CONTROL, error_class: IS_INVALID, valid_class: IS_VALID
    b.use :error, wrap_with: { class: INVALID_FEEDBACK }
    b.optional :hint, wrap_with: { class: FORM_TEXT }
  end

  # inline input for boolean
  config.wrappers :inline_boolean, class: "col-12" do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper, class: FORM_CHECK do |bb|
      bb.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID, valid_class: IS_VALID
      bb.use :label, class: FORM_CHECK_LABEL
      bb.use :error, wrap_with: { class: INVALID_FEEDBACK }
      bb.optional :hint, wrap_with: { class: FORM_TEXT }
    end
  end

  # bootstrap custom forms
  #
  # custom input switch for boolean
  config.wrappers :custom_boolean_switch, class: MB do |b|
    b.use :html5
    b.optional :readonly
    b.wrapper :form_check_wrapper, tag: "div", class: "form-check form-switch" do |bb|
      bb.use :input, class: FORM_CHECK_INPUT, error_class: IS_INVALID, valid_class: IS_VALID
      bb.use :label, class: FORM_CHECK_LABEL
      bb.use :full_error, wrap_with: { tag: "div", class: INVALID_FEEDBACK }
      bb.use :hint, wrap_with: { class: FORM_TEXT }
    end
  end

  # Input Group - custom component
  # see example app and config at https://github.com/heartcombo/simple_form-bootstrap
  config.wrappers :input_group, class: MB do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :label, class: FORM_LABEL
    b.wrapper :input_group_tag, class: "input-group" do |ba|
      ba.optional :prepend
      ba.use :input, class: FORM_CONTROL, error_class: IS_INVALID, valid_class: IS_VALID
      ba.optional :append
      ba.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
    end
    b.use :hint, wrap_with: { class: FORM_TEXT }
  end

  # Floating Labels form
  #
  # floating labels default_wrapper
  config.wrappers :floating_labels_form, class: "form-floating mb-3" do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :pattern
    b.optional :min_max
    b.optional :readonly
    b.use :input, class: FORM_CONTROL, error_class: IS_INVALID, valid_class: IS_VALID
    b.use :label
    b.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
    b.use :hint, wrap_with: { class: FORM_TEXT }
  end

  # custom multi select
  config.wrappers :floating_labels_select, class: "form-floating mb-3" do |b|
    b.use :html5
    b.optional :readonly
    b.use :input, class: FORM_SELECT, error_class: IS_INVALID, valid_class: IS_VALID
    b.use :label
    b.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
    b.use :hint, wrap_with: { class: FORM_TEXT }
  end

  # custom vertical file input
  config.wrappers :custom_vertical_file, class: MB do |b|
    b.use :html5
    b.use :placeholder
    b.optional :maxlength
    b.optional :minlength
    b.optional :readonly
    b.use :label, class: FORM_LABEL_BLOCK
    b.use :input, error_class: IS_INVALID, valid_class: IS_VALID
    b.use :full_error, wrap_with: { class: INVALID_FEEDBACK }
    b.use :hint, wrap_with: { class: FORM_TEXT }
  end

  # The default wrapper to be used by the FormBuilder.
  config.default_wrapper = :vertical_form

  # Custom wrappers for input types. This should be a hash containing an input
  # type as key and the wrapper that will be used for all inputs with specified type.
  config.wrapper_mappings = {
    boolean: :vertical_boolean,
    check_boxes: :vertical_collection,
    date: :vertical_multi_select,
    datetime: :vertical_multi_select,
    file: :vertical_file,
    radio_buttons: :vertical_collection,
    range: :vertical_range,
    time: :vertical_multi_select,
    select: :vertical_select
  }
end
