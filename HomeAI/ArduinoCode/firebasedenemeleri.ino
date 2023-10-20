#include <ESP8266WiFi.h>
#include <FirebaseArduino.h>


#define FIREBASE_HOST "denemestaj-14fa6-default-rtdb.firebaseio.com"
#define FIREBASE_AUTH "PqYQs41nxwYsebeGe8RYw54jl9hrmSMxS9XtS0G7"

const char* ssid = "Rigel"; //Enter SSID
const char* password = "1234567f"; //Enter Password
#define LED 5
#define ROLE 2

double sicaklik;
double sensor_deger;
double sicaklik_gerilim;

void setup(void)
{ 
  Serial.begin(9600);
  pinMode(LED,OUTPUT);
  pinMode(ROLE,OUTPUT);

  digitalWrite(LED,LOW);
  digitalWrite(ROLE, LOW);
  // Connect to WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) 
  {
     delay(500);
     Serial.print("*");
  }
  
  Serial.println("");
  Serial.println("WiFi connection Successful");
  Serial.print("The IP Address of ESP8266 Module is: ");
  Serial.print(WiFi.localIP());// Print the IP address

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);

}

void loop() 
{
  //LAMBA AYARLARI BURDA
   int lamba = Firebase.getInt("Led");
   Serial.println(lamba);
   delay(50);

   if(lamba == 1){
    digitalWrite(LED, HIGH);
   }
   else{
    digitalWrite(LED,LOW);
   }
  //LAMBA AYARLARI BİTİŞ BURDA
  //-------------------------------------------------------------
  //RÖLE BAŞLANGIÇ
  int role = Firebase.getInt("Role");
  delay(50);

  if(role == 1)
  {
    digitalWrite(ROLE, LOW);
  }
  else{
    digitalWrite(ROLE, HIGH);
  }
  //RÖLE BİTİŞ
  //-----------------------------------------------------------------------------------
  //SICAKLIK BAŞLANGIÇ
  sicak_olc();

  Firebase.setFloat("Sicaklik", sicaklik);
  if (Firebase.failed()) // Check for errors 
  {
    

  Serial.print("BAĞLANILAMADI:");

  Serial.println(Firebase.error());

  return;

  }
  
  delay(1000);
}

void sicak_olc()
{
  sensor_deger = analogRead(A0);
  sicaklik_gerilim = (sensor_deger / 1023.0)*1000;
  sicaklik = sicaklik_gerilim / 10.0;
}