function Usage(){
	'Sets the asselby file version of all AssemblyInfo.cs files in current direction and all subdirectories.'
	'.\UpdateAssemblyFileVersion [DirectoryPath] [FileVersionNumber]'
	'	[DirectoryPath] The directory which is used to find AssemblyInfo.cs files, for example: s:/project/src/'
	'	[IncreaseVersion] The revision number of the file that will be increased if the value is true' 
	'	[FileVersionNumber] Optional - The file version number to set if [IncreaseBuildVersion] is false, for example: 1.1.42.0' 
}

$path = [string]$args[0];
$increaseVersion = [System.Convert]::ToBoolean($args[1])
$version = [string]$args[2];
$assemblyFileVersionPattern = 'AssemblyFileVersion\("[0-9]+(\.([0-9]+|\*)){1,3}"\)'

function UpdateAssemblyFileVersion (){
	$dir = New-Object System.IO.DirectoryInfo $path 
	$assemblyFileVersion = 'AssemblyFileVersion("' + $version + '")';

	if($dir.Exists){
		Get-ChildItem -Path $dir -r -filter AssemblyInfo.cs | ForEach-Object {
				$filename = $_.Directory.ToString() + "\" + $_.Name
				Write-Host Processing $filename
				(Get-Content $filename) | ForEach-Object {
					% {
						$regex = [regex]$assemblyFileVersionPattern
						$matches = $regex.Matches($_)
						if(($matches -ne $null) -and ($matches.Count -eq 1) -and ($increaseVersion)){
							$value = $matches[0].Value
						    $value = $value.Replace('AssemblyFileVersion', '')
							$value = $value.Replace('"', '')
							$value = $value.Replace('(', '')
							$value = $value.Replace(')', '')
							$index = $value.LastIndexOf('.') + 1
							$length = $value.Length
							$buildVersion = [Int]$value.Substring($index, $length - $index)
							$newBuildVersion = $buildVersion+1
							$newFileVersion = $value.Substring(0,$index) + $newBuildVersion
							$test = $_.Replace($value, $newFileVersion)
							$test
						}elseif(($matches -ne $null) -and ($matches.Count -eq 1) -and (!$increaseVersion)){
							$_ -replace $assemblyFileVersionPattern, $assemblyFileVersion
						} else{
							$_
						}
					}
				} | Set-Content $filename
		}
	}
}

UpdateAssemblyFileVersion
