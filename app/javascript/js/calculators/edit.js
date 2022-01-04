$(document).on('turbolinks:load', () => {
  const page = document.getElementById('calculators-edit');
  if (!page) return

  const $fieldKindSelect = $('#calculator_fields_kind')
  const $fieldTypeSelect = $('#calculator_fields_type')
  const $fieldSubmitButton = $('#add-calculator-field')
  const TYPES = $fieldKindSelect.data('fields-list')

  $fieldKindSelect.on('change', (e) => {
    const data = TYPES[e.currentTarget.value]

    if (data && data.length) {
      const optionsForSelect = data.map((fieldType) => {
        return `<option value="${fieldType}">${fieldType}</option>`
      })
      const placeholderOption = '<option>Select field type</option>'

      $fieldTypeSelect.prop('disabled', false)
      $fieldTypeSelect.html(placeholderOption + optionsForSelect)
    } else {
      $fieldTypeSelect.prop('disabled', true)
      $fieldTypeSelect.html('')
      $fieldSubmitButton.addClass('disabled')
    }
  })

  $fieldTypeSelect.on('change', (e) => {
    if (e.currentTarget.value) {
      $fieldSubmitButton.removeClass('disabled')
    } else {
      $fieldSubmitButton.addClass('disabled')
    }
  })

  $fieldSubmitButton.on('click', (e) => {
    const url = $fieldSubmitButton.data('url')

    $.ajax({
      url: url,
      type: 'POST',
      dataType: 'JSON',
      data: {
        field: {
          kind: $fieldKindSelect.val(),
          type: $fieldTypeSelect.val()
        }
      },
      complete: () => {
        window.location.reload()
      }
    })
  })
})
