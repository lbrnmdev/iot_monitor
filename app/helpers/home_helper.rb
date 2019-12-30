module HomeHelper
  def temp_reading_color value
    if value < 10
      "purple"
    elsif value < 15
      "blue"
    elsif value < 20
      "teal"
    elsif value < 25
      "teal"
    elsif value < 30
      "orange"
    else
      "red"
    end
  end
end
