from google_images_download import google_images_download as gi
import random
import os
from PIL import Image
from PIL import ImageChops
import sys
import argparse

parser = argparse.ArgumentParser()
parser.add_argument('-w', '--words', default=5, help='define number of words')
parser.add_argument('-rp', '--redopath', default='', help='redo images at defined path')

args = parser.parse_args()

#default
NUM_WORDS = int(args.words)
REDOPATH = args.redopath
IMAGE_SIZE = 1080, 1080

def _main_():
    if REDOPATH:
        getImages(REDOPATH, 'redo')
        return

    #create directory for this instance of images
    dir_inc = 0
    image_dir = "images_" + str(dir_inc)
    while(os.path.exists("downloads/images_" + str(dir_inc))):
        dir_inc += 1
        image_dir = "images_" + str(dir_inc)
    print(image_dir)



    #generate random set of words
    word_file = "/usr/share/dict/words" #mac or linux required for this
    WORDS = open(word_file).read().splitlines()

    rand_words = []
    for i in range(NUM_WORDS):
        print(random.choice(WORDS))
        rand_words.append(random.choice(WORDS))

    rand_words_arg = ' ,'.join(rand_words)



    #download images
    response = gi.googleimagesdownload()
    args = {"keywords":rand_words_arg,
            "limit":1,
            "image_directory":image_dir,
            "aspect_ratio":"square",
            "print_urls":True}

    paths = response.download(args)

    #import images
    path = "downloads/"+image_dir
    getImages(path, "image"+str(dir_inc))

    with open("reference.txt", "a+") as f:
        f.write(image_dir + "\n")
        for w in rand_words:
            f.write("\t"+w+"\n")


def getImages(path, name):
    images = []
    img_files = os.listdir(path)

    # print(img_files)
    for file in img_files:
        try:
            images.append(Image.open(path+"/"+file).resize(IMAGE_SIZE, Image.ANTIALIAS).convert('RGBA'))
        except OSError:
            print("cant open image " + file)

    # opacity = 1.0/len(images)

    opacity = .5

    for i in range(len(images)):
        if i == 0:
            blended_image = images[i]
            continue
        next_image = images[i]
        # next_image.putalpha(220)
        # blended_image = ImageChops.add(blended_image, next_image)
        # blended_image = ImageChops.blend(blended_image, next_image, opacity)
        blended_image = blend(blended_image, next_image)


    blended_image.save(name+"_"+str(NUM_WORDS)+".png", 'PNG')



def blend(img1, img2):
    switch = random.randint(1, 4)
    if switch == 1:
        print('screen')
        return ImageChops.screen(img1, img2)
    if switch == 2:
        print('difference')
        return ImageChops.difference(img1, img2)
    if switch == 3:
        print('darker')
        return ImageChops.darker(img1, img2)
    if switch == 4:
        print('multiply')
        return ImageChops.multiply(img1, img2)
    if switch == 5:
        print('blend')
        return ImageChops.blend(img1, img2, .5)


_main_()