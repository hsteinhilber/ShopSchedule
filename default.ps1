Properties {
    $base_dir  = Resolve-Path .
    $configuration = "Debug"
    $lib_dir = "$base_dir\libs"
    $tools_dir = "$base_dir\tools"
    $build_dir = "$base_dir\build\"
    $output_dir = "$build_dir\$configuration"
    $sln_file = "$base_dir\ShopSchedule.sln"
    $msbuild = (Get-ChildItem "$env:windir\Microsoft.NET\Framework\v4.0*\msbuild.exe").FullName
    $nunit = (Get-ChildItem "$tools_dir\nunit\nunit-console.exe").FullName
    $nunit_tests = { "ShopSchedule.Tests.dll" }
}

Include .\psake_ext.ps1

FormatTaskName (("-"*25) + "[{0}]" + ("-"*25))

Task Default -Depends RunTests

Task Clean {
    Remove-Item -Force -Recurse $build_dir -ErrorAction SilentlyContinue
}

Task Init -Depends Clean {
	$projectFiles = Get-ChildItem -Path $base_dir -Include *.csproj -Recurse | 
					Where { $_ -notmatch [regex]::Escape($lib_dir) } | 
					Where { $_ -notmatch [regex]::Escape($tools_dir) }
	
	foreach($projectFile in $projectFiles) {
		
		$projectDir = [System.IO.Path]::GetDirectoryName($projectFile)
		$projectName = [System.IO.Path]::GetFileName($projectDir)
		$asmInfoFile = [System.IO.Path]::Combine($projectDir, [System.IO.Path]::Combine("Properties", "AssemblyInfo.cs"))
		
		Generate-Assembly-Info `
			-ClsCompliant "true" `
			-Title "$projectName" `
			-Description "A schedule writing application for shop based environments." `
			-Company "Harry Steinhilber, Jr." `
			-Product "Shop Scheduler" `
			-File $asmInfoFile
	}
		
	New-Item $build_dir -ItemType Directory -ErrorAction SilentlyContinue
	New-Item $output_dir -ItemType Directory -ErrorAction SilentlyContinue
}

Task Compile -Depends Init {
    Exec { &"$msbuild" "$sln_file" /p:Configuration="$configuration" /p:OutDir="$output_dir\" }
}

Task RunTests -Depends Compile {
  pushd
  cd $output_dir
  foreach($testDLL in $nunit_tests) 
  {
    Write-Host "Testing $testDLL"
    Exec { & "$nunit" /labels /framework=net-40 /xml="$testDLL.Results.xml" }
  }
  popd
}

Task Deploy -Depends RunTests { 
}

Task CreateDocs {
  #& "$msbuild" "$base_dir\ShopSchedule.shfbproj" /p:OutDir="$output_dir\"
}