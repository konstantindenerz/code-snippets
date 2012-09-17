$site = Get-SPSite http://<myserver>:<port>
$diskSizeRequired = $site.ContentDatabase.DiskSizeRequired
