{ pkgs, lib, username, wrapFirejailBinary, ... }:

let
  profile = pkgs.writeText "librewolf.local" ''
    noblacklist ''${DOWNLOADS}
    whitelist ''${DOWNLOADS}
    ignore nou2f
    include librewolf.profile
  '';

in {
  programs.librewolf = {
    enable = true;
    package = (wrapFirejailBinary {
      inherit pkgs lib;
      package = pkgs.librewolf;
      profile = profile;
      extraArgs = [ "--dbus-user.talk=org.freedesktop.Notifications" ];
    });
    languagePacks = [
      "en-US"
      "de"
    ];
    policies = {
      BlockAboutConfig = true;
      BlockAboutProfiles = true;
      BlockAboutSupport = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      DisableMasterPasswordCreation = true;
      DisableProfileImport = true;
      DisablePocket = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      ExtensionSettings = {
        "{d634138d-c276-4fc8-924b-40a0ea21d284}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles."${username}" = {
      extraConfig = ''
        user_pref("browser.download.alwaysOpenPanel", false);
        user_pref("browser.download.always_ask_before_handling_new_types", true);
        user_pref("browser.download.manager.addToRecentDocs", false);
        user_pref("browser.download.useDownloadDir", true);
        user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
        user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
        user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
        user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
        user_pref("browser.safebrowsing.downloads.remote.enabled", false);
        user_pref("browser.safebrowsing.malware.enabled", false);
        user_pref("browser.safebrowsing.phishing.enabled", false);
        user_pref("browser.startup.couldRestoreSession.count", 2);
        user_pref("browser.startup.homepage", "about:blank");
        user_pref("browser.startup.page", 3);
        user_pref("browser.uitour.enabled", false);
        user_pref("dom.security.https_only_mode", true);
        user_pref("extensions.formautofill.addresses.enabled", false);
        user_pref("extensions.formautofill.creditCards.enabled", false);
        user_pref("network.predictor.enabled", false);
        user_pref("network.prefetch-next", false);
        user_pref("privacy.clearOnShutdown_v2.browsingHistoryAndDownloads", false);
        user_pref("privacy.clearOnShutdown_v2.cache", true);
        user_pref("privacy.clearOnShutdown_v2.cookiesAndStorage", true);
        user_pref("privacy.clearOnShutdown_v2.downloads", false);
        user_pref("privacy.clearOnShutdown_v2.formdata", false);
        user_pref("privacy.donottrackheader.enabled", true);
        user_pref("privacy.fingerprintingProtection", true);
        user_pref("privacy.history.custom", true);
        user_pref("privacy.resistFingerprinting", false);
        user_pref("security.OCSP.enabled", 1);
        user_pref("security.OCSP.require", true);
        user_pref("security.ssl.require_safe_negotiation", true);
        user_pref("security.tls.enable_0rtt_data", false);
        user_pref("security.tls.version.enable-deprecated", false);
        user_pref("sidebar.visibility", "hide-sidebar");
        user_pref("signon.autofillForms", false);
        user_pref("signon.rememberSignons", false);
        user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
      '';
    };
  };
}
