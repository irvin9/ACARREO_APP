#!/usr/bin/env bash

# Ruta de origen y destino para los archivos plist
googleServicesPlistPath="${PROJECT_DIR}/Runner/GoogleService-Info.plist"
firebaseAppIDFilePath="${PROJECT_DIR}/firebase_app_id_file.json"


# Obtiene los valores necesarios del archivo Info.plist
google_app_id="$FIREBASE_APP_ID_IOS"
project_id="$FIREBASE_PROJECT_ID"
sender_id="$FIREBASE_SENDER_ID"
# Otros valores que necesites obtener del Info.plist


# Crea el contenido del archivo JSON
data='{
 "file_generated_by": "FlutterFire CLI",
 "purpose": "FirebaseAppID & ProjectID for this Firebase app in this directory",
 "GOOGLE_APP_ID": "'"${google_app_id}"'",
 "FIREBASE_PROJECT_ID": "'"${project_id}"'",
 "GCM_SENDER_ID": "'"${sender_id}"'"
}'
# Agrega otros valores según sea necesario

# Guarda el contenido en el archivo JSON
echo "$data" > "$firebaseAppIDFilePath"

# Verifica si se creó exitosamente
if [ -f "$firebaseAppIDFilePath" ]; then
    echo "Archivo firebase_app_id_file.json creado exitosamente en $firebaseAppIDFilePath"
else
    echo "Error al crear el archivo firebase_app_id_file.json"
fi

# Obtiene los valores necesarios del archivo Info.plist
apikey="$FIREBASE_API_KEY_IOS"
sender_id="$FIREBASE_SENDER_ID"
bundleIdentifier="$APP_BUNDLE$APP_SUFFIX"
storage_bucket="$FIREBASE_STORAGE_BUCKET"
# Otros valores que necesites obtener del Info.plist

# Crea el contenido del archivo GoogleService-Info.plist
googleServicesContent='<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>API_KEY</key>
	<string>'"$apikey"'</string>
	<key>GCM_SENDER_ID</key>
	<string>'"$sender_id"'</string>
	<key>PLIST_VERSION</key>
	<string>1</string>
	<key>BUNDLE_ID</key>
	<string>'"$bundleIdentifier"'</string>
	<key>PROJECT_ID</key>
	<string>'"$project_id"'</string>
	<key>STORAGE_BUCKET</key>
	<string>'"$storage_bucket"'</string>
	<key>IS_ADS_ENABLED</key>
	<false></false>
	<key>IS_ANALYTICS_ENABLED</key>
	<true></true>
	<key>IS_APPINVITE_ENABLED</key>
	<true></true>
	<key>IS_GCM_ENABLED</key>
	<false></false>
	<key>IS_SIGNIN_ENABLED</key>
	<true></true>
	<key>GOOGLE_APP_ID</key>
	<string>'"$google_app_id"'</string>
</dict>
</plist>'

# Guarda el contenido en el archivo GoogleService-Info.plist en formato XML
echo "$googleServicesContent" > "$googleServicesPlistPath"

# Verifica si se creó exitosamente
if [ -f "$googleServicesPlistPath" ]; then
 echo "Archivo GoogleService-Info.plist creado exitosamente en $googleServicesPlistPath"
else
 echo "Error al crear el archivo GoogleService-Info.plist"
fi


