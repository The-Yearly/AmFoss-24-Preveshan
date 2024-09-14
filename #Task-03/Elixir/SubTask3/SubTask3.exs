defmodule Subtask3 do
  def pat(g,c,m,s1,s2,n) do
    if g > -1 do
      if c !=0 do
        IO.write(String.duplicate(" ",c))
      end
      IO.puts (String.duplicate("*",m))
      g=g-1
      m=m+s2*2
      c=c+s1
      s1 = if c == 0, do: 1, else: s1
      {s2,m} =
        if m > n do
          {-1 ,n - 2 }
        else
          {s2, m}
        end
      pat(g,c,m,s1,s2,n)

    end
  end
end
x=IO.gets("n: ")
y=String.trim(x)
n=String.to_integer(y)
if rem(n,2)!=0 do
  o=div(n,2)
  c=n-o-1
  m=1
  s1=-1
  s2=1
  Subtask3.pat(n-1,c,m,s1,s2,n)
else
  IO.puts "Enter Odd Number"
end
