# Test API endpoint
$uri = "http://localhost:5000/api/attendance-import/hods-list"
Write-Host "Calling: $uri"
Write-Host "========================================"

try {
    $response = Invoke-WebRequest -Uri $uri -UseBasicParsing
    Write-Host "Status: $($response.StatusCode)"
    Write-Host "Headers: "
    $response.Headers | Format-Table
    Write-Host "Content:"
    Write-Host $response.Content
} catch {
    Write-Host "Error: $($_.Exception.Message)"
    if ($_.Exception.Response) {
        Write-Host "Status Code: $($_.Exception.Response.StatusCode)"
        Write-Host "Status Description: $($_.Exception.Response.StatusDescription)"
        $reader = New-Object System.IO.StreamReader($_.Exception.Response.GetResponseStream())
        $responseBody = $reader.ReadToEnd()
        Write-Host "Response Body: $responseBody"
    }
}
