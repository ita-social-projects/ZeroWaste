{ :uk =>
  { :i18n =>
    { :plural =>
      { :keys => [:one, :few, :other],
        :rule => lambda { |n|
          if n > 10 && ["11", "12" ,"13", "14"].include?(n.to_s[-2..-1])
            :few
          elsif n.to_s == "1" || (n > 20 && n.to_s[-1] == "1")
            :one
          elsif ["2", "3", "4"].include?(n.to_s[-1])
              :many
          else
            :other
          end
        }
      }
    }
  }
}