local MULTICOLOR = {
  _NAME = "FileC",
  _VERSION = 'FileC v0.1.0-rc1',
  _URL = 'https://bitbucket.org/enlab/FileC',
  _MAIL = 'flashhacker1988@gmail.com',
  _LICENSE = [[
    MIT LICENSE
    Copyright (c) 2015 Mikhailenko Alexandr Konstantinovich (a.k.a) Alex M.A.K
    Permission is hereby granted, free of charge, to any person obtaining a
    copy of this software and associated documentation files (the
    "Software"), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    ]],
  _DESCRIPTION = [[
    Copy :-)))
    ]]
}
-- ## References

local io, os, error = io, os, error

-- ## file
--
-- The namespace.
--
local file = {}

-- ### file.exists
--
-- Determine if the file in the `path` exists.
--
-- - `path` is a string.
--
function file.exists(path)
  local file = io.open(path, 'rb')
  if file then file:close() end
  return file ~= nil
end

-- ### file.read
--
-- Return the content of the file by reading the given `path` and `mode`.
--
-- - `path` is a string.
-- - `mode` is a string.
--
function file.read(path, mode)
  mode = mode or '*a'
  local file, err = io.open(path, 'rb')
  if err then error(err) end
  local content = file:read(mode)
  file:close()
  return content
end

-- ### file.write
--
-- Write to the file with the given `path`, `content` and `mode`.
--
-- - `path`    is a string.
-- - `content` is a string.
-- - `mode`    is a string.
--
function file.write(path, content, mode)
  mode = mode or 'w'
  local file, err = io.open(path, mode)
  if err then error(err) end
  file:write(content)
  file:close()
end

-- ### file.copy
--
-- Copy the file by reading the `src` and writing it to the `dest`.
--
-- - `src`  is a string.
-- - `dest` is a string.
--
function file.copy(src, dest) local content = file.read(src) file.write(dest, content) end

-- ### file.move
--
-- Move the file from `src` to the `dest`.
--
-- - `src`  is a string.
-- - `dest` is a string.
--
function file.move(src, dest) os.rename(src, dest) end

-- ### file.remove
--
-- Remove the file from the given `path`.
--
-- - `path` is a string.
--
function file.remove(path) os.remove(path) end

-- ## Exports
--
-- Export `file` as a Lua module.
--
return file
