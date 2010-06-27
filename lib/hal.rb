module HAL
  class UnknownSubject < StandardError; end
  class ICantLetYouDoThat < StandardError; end

  def self.rules_for(klass, &block)
    subject = Class.new(Subject, &block)
    subjects[klass] = subject
  end

  def self.can(object)
    subject = subjects.fetch(object.class) do
      raise UnknownSubject, "No rules were defined for #{object}"
    end
    subject.new(object)
  end

  def can(object)
    HAL.can(object)
  end

  def enforce(object, &block)
    block.call(can(object)) || raise(ICantLetYouDoThat, "#{object.inspect} can't do that")
  end

  def self.subjects
    @subjects ||= {}
  end
  private_class_method :subjects

  class Subject < Struct.new(:subject)
  end
end
