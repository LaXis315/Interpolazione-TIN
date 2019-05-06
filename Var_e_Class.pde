class punto{
  
  float x,y,z; //posizione x, y e altitudine.
  int n;  //n = tra i punti quale é
  int collegamenti [] = {};
  
  punto(float posx, float posy, float h, int p){
    x = posx;
    y = posy;
    z = h;
    n = p;
  }
  
}

//Var
punto Punti[] = {};
int Ptotali = 0;
int altitudine = 0;

//grafica
float Dcerchi = 7;
int R0 = 63,G0 = 255,B0 = 0;
int Rf = 118,Gf = 34,Bf = 0;
float h0 = 0, hmax = 100;
