
import processing.core.*;
import processing.core.PImage;

import com.temboo.core.*;
import com.temboo.Library.eBay.Finding.*;
  
  

// Create a session using your Temboo account application details
TembooSession session = new TembooSession("jacmaykt", "myFirstApp", "6d3bcf767a084968b3a364f5a035865e");



//This is the only area you need to alter. All variable can be
//controlled from this block.

int imageCount = 777;
//the number of images available for use in the mosaic.these images should be saved in the sketch folder and conform to 
//the naming protocol listed below. because these are the images that will make up the larger mosaic they should be saved
//in a small format so as not to take up too much memory. the ones i use are about 75px X 75px

PImage[] pics = new PImage[imageCount];
//array containing all of the images available for use in the mosaic.

int pixelSize = 10;
//the dimension (length and width) of one "pixel" of the mosaic.

String mainImage = "metclub.jpg";
//the name of the main image.

String imageName = "p2.jpg";
//the output of the mosaic.

int tintValue = 30;
//will affect the transparency of a rectangle filled with the region's
//average color. this method is used because reducing the opacity in the 
//tint() funtion reduces the opacity of the entire image, not just the tint
//effect. this tries to mediate that. values are 0-255.

//End of editable values. Everything below this line should be
//left alone.

PImage bgPic;
//the image to be used for the mosaic.

//setup the general color ranges.
int[] greenDark = new int[0];
int[] greenMid = new int[0];
int[] greenBright = new int[0];
int[] redDark = new int[0];
int[] redMid = new int[0];
int[] redBright = new int[0];
int[] blueDark = new int[0];
int[] blueMid = new int[0];
int[] blueBright = new int[0];
int[] greenDark2 = new int[0];
int[] greenMid2 = new int[0];
int[] greenBright2 = new int[0];
int[] redDark2 = new int[0];
int[] redMid2 = new int[0];
int[] redBright2 = new int[0];
int[] blueDark2 = new int[0];
int[] blueMid2 = new int[0];
int[] blueBright2 = new int[0];
FindItemsAdvancedResultSet findItemsAdvancedResults;

public void setup() {
  // Run the FindItemsAdvanced Choreo function
  runFindItemsAdvancedChoreo();
  
  bgPic = loadImage(mainImage);
  int picWidth = bgPic.width;
  int picHeight = bgPic.height;
size(picWidth,picHeight);

colorMode(RGB, 255);


background(bgPic);

findItemsAdvancedResults.searchResult[0].item || [0];
searchResult.item.galleryURL
//this part loads all the images in sequence. the naming of the images can be easily done with
//photoshop's batch tool. the code below is set for a batch of images named as "bg_" followed
//by a four digit sequential serial number.

for
for(int j = 0; j<imageCount; j++) {
  if (j < 10) {
    pics[j] = loadImage("bg_" + "000" + j + ".JPG");
  } 
  else if (j < 100) {
    pics[j] = loadImage("bg_" + "00" + j + ".JPG");
  } 
  else if (j < 1000) {
    pics[j] = loadImage("bg_" + "0" + j + ".JPG");
  } 
  else if (j < 10000) {
    pics[j] = loadImage("bg_" +  j + ".JPG");
  }
}

noLoop();
}

