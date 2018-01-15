public class RainTrash {
  private int num;
  private int[] x;
  private int[] y;
  private int yPos;
  private int icon;
  
  public RainTrash(int num) {
    this.num = num;
    x = new int[num];
    y = new int[num];
    icon = 0;
    for (int i = 0; i < num; i++) {
      x[i] = rand.nextInt(800);
      y[i] = rand.nextInt(930) - 1000;
    }
  }
  
  public void startRain() {
    for (int i = 0; i < num; i++) {
      if (check(x[i], y[i]) == false) {
        image(trash, x[i], y[i]);
        if (icon == 1) {
          image(heart, x[i] + 10, y[i] + 10);
        } else if (icon == 2) {
          image(suitcase, x[i] + 10, y[i] + 10);
        } else {
          image(notebook, x[i] + 10, y[i] + 10);
        }
      }
    }
  }
  
  public void rain(float speed) {
    for (int i = 0; i < num; i++) {
      y[i] += speed;
      if (y[i] >= 900 || check(x[i], y[i]) == true) {
        y[i] = rand.nextInt(930) - 1000;
        x[i] = rand.nextInt(800);
      }
    }
  }
  
  public boolean check(int x, int y) {
    if ((x > mouseX - 100 && x < 
        mouseX + 100) && (y > yPos - 80 && y < yPos + 80)) {
      return true;
    } else {
      return false;
    }
  }
  
  public void setY(int y) {
    this.yPos = y;
  }
  
  public void setIcon(int i) {
    if (i == 1) {
      icon = 1;
    } else if (i == 2) {
      icon = 2;
    } else {
      icon = 3;
    }
  }
  
}