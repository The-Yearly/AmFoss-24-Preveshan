f=open("input.txt","r")
r=f.read()
f.close()
n=int(r)
f=open("output.txt","w")
if n%2!=0:
    c=n-(n//2)-1
    m=1
    s1=-1
    s2=1
    for g in range(n):
        if c!=0:
            f.write(" "*c)
        f.write("*"*m+"\n")
        m+=(s2*2)
        c+=s1
        if c==0:
            s1=1
        if m>n:
            s2=-1
            m=n-2
else:
    print("Enter A Odd Number")
f.close()
print("Done...")
