{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [vesktop];
  xdg.configFile."vesktop/themes/custom.css".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.dataHome}/themes/vesktop.css";

  xdg.configFile."vesktop/settings.json".text = builtins.toJSON {
    discordBranch = "stable";
    minimizeToTray = true;
    startMinimized = false;
    openDevTools = false;
    hardwareAcceleration = true;
    flavour = "vanilla";
    electronFlags = "--ozone-platform-hint=auto --enable-features=WaylandWindowDecorations";
  };

  xdg.configFile."vesktop/settings/settings.json".text = builtins.toJSON {
    autoUpdate = false;
    notifyAboutUpdates = false;
    autoUpdateNotification = false;
    enabledThemes = [
      "custom.css"
    ];

    plugins = {
      ReadAllNotificationsButton.enabled = true;
      RelationshipNotifier.enabled = true;
      SpotifyShareCommands.enabled = true;
      MessageClickActions.enabled = true;
      ReplaceGoogleSearch.enabled = true;
      FavoriteEmojiFirst.enabled = true;
      GameActivityToggle.enabled = true;
      MoreQuickReactions.enabled = true;
      PlatformIndicators.enabled = true;
      SortFriendRequests.enabled = true;
      FavoriteGifSearch.enabled = true;
      DisableDeepLinks.enabled = true;
      FixImagesQuality.enabled = true;
      FixSpotifyEmbeds.enabled = true;
      FixYoutubeEmbeds.enabled = true;
      PictureInPicture.enabled = true;
      FixCodeblockGap.enabled = true;
      DisableCallIdle.enabled = true;
      SpotifyControls.enabled = true;
      TypingIndicator.enabled = true;
      MentionAvatars.enabled = true;
      MutualGroupDMs.enabled = true;
      ReplyTimestamp.enabled = true;
      YoutubeAdblock.enabled = true;
      VoiceDownload.enabled = true;
      VoiceMessages.enabled = true;
      VolumeBooster.enabled = true;
      BetterFolders.enabled = true;
      MessageLogger.enabled = true;
      SpotifyCrack.enabled = true;
      FriendsSince.enabled = true;
      SilentTyping.enabled = true;
      WhoReacted.enabled = true;
      ViewIcons.enabled = true;
      CallTimer.enabled = true;
      ClearURLs.enabled = true;
      FakeNitro.enabled = true;
      ImageLink.enabled = true;
      IrcColors.enabled = true;
      BlurNSFW.enabled = true;
      Dearrow.enabled = true;
      NoTrack.enabled = true;
      PinDMs.enabled = true;
    };
  };
}
