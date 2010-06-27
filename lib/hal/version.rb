module HAL
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 0
    STRING = [MAJOR, MINOR, PATCH].join(".")

    def self.to_s
      STRING
    end
  end
end
