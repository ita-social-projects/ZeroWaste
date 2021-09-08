class Dipers

    def dipers_per_month ( x, data = {} ) 
        sum = 0
        data.each { |key, value| 
          if ( key <= x )
            sum += value  
          end
        }
        p sum
    end
end
 
    # calc = Dipers.new
    # calc.dipers_per_month(5,{0 => 30, 1 => 30, 2 => 30, 3 =>70, 4 => 70,5 => 70})
    # calc.dipers_per_month(2,{0 => 30, 1 => 40, 2 => 70})