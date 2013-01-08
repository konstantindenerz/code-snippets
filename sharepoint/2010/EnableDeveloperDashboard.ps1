$dashboard = [Microsoft.SharePoint.Administration.SPWebService]::ContentService.DeveloperDashboardSettings;
$dashboard.DisplayLevel = 'OnDemand';
$dashboard.TraceEnabled = $true;
$dashboard.Update();