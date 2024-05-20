### Shit to do

#### Main app
* make image api that returns the url for the image instead of the actual file

#### Ci
* setup CI/CD
  * ~Figure how to do sem ver~ 
    * ~possible github actions using sem ver github action~
  * figure out circle ci builds 
    * ~wire up the config for circle ci~
    * figure out the package format for each platform
    * lib to use https://distributor.leanflutter.dev/
      * android - apk
      * windows - msix
      * macos - dmg
      * linux - 
        * rpm + deb - 
          * pros: easy to do with flutter distributor
          * cons: more ci credits.
        * flatpack - 
          * pros: essentially msix for linux
          * cons: manual config required
      * ios - ipa ( not supported until apple adds sideloading support )
    * will need to add a env file 
      * different icons based on app flavour (main, beta): lib - https://pub.dev/packages/icons_launcher
      * which app packaging format it is distributed in (for the updater)
      * for prod
      * for dev

