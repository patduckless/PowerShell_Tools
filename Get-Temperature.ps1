function Get-Temperature {
    $thermalZone = Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi"
    $returnTemp = @()

    # Process temps
    foreach ($temp in $thermalZone.CurrentTemperature) {
        $currentTempKelvin = ($temp / 10)
        $currentTempCelsius = [math]::round($currentTempKelvin - 273.15)
        $currentTempFahrenheit = [math]::round((9 / 5) * $currentTempCelsius + 32)
        $returnTemp += "$currentTempCelsius" + " °C | " + "$currentTempFahrenheit" + " °F"
        $global:numberOfTemps = ($returnTemp).count
    }
    foreach ($return in $returnTemp) {
        if ($return -ge "50") {
            write-host "$return" -ForegroundColor Red
            $global:highTemp++
        }
        else {
            write-host "$return" -ForegroundColor Green
            $global:lowTemp++
        }
    }
}