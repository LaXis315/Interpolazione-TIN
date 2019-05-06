// A = Bn+k

float n(punto p1,punto p2){
  
  float n = -(p1.y-p2.y)/(p1.x-p2.x);
  
  return n;
}

float k(punto p1, punto p2){
  
  float k = -(p1.x+p2.x)  -(pow(p1.y,2)-pow(p2.y,2)) / (p1.x-p2.x);
  
  return k;
}

float r (punto p,float cx, float cy){
  
  float r = sqrt(pow((cx-p.x),2)+pow((cy-p.y),2));  
  
  return r;
}

float cy(punto i, punto k, punto z){
  float cy = (k(i,k)-k(i,z)) / (n(i,z)-n(i,k));  
  return cy/-2;
}

float cx(punto i,punto k,punto z){
  float cx = (cy(i,k,z)*-2)*n(i,k)+k(i,k);
  return cx/-2;
}

void mousePressed(){
  Punti = (punto[])expand(Punti,++Ptotali);
  Punti [Ptotali-1] = new punto(mouseX,mouseY,altitudine,Ptotali-1);  
  altitudine += random(0,10);
  //println(Punti.length);
  Render();
}

void keyPressed(){
  if(int(key) == 100){
    background(255);
    for(punto p: Punti)
      for(int c : p.collegamenti)
        for(int c2 : Punti[c].collegamenti){
          if(c2 == p.n){
            continue;
          }
          for(int c3 : Punti[c2].collegamenti){
            if(c3 == p.n){
              float hm = (p.z + Punti[c].z + Punti[c2].z)/3;
              float R = map(hm,h0,hmax,R0,Rf);
              float G = map(hm,h0,hmax,G0,Gf);
              float B = map(hm,h0,hmax,B0,Bf);
              fill(R,G,B);
              triangle(p.x,p.y,Punti[c].x,Punti[c].y,Punti[c2].x,Punti[c2].y);  
            }
          }
          
        }  
  }
  else{
    Reset();
    Triangolazione(); 
    Render();
  }
    
}

void Render(){
  background(255);  
  stroke(0);  
  strokeWeight(3);
  for(punto n : Punti) //collegamenti
    for(int c = 0; c < n.collegamenti.length; c++){
      int p = n.collegamenti[c];
      line(n.x,n.y,Punti[p].x,Punti[p].y); 
    }
  noStroke();
  fill(#FF0303);
  for(punto p : Punti) //punti
    ellipse(p.x,p.y,Dcerchi,Dcerchi);
}

void Reset(){
  for(punto n : Punti)  
    n.collegamenti = new int[0];
}

void Triangolazione(){
  for(punto i: Punti){  
    for(punto k: Punti){
      if(k.n == i.n){
        continue;
      }
      for(punto z: Punti){
        if(z.n == k.n || z.n == i.n){
          continue;
        }
        float cy = cy(i,k,z);  //centro y
        float cx = cx(i,k,z);  //centro x
        float r = r(i,cx,cy);  //raggio 
        int errori = 0;
        for(punto n : Punti){
          if(n.n == i.n || n.n == k.n || n.n == z.n){
            continue;
          }
          if(r(n,cx,cy) < r){
            errori++;
            //println("errori "+ errori+" " + n.n + " " + Ptotali);
          }
        }
        if(errori == 0){ 
          //println("collegamenti " + i.n+ " "+ k.n + " " + z.n + " "+ Ptotali);
          i.collegamenti = append(i.collegamenti,k.n);
          i.collegamenti = append(i.collegamenti,z.n);  
          k.collegamenti = append(k.collegamenti,i.n);  
          k.collegamenti = append(k.collegamenti,z.n);  
          z.collegamenti = append(z.collegamenti,i.n);  
          z.collegamenti = append(z.collegamenti,k.n);  
        }
      }
    }
  }
}
