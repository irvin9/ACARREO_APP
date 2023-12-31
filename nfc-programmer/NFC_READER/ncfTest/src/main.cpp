/*
 * Write personal data of a MIFARE RFID card using a RFID-RC522 reader
 * Uses MFRC522 - Library to use ARDUINO RFID MODULE KIT 13.56 MHZ WITH TAGS SPI W AND R BY COOQROBOT. 
 * -----------------------------------------------------------------------------------------
 *             MFRC522      Arduino       Arduino   Arduino    Arduino          Arduino
 *             Reader/PCD   Uno/101       Mega      Nano v3    Leonardo/Micro   Pro Micro
 * Signal      Pin          Pin           Pin       Pin        Pin              Pin
 * -----------------------------------------------------------------------------------------
 * RST/Reset   RST          9             5         D9         RESET/ICSP-5     RST
 * SPI SS      SDA(SS)      10            53        D10        10               10
 * SPI MOSI    MOSI         11 / ICSP-4   51        D11        ICSP-4           16
 * SPI MISO    MISO         12 / ICSP-1   50        D12        ICSP-1           14
 * SPI SCK     SCK          13 / ICSP-3   52        D13        ICSP-3           15
 *
 * More pin layouts for other boards can be found here: https://github.com/miguelbalboa/rfid#pin-layout
 *
 * Hardware required:
 * Arduino
 * PCD (Proximity Coupling Device): NXP MFRC522 Contactless Reader IC
 * PICC (Proximity Integrated Circuit Card): A card or tag using the ISO 14443A interface, eg Mifare or NTAG203.
 * The reader can be found on eBay for around 5 dollars. Search for "mf-rc522" on ebay.com. 
 */

#include <SPI.h>
#include <MFRC522.h>

#define RST_PIN         9           // Configurable, see typical pin layout above
#define SS_PIN          10          // Configurable, see typical pin layout above

MFRC522 mfrc522(SS_PIN, RST_PIN);   // Create MFRC522 instance
byte writeBuffer[34];
byte readBuffer1[18];
byte readBuffer2[18];

void setup() {
  Serial.begin(115200);        // Initialize serial communications with the PC
  SPI.begin();               // Init SPI bus
  mfrc522.PCD_Init();        // Init MFRC522 card
  Serial.println(F("Write personal data on a MIFARE PICC "));
}

void waitForCard() {
  // Reset the loop if no new card present on the sensor/reader. This saves the entire process when idle.
  while(!mfrc522.PICC_IsNewCardPresent());
  // Select one of the cards
  while(!mfrc522.PICC_ReadCardSerial());
}

void printCardInfo() {
  Serial.print(F("Card UID:"));    //Dump UID
  for (byte i = 0; i < mfrc522.uid.size; i++) {
    Serial.print(mfrc522.uid.uidByte[i] < 0x10 ? " 0" : " ");
    Serial.print(mfrc522.uid.uidByte[i], HEX);
  }
  Serial.print(F(" PICC type: "));   // Dump PICC type
  MFRC522::PICC_Type piccType = mfrc522.PICC_GetType(mfrc522.uid.sak);
  Serial.println(mfrc522.PICC_GetTypeName(piccType));
}

bool autenticate(byte block, MFRC522::MIFARE_Key key) { 
  MFRC522::StatusCode status = mfrc522.PCD_Authenticate(MFRC522::PICC_CMD_MF_AUTH_KEY_A, block, &key, &(mfrc522.uid)); //line 834 of MFRC522.cpp file
  if (status != MFRC522::STATUS_OK) {
    Serial.print(F("Authentication failed: "));
    Serial.println(mfrc522.GetStatusCodeName(status));
    return false;
  }
  Serial.println(F("PCD_Authenticate() success: "));
  return true;
}

void readInfo(byte block, MFRC522::MIFARE_Key key, byte len) {
  if(autenticate(block, key)) {
    Serial.print("Info: ");
    MFRC522::StatusCode status = mfrc522.MIFARE_Read(block, readBuffer1, &len);
    if (status != MFRC522::STATUS_OK) {
      Serial.print(F("Reading failed: "));
      Serial.println(mfrc522.GetStatusCodeName(status));
      return;
    }
  }
}

void writeInfo(byte block, MFRC522::MIFARE_Key key, byte *buffer, byte len) {
  if(autenticate(block, key)) {
    MFRC522::StatusCode  status = mfrc522.MIFARE_Write(block, buffer, len);
    if (status != MFRC522::STATUS_OK) {
      Serial.print(F("MIFARE_Write() failed: "));
      Serial.println(mfrc522.GetStatusCodeName(status));
      return;
    }
    else Serial.println(F("MIFARE_Write() success: "));
  }
}

void printCardBuffer(byte len) {
  for (uint8_t i = 0; i < len; i++) {
    if (readBuffer1[i] != 32) {
      Serial.write(readBuffer1[i]);
    }
  }
  Serial.println(" ");
}

void loop() {
  // Prepare key - all keys are set to FFFFFFFFFFFFh at chip delivery from the factory.
  MFRC522::MIFARE_Key key = {keyByte: {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}};
  byte block;
  byte len;

  waitForCard();
  printCardInfo();
  block = 4;
  len = 18;

  readInfo(block, key, len);
  printCardBuffer(len);

  block = 1;
  readInfo(block, key, len);
  printCardBuffer(len);
  Serial.println();
  Serial.setTimeout(20000L) ;     // wait until 20 seconds for input from serial

  // Ask personal data: Family name
  Serial.println(F("Press any key to write info"));
  while(Serial.available() == 0);
  Serial.println(F("Type truck brand, ending with #"));
  len = Serial.readBytesUntil('#', (char *) writeBuffer, 30) ; // read family name from serial
  for (byte i = len; i < 30; i++) writeBuffer[i] = ' ';     // pad with spaces

  block = 1;
  writeInfo(block, key, writeBuffer, len);
  block = 2;
  writeInfo(block, key, &writeBuffer[16], len);

  // Ask personal data: First name
  Serial.println(F("Press any key to write truck plate"));
  while(Serial.available() == 0);
  Serial.println(F("Type Truck plate, ending with #"));
  len = Serial.readBytesUntil('#', (char *) writeBuffer, 20) ; // read first name from serial
  for (byte i = len; i < 20; i++) writeBuffer[i] = ' ';     // pad with spaces

  block = 4;
  writeInfo(block, key, writeBuffer, len);
  block = 5;
  writeInfo(block, key, &writeBuffer[16], len);

  Serial.print(F("Name: "));

  block = 4;
  len = 18;

  //------------------------------------------- GET FIRST NAME
  readInfo(block, key, len);
  printCardBuffer(len);

  //---------------------------------------- GET LAST NAME

  block = 1;
  readInfo(block, key, len);
  printCardBuffer(len);
  //----------------------------------------

  Serial.println(F("\n**End Reading**\n"));

  delay(1000); //change value if you want to read cards faster

  mfrc522.PICC_HaltA();
  mfrc522.PCD_StopCrypto1();

}
