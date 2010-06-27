require "hal"

module HAL
  def self.included(base)
    base.helper_method :can if base.respond_to?(:helper_method)
  end
end
