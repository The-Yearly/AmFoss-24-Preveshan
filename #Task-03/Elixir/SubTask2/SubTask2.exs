{:ok,content}=File.read("input.txt")
IO.puts(content)
File.write("output.txt",content)
