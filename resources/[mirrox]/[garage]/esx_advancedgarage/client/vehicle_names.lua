function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()

	AddTextEntry('p1', 'McLaren P1')
	AddTextEntry('s500w222', 'Mercedes-Benz S500 W222')
	AddTextEntry('r25', 'Yamaha YZF-R25')
	AddTextEntry('silvia3', 'Nissan Silvia S14 Kouki')
	AddTextEntry('tibmw', 'BMW e36 Comact')
	AddTextEntry('rcf', 'Lexus RCF')
	AddTextEntry('amarok', 'Volkswagen Amarok V6')
	AddTextEntry('gtr', 'Nissan Skyline R35 GTR')
	AddTextEntry('bison', 'Volvo 740 A-Traktor')
	AddTextEntry('impalass', 'Chevrolet Impala')
	AddTextEntry('audirs6tk', 'Audi RS6')
	AddTextEntry('r8v10', 'Audi R8')
	AddTextEntry('exc250sm', 'KTM EXC-F 250 Supermotard 2012')
	AddTextEntry('m5f90', 'BMW M5 F90')
			--Lägg in nya bilar här--
end)