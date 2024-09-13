puts "Enter n"
n=gets.to_i
if n%2==1
  x=(n.to_f/2).floor
  c=n-x-1
  puts c
  m=1
  s1=-1
  s2=1
  for g in 0..n-1 do
    if c!=0
      print " "*c
    end
    puts "*"*m
    m+=s2*2
    c+=s1
    if c==0
      s1=1
    end
    if m>n
      s2=-1
      m=n-2
    end
  end
else
  puts "Enter Odd"
end