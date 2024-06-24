with import <nixpkgs> { };


androidenv.emulateApp
{
  name = "emulate-MyAndroidApp";
  platformVersion = "34";
  abiVersion = "x86_64"; # arm64-v8a armeabi-v7a, mips, x86_64
  systemImageType = "google_apis_playstore";

  # configOptions = { "hw.keyboard" = "yes"; };
  # licenseAccepted = true;

}
