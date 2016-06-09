require_relative 'nmatrix/lib/nmatrix'
a = Array.new(1000)
(0...100000000).each do |i|
  a[i] = 9999
end
b=[2,1,1,2]

n = NMatrix.new(:dense, [10000,10000], a, :int64)
puts n+n