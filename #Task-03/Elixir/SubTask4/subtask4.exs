defmodule Subtask3 do
  def pat(g,c,m,s1,s2,n,str) do
    if g >= 0 do
      str=str<>String.duplicate(" ", c)
      str= str<>String.duplicate("*", m)<>"\n"
      g=g-1
      m=m+s2*2
      c=c+s1
      s1= if c == 0, do: 1, else: s1

      {s2, m} = if m > n do
        {-1, n - 2}
      else
        {s2, m}
      end

      pat(g,c,m,s1,s2,n,str)
    else
      str
    end
  end
end

{:ok,content}=File.read("input.txt")
n=String.to_integer(content)
if rem(n, 2) != 0 do
  o=div(n, 2)
  c=n-o-1
  m=1
  s1=-1
  s2=1
  str=""
  str=Subtask3.pat(n - 1, c, m, s1, s2, n, str)
  IO.puts str
  File.write("output.txt",str)
else
  IO.puts "Enter Odd Number"
end
