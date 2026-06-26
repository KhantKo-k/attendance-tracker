# Tips

- Generate separate keystore file for debug and upload
- Do not reuse keystore file in different applications

# Generate commands

- cd to your desire location to place your keystore files

>> upload key
```bash
$ keytool -genkey -v -keystore starter-kit-upload-key.jks -alias upload -keyalg RSA -keysize 2048 -validity 10000
```

>> debug key
```bash
$ keytool -genkey -v -keystore starter-kit-debug-key.jks -alias debug -keyalg RSA -keysize 2048 -validity 10000
```

# List key entries stored in the keystore
```bash
$ keytool -list -v -keystore my-keystore.jks
```


# List specific key alias stored in the keystore
```bash
$ key tool -list -v -keystore my-keystore.jks -alias upload
```
