<?php
$local_ips = array();
$base = "192.168.3.";
for($i = 1; $i < 255; $i++){
  array_push($local_ips, $base . $i);
}



$CONFIG = array (
  'activity_expire_days' => 365,
  'log.conditions' =>
  array (
    0 =>
    array (
      'apps' =>
      array (
        0 => 'admin_audit',
      ),
      'logfile' => '/var/www/owncloud/data/admin_audit.log',
    ),
  ),
  'admin_audit.groups' =>
  array (
    0 => 'group1',
    1 => 'group2',
  ),
  'files_antivirus.av_path' => '/usr/bin/clamscan',
  'files_antivirus.av_cmd_options' => '',
  'versions_retention_obligation' => 'auto',
  'customclient_desktop' => 'https://owncloud.com/desktop-app/',
  'customclient_android' => 'https://play.google.com/store/apps/details?id=com.owncloud.android',
  'customclient_ios' => 'https://apps.apple.com/app/id1359583808',
  'ldapIgnoreNamingRules' => false,
  'user_ldap.enable_medial_search' => false,
  'appstoreurl' => 'https://marketplace.owncloud.com',
  'metrics_shared_secret' => 'replace-with-your-own-random-string',
  'wopi.token.key' => 'replace-with-your-own-random-string',
  'wopi.office-online.server' => 'https://your.office.online.server.tld',
  'wopi_group' => '',
  'msteamsbridge' =>
  array (
    'loginButtonName' => 'Login to ownCloud with Azure AD',
  ),
  'openid-connect' =>
  array (
    'auto-provision' =>
    array (
      'enabled' => false,
    ),
    'provider-url' => 'http://localhost:3000',
    'client-id' => 'ownCloud',
    'client-secret' => 'ownCloud',
    'loginButtonName' => 'node-oidc-provider',
    'mode' => 'userid',
    'search-attribute' => 'sub',
    'use-token-introspection-endpoint' => true,
    'insecure' => true,
  ),
  'collabora_group' => '',
  'wnd.listen.reconnectAfterTime' => 28800,
  'wnd.logging.enable' => false,
  'wnd.storage.testForHiddenMount' => true,
  'wnd.in_memory_notifier.enable' => true,
  'wnd.permissionmanager.cache.size' => 512,
  'wnd2.cachewrapper.ttl' => 1800,
  'wnd.activity.registerExtension' => false,
  'wnd.activity.sendToSharees' => false,
  'wnd.groupmembership.checkUserFirst' => false,
  'workflow.retention_engine' => 'tagbased',
  'instanceid' => 'ocuzac7p29vn',
  'passwordsalt' => '26H+BRMM3LUoYJF2bjDib8W1MDm/Vq',
  'secret' => 'V2MKwZeeY0iH84h2m/nAWpolDlg+OguuF6lFYNMb+GfWqQPM',
  'trusted_domains' =>
  array (
    0 => 'pilamp.local',
  ),
  'datadirectory' => '/var/www/html/support/owncloud/data',
  'overwrite.cli.url' => 'http://pilamp.local/support/owncloud',
  'dbtype' => 'sqlite3',
  'version' => '10.8.0.4',
  'logtimezone' => 'UTC',
  'apps_paths' =>
  array (
    0 =>
    array (
      'path' => '/var/www/html/support/owncloud/apps',
      'url' => '/apps',
      'writable' => false,
    ),
    1 =>
    array (
      'path' => '/var/www/html/support/owncloud/apps-external',
      'url' => '/apps-external',
      'writable' => true,
    ),
  ),
  'installed' => true,

  'trusted_domains' =>
  array (
    0 => 'dietpi.local',
    1 => 'pilamp.local',
    2 => '100.67.106.122',
    3 => '100.67.106.123',
    4 => '77.174.196.28',
    5 => 'fugro.com',
    6 => '100.91.13.21',
    7 => 'RP4.local',
    8 => '100.98.51.44' ,
  ),


);
