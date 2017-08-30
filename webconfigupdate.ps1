#Cria ou atualiza uma chave no AppSettings de um arquivo web.config
#Author: Marcos Guedes

param(  
	[string] $webConfigPath = $(Read-Host -prompt  "Por favor informe o caminho do arquivo web.config"),
	[string] $nameKey = $(Read-Host -prompt  "Por favor informe o nome chave que desejas criar/alterar"),
	[string] $valueKey = $(Read-Host -prompt  "Por favor informe o valor da chave que desejas criar/alterar")
)   

if(test-path $webConfigPath)  
{
  $doc = (Get-Content $webConfigPath) -as [Xml]
  
  $obj = $doc.configuration.appSettings.add | where {$_.Key -eq $nameKey}
  
  if ($obj -ne $null)
  {
	  $obj.value = $valueKey
  }
  else
  {
	  $newAppSettings = $doc.CreateElement("add")
	  $doc.configuration.appSettings.AppendChild($newAppSettings);
	  $newAppSettings.SetAttribute("key", $nameKey)
	  $newAppSettings.SetAttribute("value", $valueKey)
  }  
  $doc.Save($webConfigPath)
  write "Operacao realizada com sucesso"
}
else  
{  
  write-error "Arquivo inexistente"  
} 