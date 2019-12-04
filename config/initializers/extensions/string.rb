class String
  def shifted_names_as_array(string)
    array = []
    # string = string.
    space_position = string.index(' ')
    string.downcase!.gsub!(/\s/, '')
    # p string
    string.size.times do |i|
      j = 0
      new_string = string
      string.each_char do |c|
        j = j+1
        new_string[j] = c if j <= string.size
        new_string[j - string.size] = c if j > string.size
      end
      array << new_string
    end
    return array
  end
end