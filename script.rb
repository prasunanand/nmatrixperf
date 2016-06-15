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
    store[:elementsCount] = []
    store[:features] = {jruby: {}, ruby: {}}
    store[:features][:ruby][:addition] = []
    store[:features][:ruby][:subtraction] = []
    store[:features][:ruby][:multiplication] = []
    store[:features][:ruby][:determinant] = []

    store[:features][:jruby][:addition] = []
    store[:features][:jruby][:subtraction] = []
    store[:features][:jruby][:multiplication] = []
    store[:features][:jruby][:determinant] = []

    shapeArray = [
                  [10,10],[50,50],[100,100],[500,500],
                  [1000,1000],[2000,2000],[3000,3000],
                  [4000,4000],[5000,5000],[6000,6000],
                  [7000,7000], [8000,8000],[9000,9000],
                  [10000,10000]
                ]
    if jruby?
      shapeArray.each do |shape|
        size = shape[0] * shape[1]
        elements1 = Java::double[size].new
        (0...size).each do |i|
          elements1[i] = rand(1...999999)
        end
        elements2 = Java::double[size].new
        (0...size).each do |i|
          elements1[i] = rand(1...999999)
        end
        nmatrix1 = NMatrix.new(shape, elements1.to_a, dtype: :float32)
        nmatrix2 = NMatrix.new(shape, elements2.to_a, dtype: :float32)
        store[:features][:jruby][:addition] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1 + nmatrix2}.to_s.tr('()', '').split(" ")[3].to_f ]
        store[:features][:jruby][:subtraction] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1 - nmatrix2}.to_s.tr('()', '').split(" ")[3].to_f ]
        store[:features][:jruby][:multiplication] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1.dot(nmatrix2)}.to_s.tr('()', '').split(" ")[3].to_f ]
        # store[:features][:ruby][:determinant] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1.det_exact}.to_s.tr('()', '').split(" ")[3].to_f ]
        puts store.to_json
      end
    else
      shapeArray.each do |shape|
        elements1 = Array.new(shape[0]*shape[1]) { rand(1...999999) }
        elements2 = Array.new(shape[0]*shape[1]) { rand(1...999999) }
        nmatrix1 = NMatrix.new(shape, elements1, dtype: :float32)
        nmatrix2 = NMatrix.new(shape, elements2, dtype: :float32)


        store[:features][:ruby][:addition] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1 + nmatrix2}.to_s.tr('()', '').split(" ")[3].to_f ]
        store[:features][:ruby][:subtraction] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1 - nmatrix2}.to_s.tr('()', '').split(" ")[3].to_f ]
        store[:features][:ruby][:multiplication] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1.dot(nmatrix2)}.to_s.tr('()', '').split(" ")[3].to_f ]
        # store[:features][:ruby][:determinant] << [ shape[0]*shape[1], Benchmark.measure{nmatrix1.det}.to_s.tr('()', '').split(" ")[3].to_f ]
        puts store.to_json
      end
    end


    puts "======================================================="
    puts store.to_json
  end
end
# (0...100).each do |i|
#   puts Benchmark.measure{a.dot(b)}.to_s.tr('()', '').split(" ")
# end
# store[:multiplication][:e10000000] = Benchmark.measure{a.dot(b)}.to_s.tr('()', '').split(" ")
ResultCollect.generate


