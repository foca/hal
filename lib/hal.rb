module HAL
  # Raised when you inquire for an object that has no rules defined.
  class UnknownSubject < StandardError; end

  # Raised when you enforce a rule and it fails.
  class ICantLetYouDoThat < StandardError; end

  # Define a set of rules for a specific class. If you call this method multiple
  # times then it adds to the current set of rules.
  #
  #     HAL.rules_for User do
  #       def breathe?
  #         true
  #       end
  #     end
  #
  # Rules have access to a "subject" method that will return the object passed
  # to HAL.can when checking if the object satisfies the rule.
  #
  #     HAL.rules_for User do
  #       def open_the_pod_bay_doors?
  #         subject.name != "Dave"
  #       end
  #     end
  def self.rules_for(klass, &block)
    subjects[klass].class_eval(&block)
  end

  # Return a "Subject" object in which you can check rules. Subjects have all
  # the methods you defined as rules, and a "subject" method that returns the
  # object passed to this method.
  #
  #     dave = User.new(:name => "Dave")
  #     john = User.new(:name => "John")
  #     can(dave).open_the_pod_bay_doors? #=> false
  #     can(john).open_the_pod_bay_doors? #=> true
  #
  # It can raise UnknownSubject if the object you pass doesn't have any rules
  # declared.
  def self.can(object)
    subject = subjects.fetch(object.class) do
      raise UnknownSubject, "No rules were defined for #{object}"
    end
    subject.new(object)
  end

  # Enforce a permission. If the block evaluates to false, it will raise
  # HAL::ICantLetYouDoThat.
  #
  #     enforce(dave) {|can| can.open_the_pod_bay_doors? } #=> Raises
  def self.enforce(object, &block)
    block.call(can(object)) ||
      raise(ICantLetYouDoThat, "#{object.inspect} can't do that")
  end

  # Helper method you can include in your own classes to have a nicer API for
  # checking permissions. See HAL.can
  def can(object)
    HAL.can(object)
  end

  # Helper method you can include in your own classes to have a nicer API for
  # enforcing permissions. See HAL.enforce
  def enforce(object, &block)
    HAL.enforce(object, &block)
  end

  def self.subjects
    @subjects ||= Hash.new {|h,k| h[k] = Class.new(Subject) }
  end
  private_class_method :subjects

  class Subject < Struct.new(:subject); end
end
