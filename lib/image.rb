class Image
  def initialize(args)
    @images = args
    @number_of_rows = @images.length
    @number_of_columns = @images[0].length
  end
  
  
  def blur(distance)
    @last_image = Marshal.load(Marshal.dump(@images))
    blur_distance_counter = 0
    
    1.upto(distance).each do |blur_cell|
      0.upto(@number_of_rows - 1).each do |current_row|
        0.upto(@number_of_columns - 1).each do |current_column|
          my_cell = on?(current_row, current_column)
          below_me = on?(current_row - 1, current_column)
          above_me = on?(current_row + 1, current_column)
          to_my_right = on?(current_row, current_column + 1)
          to_my_left = on?(current_row, current_column - 1)
          
          if !my_cell &&
            (
            to_my_left ||
            to_my_right ||
            above_me ||
            below_me
            )
            @images[current_row][current_column] = 1
          end
        end
      end
      blur_distance_counter = blur_distance_counter + 1
      @last_image = Marshal.load(Marshal.dump(@images))
    end
    
  end
  
  def on?(row, column)
    #first check validity
    if (row >= 0) && (row <= (@number_of_rows - 1)) &&
      (column >= 0) && (column <= (@number_of_columns - 1))
      #then check "on"
      @last_image[row][column] == 1
    else
      false
    end
  end
  
  def output_image
    @images.each do |image|
      puts image.join
    end
    puts
  end
end

# image = Image.new([
#   [1, 0, 0, 0, 0, 0],
#   [0, 0, 0, 0, 0, 0],
#   [0, 0, 0, 0, 0, 0],
#   [0, 0, 0, 0, 0, 0],
#   [0, 0, 0, 0, 0, 0],
#   [0, 0, 0, 0, 0, 1]
# ]
# )
#
# image.output_image
# image.blur(3)
# image.output_image
