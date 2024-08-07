f=open("input.txt","r")
r=f.read()
f.close()
print("The String Stored In input.txt is",r)
f=open("output.txt","w")
f.write(r)
print("The Content In input.txt Has Successfully Been Copied To output.txt")
f.close()

