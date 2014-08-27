class CalendarInput < SimpleForm::Inputs::Base
  def input
    @builder.date_field(attribute_name, input_html_options).html_safe
  end
end
