# IsEven SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module IsEvenFeatures
  def self.make_feature(name)
    case name
    when "base"
      IsEvenBaseFeature.new
    when "test"
      IsEvenTestFeature.new
    else
      IsEvenBaseFeature.new
    end
  end
end