void runFindItemsAdvancedChoreo() {
  // Create the Choreo object using your Temboo session
  FindItemsAdvanced findItemsAdvancedChoreo = new FindItemsAdvanced(session);

  // Set credential
  findItemsAdvancedChoreo.setCredential("Jaclyn");

  // Set inputs
  findItemsAdvancedChoreo.setOutputSelector("GalleryInfo");
  findItemsAdvancedChoreo.setKeywords("junk");

  // Run the Choreo and store the results
   findItemsAdvancedResults = findItemsAdvancedChoreo.run();
  
  // Print results
  println(findItemsAdvancedResults.getResponse());
  

}
public void draw() {
  for (int i = 0; i < pics.length; i++){

      color avColor = averageColor(pics[i]);
      float avBright = averageBrightness(pics[i]);
      int tag = sortImages(avColor, avBright);

      if (tag == 1) {
        redDark = append(redDark, i);
      } 
      else if (tag == 2) {
        redDark2 = append(redDark2, i);
      }
      else if (tag == 3) {
        redMid = append(redMid, i);
      }
      else if (tag == 4) {
        redMid2 = append(redMid2, i);
      }  
      else if (tag == 5) {
        redBright = append(redBright, i);
      } 
      else if (tag == 6) {
        redBright2 = append(redBright2, i);
      } 
      else if (tag == 7) {
        greenDark = append(greenDark, i);
      } 
      else if (tag == 8) {
        greenDark2 = append(greenDark2, i);
      } 
      else if (tag == 9) {
        greenMid = append(greenMid, i);
      } 
      else if (tag == 10) {
        greenMid2 = append(greenMid2, i);
      }
      else if (tag == 11) {
        greenBright = append(greenBright, i);
      } 
      else if (tag == 12) {
        greenBright2 = append(greenBright2, i);
      }
      else if (tag == 13) {
        blueDark = append(blueDark, i);
      } 
      else if (tag == 14) {
        blueDark2 = append(blueDark2, i);
      } 
      else if (tag == 15) {
        blueMid = append(blueMid, i);
      } 
      else if (tag == 16) {
        blueMid2 = append(blueMid2, i);
      } 
      else if (tag == 17) {
        blueBright = append(blueBright, i);
      } 
      else if (tag == 18) {
        blueBright2 = append(blueBright2, i);
      }

    }

    //below is where the magic happens...hopefully.
    for (int u = 0; u < width; u += pixelSize){
      for (int v = 0; v < height; v += pixelSize) {
        PImage mosaicPixel = get(u,v, pixelSize, pixelSize);
        color sampleColor = averageColor(mosaicPixel);
        float sampleBrightness = averageBrightness(mosaicPixel);
        int id = sortImages(sampleColor, sampleBrightness);
        println(id);

        if (id == 0) {
          int tempIndex = randomArrayIndex(imageCount);
          tint(sampleColor);
          image(pics[tempIndex], u,v,pixelSize,pixelSize);
          noTint();
        } 
        else if (id == 1) {
          int aRange = redDark.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = redDark[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          } 
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }
        } 
        else if (id == 2) {
          int aRange = redDark2.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = redDark2[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          } 
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }
        }
        else if (id == 3) {
          int aRange = redMid.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = redMid[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          } 
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }
        } 
        else if (id == 4) {
          int aRange = redMid2.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = redMid2[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          } 
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }
        }
        else if (id == 5) {
          int aRange = redBright.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = redBright[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          }  
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }
        } 
        else if (id == 6) {
          int aRange = redBright2.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = redBright2[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          }  
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }
        } 
        else if (id == 7) {
          int aRange = greenDark.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = greenDark[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          }  
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }
        } 
        else if (id == 8) {
          int aRange = greenDark2.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = greenDark2[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          }  
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }
        } 
        else if (id == 9) {
          int aRange = greenMid.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = greenMid[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          } 
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          } 
        } 
        else if (id == 10) {
          int aRange = greenMid2.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = greenMid2[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          } 
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          } 
        }
        else if (id == 11) {
          int aRange = greenBright.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = greenBright[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          } 
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }  
        } 
        else if (id == 12) {
          int aRange = greenBright2.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = greenBright2[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          } 
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }  
        } 
        else if (id == 13) {
          int aRange = blueDark.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = blueDark[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          } 
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }  
        } 
        else if (id == 14) {
          int aRange = blueDark2.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = blueDark2[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          } 
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }  
        } 
        else if (id == 15) {
          int aRange = blueMid.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = blueMid[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          }  
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }  
        } 
        else if (id == 16) {
          int aRange = blueMid2.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = blueMid2[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          }  
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }  
        }
        else if (id == 17) {
          int aRange = blueBright.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = blueBright[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          } 
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }  
        }
        else if (id == 18) {
          int aRange = blueBright2.length;
          if (aRange > 0) {
            int tempIndex = randomArrayIndex(aRange);
            int imageIndex = blueBright2[tempIndex];
            image(pics[imageIndex], u,v,pixelSize,pixelSize);
            noStroke();
            fill(sampleColor, tintValue);
            rect(u,v,pixelSize, pixelSize);
          } 
          else {
            int tempIndex = randomArrayIndex(imageCount);
            tint(sampleColor);
            image(pics[tempIndex], u,v,pixelSize,pixelSize);
            noTint();
          }  
        }

      }
    }
    save(imageName);
  }

  color averageColor(PImage picture) {
    float r = 0;
    float g = 0;
    float b = 0;

    for(int i = 0; i < picture.pixels.length; i++){
      r += red(picture.pixels[i]);
      g += green(picture.pixels[i]);
      b += blue(picture.pixels[i]);
    }
    r = r / picture.pixels.length;
    g = g / picture.pixels.length;
    b = b / picture.pixels.length;

    color aColor = color(r,g,b);

    return aColor;
  }

  float averageBrightness(PImage picture) {
    float b=0;

    for(int i = 0; i < picture.pixels.length; i++){
      b += brightness(picture.pixels[i]);
    }
    b = b/picture.pixels.length;

    return b;
  }

  /* i was having an issue with a seperate funtion that would organize the photos into their respective
   arrays, so this one will sort the values and then these can be used to drop the photos into the correct
   array. the order will be red, green, blue with each having an order from dark to light...for example,
   3 would be bright red, 7 would be dard blue etc. the sequence goes from 1 - 9
   */
  int sortImages(color avC, float avB) {
    float r = red(avC);
    float g = green(avC);
    float b = blue(avC);
    int value = 0;

    if (r > g && r > b) {
      if (avB >=0 && avB <= 42) {
        value = 1;

      } 
      else if (avB > 42 && avB<= 85) {
        value = 2;

      } 
      else if (avB > 85 && avB <= 127){
        value = 3;

      }
      else if (avB > 127 && avB <= 170){
        value = 4;
      }
      else if (avB > 170 && avB <= 210){
        value = 5;
      }
      else if (avB > 210){
        value = 6;
      }

    } 

    else if (g > r && g > b) {
      if (avB >=0 && avB <= 42) {
        value = 7;

      } 
      else if (avB > 42 && avB<= 85) {
        value = 8;

      } 
      else if (avB > 85 && avB <= 127){
        value = 9;

      }
      else if (avB > 127 && avB <= 170){
        value = 10;
      }
      else if (avB > 170 && avB <= 210){
        value = 11;
      }
      else if (avB > 210){
        value = 12;
      }

    } 
    else if (b >r && b > g) {
      if (avB >=0 && avB <= 42) {
        value = 13;

      } 
      else if (avB > 42 && avB<= 85) {
        value = 14;

      } 
      else if (avB > 85 && avB <= 127){
        value = 15;

      }
      else if (avB > 127 && avB <= 170){
        value = 16;
      }
      else if (avB > 170 && avB <= 210){
        value = 17;
      }
      else if (avB > 210){
        value = 18;
      }
    }

    return value;
  }

  int randomArrayIndex(int range){
    int index;
    index = int(random(range));

    return index;
}

