local json = require'core.lib.json'
function isempty(s)
  return s == nil or (type(s) == "table" and next(s)==nil) or s == ''
end
function String2File(filename, data, verbose)
  if filename and data ~= nil
  then
    local path = filename
    file = assert(io.open(path, "a"))
    io.output(file)
    io.write(data, "\n")
    io.close(file)
    return 0
  else
    --log.warning("not open file to write", verbose)
    return 1
  end
end

function File2String(filename, verbose)
  if not isempty(filename)
  then
    local jsonConfigFile = assert(io.open(filename, "r"))
    local stringFile = jsonConfigFile:read "*a"
    jsonConfigFile:close()
    --log.info("Convert file "..filename.." to string - done", verbose)
    return stringFile
  else
    --log.warning("not open file", self.verbose)
    return 1
  end
end

local settings = json.decode(File2String('./config.json'))
print(settings.themes)
