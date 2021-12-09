# Set NumThreads to the number of cores your CPU has.
# If your CPU has HyperThreading, use the full thread count.
$NumThreads = 8

ForEach ($loop in 1..$NumThreads) {
    Start-Job -ScriptBlock {
        [float]$result = 1
        while ($true) {
            [float]$x = get-random -Minimum 1 -Maximum 999999999
            $result = $result * $x
        }
    }
}