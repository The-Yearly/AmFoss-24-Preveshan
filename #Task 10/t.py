import cv2 as cv
import os
from PIL import Image, ImageDraw 
script_dir = os.path.dirname(os.path.abspath(__file__))
path=os.path.join(script_dir,"assets")
layers=os.listdir(path)
values={}
for g in layers:
    img_loc=os.path.join(path,g)
    image= cv.imread(img_loc)
    img=cv.cvtColor(image,cv.COLOR_BGR2RGB)
    gray_image = cv.cvtColor(img, cv.COLOR_BGR2GRAY)
    _, thresh_image = cv.threshold(gray_image, 225, 255, cv.THRESH_BINARY)
    contours, hierarchy = cv.findContours(thresh_image, cv.RETR_TREE, cv.CHAIN_APPROX_SIMPLE)
    for i, contour in enumerate(contours):
        if i == 0:
            color=img[(0,0)]
            continue
        epsilon = 0.01*cv.arcLength(contour, True)
        approx = cv.approxPolyDP(contour, epsilon, True)
        x, y, w, h= cv.boundingRect(approx)
        x_mid = int(x + (w/2)) 
        y_mid = int(y + (h/2)) 
        coords = (y_mid,x_mid)
        color=img[coords]
    ex=g.split(" ")
    nop=ex[1].split(".")
    no=int(nop[0])
    values[no]=[coords,color]
key=list(values.keys())
key.sort()
sorted_values={g:values[g] for g in key}
w, h = 500,500
img = Image.new("RGB", (w, h),color="white") 
img1 = ImageDraw.Draw(img)   
p=sorted_values[1][0][::-1]
for a in sorted_values:
    if a==1:
        continue
    r,g,b=map(int,sorted_values[a][1])
    if [r,g,b]!=[255,255,255]:
        shape = [p,sorted_values[a][0][::-1]] 
        p=sorted_values[a][0][::-1]
        img1.line(shape, fill =(r,g,b), width = 4) 
    else:
        p=sorted_values[a+1][0][::-1]
img.show()