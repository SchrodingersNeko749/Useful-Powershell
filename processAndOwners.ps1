$owners = @{} 
gwmi win32_process |% {try {$owners[$_.handle] = $_.getowner().user} catch{} } 
(get-process | select processname,Id,@{l="Owner";e={$owners[$_.id.tostring()]}})