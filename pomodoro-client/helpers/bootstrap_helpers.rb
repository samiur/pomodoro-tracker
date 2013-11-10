module BootstrapHelpers
  def fluid_row(rows)
    inner_html = []
    rows.each do |row|
      inner_html << content_tag(:div, class: "span#{row[:width]}"){row[:content]}
    end
    content_tag(:div, class: "row-fluid") do
      inner_html.join("\n").html_safe
    end
  end

  def simple_two_column(col1, col2, col1_size, col2_size)
    content = [{width: col1_size, content: col1},
              {width: col2_size, content: col2}]
    fluid_row(content)
  end

  def proportional_align(rows)
    inner_html = []
    offset = 0
    rows.each do |row|
      inner_html << content_tag(:div, class: "span#{row[:width]} offset#{offset}"){row[:content]}
      offset+= row[:width]
    end
    content_tag :div, class: "row-fluid" do
      inner_html.compact.join("\n").html_safe
    end
  end
end
