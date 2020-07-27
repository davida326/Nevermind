import cv2
import math

def felbont(colors_list, darab):
    color_min = [math.inf, math.inf, math.inf]
    color_max = [0, 0, 0]
    avg_colors = []
    
    for i in range(3):
        for color in colors_list:
            if color[i] < color_min[i]:
                color_min[i] = color[i]
            if color[i] > color_max[i]:
                color_max[i] = color[i]
                
    ranges = [b - a for a, b in zip(color_min, color_max)]
    n = ranges.index(max(ranges))
    colors_list = sorted(colors_list, key = lambda color: color[n])
    med = colors_list[len(colors_list)//2][n]
    
    lower = []
    upper = []
    for color in colors_list:
        if color[n] < med:
            lower.append(color)
        else:
            upper.append(color)
            
    darab = darab - 1
    if darab != 0:
        avg_colors.extend(felbont(lower, darab))
        avg_colors.extend(felbont(upper, darab))
    else:
        avg_colors = [calc_avg(lower), calc_avg(upper)]
    return avg_colors

def calc_avg(colors_list):
    color_sum = [sum([b for b, g, r in colors_list]),
                 sum([g for b, g, r in colors_list]),
                 sum([r for b, g, r in colors_list])]
    avg_color = (color_sum[0] // len(colors_list),
                 color_sum[1] // len(colors_list),
                 color_sum[2] // len(colors_list))
    return avg_color

image = cv2.imread("image.png")
n_rows, n_cols, _ = image.shape

colors_list = []

for i in range(n_rows):
    for j in range(n_cols):
        color = image[i, j, :]
        colors_list.append(tuple(color))

#colors = list(set(colors_list))
darab = 4
palette = felbont(colors_list, darab)
print(palette)
