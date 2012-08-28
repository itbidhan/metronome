local load, loadstring, loadfile, setfenv = load, loadstring, loadfile, setfenv;
local envload;
local envloadfile;

if setfenv then
	function envload(code, source, env)
		local f, err = loadstring(code, source);
		if f and env then setfenv(f, env); end
		return f, err;
	end

	function envloadfile(file, env)
		local f, err = loadfile(file);
		if f and env then setfenv(f, env); end
		return f, err;
	end
else
	function envload(code, source, env)
		return load(code, source, nil, env);
	end

	function envloadfile(file, env)
		return loadfile(file, nil, env);
	end
end

return { envload = envload, envloadfile = envloadfile };