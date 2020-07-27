import cv2
import math

def calc_dist(color1, color2):
    dist = (int(color1[0])-int(color2[0]))**2 + (int(color1[1])-int(color2[1]))**2 + (int(color1[2])-int(color2[2]))**2
    return dist

def average_color(color1, color2):
    avg = (int((int(color1[0]) + int(color2[0]))/2), int((int(color1[1]) + int(color2[1]))/2), int((int(color1[2]) + int(color2[2]))/2))
    return avg

image = cv2.imread("image.png")
n_rows, n_cols, _ = image.shape

colors_list = []

for i in range(n_rows):
    for j in range(n_cols):
        color = image[i, j, :]
        colors_list.append(tuple(color))

colors = list(set(colors_list))
print(len(colors))

for num in range(len(colors)-10):
    min_dist = math.inf
    closest_color_index = -1

    for i in range(1, len(colors)):
        dist = calc_dist(colors[0], colors[i])
        if dist<min_dist:
            min_dist = dist
            closest_color_index = i

    closest_color = colors[closest_color_index]
    colors.pop(closest_color_index)
    color = colors[0]
    colors.pop(0)
    color = average_color(color, closest_color)
    colors.append(color)
    print(num)

print(colors)
print("done")


