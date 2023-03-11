.".\.env.ps1"
$request = Get-Content -Path .\request.txt

# 次に質問する文章を決めます。
$PostBody = @{
    model = 'gpt-3.5-turbo'
}

$PostBody.messages = @(
  @{
    role = 'user'
    content = $instruction + $request
  }
)

# 最後に ChatGPT に質問を投げます
$Response = Invoke-WebRequest `
  -Method Post `
  -Uri $Uri `
  -ContentType 'application/json' `
  -Authentication Bearer `
  -Token (ConvertTo-SecureString -AsPlainText -String $Token) `
  -Body ([System.Text.Encoding]::UTF8.GetBytes(($PostBody | ConvertTo-Json -Compress)))

# 返ってきた回答を表示します
$Answer = ($Response.Content | ConvertFrom-Json).choices[0].message.content
Write-Output $Answer
