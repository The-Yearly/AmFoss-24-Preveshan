while True:
    n=int(input())
    if n%2!=0:
        c=n-(n//2)-1
        print(c)
        m=1
        s1=-1
        s2=1
        for g in range(n):
            if c!=0:
                print(" "*c,end="")
            print("*"*m)
            m+=(s2*2)
            c+=s1
            if c==0:
                s1=1
            if m>n:
                s2=-1
                m=n-2
    else:
        print("Enter A Odd Number")

