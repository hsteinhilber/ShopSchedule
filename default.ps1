Properties {
    $base_dir  = Resolve-Path .
    $configuration = "Debug"
    $lib_dir = "$base_dir\libs"
    $tools_dir = "$base_dir\tools"
    $build_dir = "$base_dir\build\"
    $output_dir = "$build_dir\$configuration"
    $sln_file = "$base_dir\ShopSchedule.sln"
    $msbuild = (Get-ChildItem "$env:windir\Microsoft.NET\Framework\v4.0*\msbuild.exe").FullName
    $nunit = (Get-ChildItem "$tools_dir\nunit\nunit-console-x86.exe").FullName
    $specflow = (Get-ChildItem "$tools_dir\specflow\specflow.exe").FullName
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
		$clsCompliant = (-not $projectName.Contains(".Specs")).ToString().ToLower()
        
		Generate-Assembly-Info `
			-ClsCompliant "$clsCompliant" `
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

  foreach($fileInfo in (ls '*.Tests.dll')) 
  {
    $assembly = $fileInfo.Name
    $xmlFile = $assembly.Substring(0, $assembly.Length - 10) + '.TestResults.xml'
    Exec { & "$nunit" "$assembly" /labels /framework=net-4.0 /xml=$xmlFile  }
  }
  
  popd
}

Task RunSpecs -Depends RunTests {
    pushd
    cd $output_dir
    
    foreach($fileInfo in (ls '*.Specs.dll'))
    {
        $assembly = $fileInfo.Name
        $baseName = $assembly.Substring(0, $assembly.Length - 4)
        $project = "$base_dir\$baseName\$baseName.csproj"
        $xmlFile = $baseName.Substring(0, $baseName.Length - 6) + '.SpecResults.xml'
        $htmlFile = $xmlFile.Substring(0, $xmlFile.Length - 4) + '.html'
        
        Exec { 
            & "$nunit" "$assembly" /labels /framework=net-4.0 /xml=$xmlFile
            & "$specflow" nunitexecutionreport "$project" /xmlTestResult:$xmlFile /out:$htmlFile
            & "$output_dir\$htmlFile"
        }

    }
    popd
}

Task Package -Depends RunTests { 
    Write-Host "Building a deployment package is not currently configured." -ForegroundColor Red
}

Task Install -Depends BuildDeploy, RunTests {
    Write-Host "Directly installing is not currently configured." -ForegroundColor Red
}

Task CreateDocs {
  #& "$msbuild" "$base_dir\ShopSchedule.shfbproj" /p:OutDir="$output_dir\"
}