require_relative 'nmatrix/lib/nmatrix'

require 'benchmark'
require 'json'

class ResultCollect

  def self.generate


    def jruby?
      /java/ === RUBY_PLATFORM
    end

    result = {}

    store = {}
    store[:addition] = []
    store[:subtraction] = {}
    store[:multiplication] = {} 


    shape1 = [10, 1]
    shape2 = [1, 10]
    shape3 = [1, 10]


    elements1 = Array.new(10) { rand(1...999999) }
    elements2 = Array.new(10) { rand(1...999999) }
    elements3 = Array.new(10) { rand(1...999999) }

    a = NMatrix.new(shape1, elements1 , dtype: :float32)
    b = NMatrix.new(shape2, elements2 , dtype: :float32)
    c = NMatrix.new(shape3, elements3 , dtype: :float32)

    store[:addition] << Benchmark.measure{b + c}.to_s.tr('()', '').split(" ")[3].to_i
    store[:subtraction][:e10] = Benchmark.measure{b - c}.to_s.tr('()', '').split(" ")
    store[:multiplication][:e10] = Benchmark.measure{a.dot(b)}.to_s.tr('()', '').split(" ")



    shape1 = [100, 10]
    shape2 = [10, 100]
    shape3 = [10, 100]


    elements1 = Array.new(1000) { rand(1...999999) }
    elements2 = Array.new(1000) { rand(1...999999) }
    elements3 = Array.new(1000) { rand(1...999999) }

    a = NMatrix.new(shape1, elements1 , dtype: :float32)
    b = NMatrix.new(shape2, elements2 , dtype: :float32)
    c = NMatrix.new(shape3, elements3 , dtype: :float32)

    store[:addition] << Benchmark.measure{b + c}.to_s.tr('()', '').split(" ")[3].to_i
    store[:subtraction][:e1000] = Benchmark.measure{b - c}.to_s.tr('()', '').split(" ")
    store[:multiplication][:e1000] = Benchmark.measure{a.dot(b)}.to_s.tr('()', '').split(" ")


    shape1 = [1000, 100]
    shape2 = [100, 1000]
    shape3 = [100, 1000]


    elements1 = Array.new(100000) { rand(1...999999) }
    elements2 = Array.new(100000) { rand(1...999999) }
    elements3 = Array.new(100000) { rand(1...999999) }

    a = NMatrix.new(shape1, elements1 , dtype: :float32)
    b = NMatrix.new(shape2, elements2 , dtype: :float32)
    c = NMatrix.new(shape3, elements3 , dtype: :float32)

    store[:addition] << Benchmark.measure{b + c}.to_s.tr('()', '').split(" ")[3].to_i
    store[:subtraction][:e100000] = Benchmark.measure{b - c}.to_s.tr('()', '').split(" ")
    store[:multiplication][:e100000] = Benchmark.measure{a.dot(b)}.to_s.tr('()', '').split(" ")


    shape1 = [10000, 1000]
    shape2 = [1000, 10000]
    shape3 = [1000, 10000]


    elements1 = Array.new(10000000) { rand(1...999999) }
    elements2 = Array.new(10000000) { rand(1...999999) }
    elements3 = Array.new(10000000) { rand(1...999999) }

    a = NMatrix.new(shape1, elements1 , dtype: :float32)
    b = NMatrix.new(shape2, elements2 , dtype: :float32)
    c = NMatrix.new(shape3, elements3 , dtype: :float32)

    store[:addition] << Benchmark.measure{b + c}.to_s.tr('()', '').split(" ")[3].to_i
    store[:subtraction][:e10000000] = Benchmark.measure{b - c}.to_s.tr('()', '').split(" ")

    if jruby?
      result[:jruby] = store
    else
      result[:ruby] = store
    end

    puts result.to_json
  end
end
# (0...100).each do |i|
#   puts Benchmark.measure{a.dot(b)}.to_s.tr('()', '').split(" ")
# end
# store[:multiplication][:e10000000] = Benchmark.measure{a.dot(b)}.to_s.tr('()', '').split(" ")
ResultCollect.generate


