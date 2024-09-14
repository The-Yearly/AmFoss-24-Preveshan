input = File.open("input.txt", "r")
contents = input.read
output=File.open("output.txt","w")
output.write(contents)
