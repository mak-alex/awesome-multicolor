local util = require('awful.util')
local format = string.format
local playlist = require('101-playlist')

-- Submodule for Digitally Imported radio
local Radio101 = { 
  covers_folder = util.getdir("cache") .. "/101_covers/",
  image_size = 200,
  image_url_fmt = "101.ru/assets/image/%s?size=%dx%d",
}

function Radio101.menu(selection_callback)
   local menu = {}
   local chan_group = {}
   local start_chan, last_chan
   local i = 0
   for i, chan_link in ipairs(playlist.channel_links) do
      local chan = playlist.channels[tostring(chan_link)]
      if (i % 15 == 1) then
         start_chan = chan.name
      end
      table.insert(chan_group, { chan.name, function() selection_callback(chan) end })
      if (i % 15 == 0 or i == #playlist.channel_links) then
         table.insert(menu, { start_chan .. " – " .. chan.name, chan_group })
         chan_group = {}
      end
   end
   return menu
end

-- Returns a file containing a channel cover for the given channel link. First
-- searches in the cache folder. If file is not there, fetches it from the
-- Internet and saves into the cache folder.
function Radio101.get_channel_cover(channel_link)
   local file_path, fetch_req = Radio101.fetch_channel_cover_request(channel_link)
   if fetch_req then
      local f = io.popen(fetch_req)
      f:close()

      -- Let's check if file is finally there, just in case
      if not util.file_readable(file_path) then
         return nil
      end
   end
   return file_path
end

-- Returns a filename of the channel cover and formed wget request that
-- downloads the channel cover for the given channel link name. If the channel
-- cover already exists returns nil as the second argument.
function Radio101.fetch_channel_cover_request(channel_link)
   local chan = Radio101.channels[channel_link]

   local file_path = Radio101.covers_folder .. chan.image

   if not util.file_readable(file_path) then -- We need to download it
      return file_path, format("wget %s -O %s 2> /dev/null",
                               format(Radio101.image_url_fmt, chan.image, Radio101.image_size, Radio101.image_size),
                               file_path)
   else -- Cover already downloaded, return its filename and nil
      return file_path, nil
   end
end

-- Same as get_album_cover, but downloads (if necessary) the cover
-- asynchronously.
function Radio101.get_channel_cover_async(channel_link)
   local file_path, fetch_req = Radio101.fetch_channel_cover_request(channel_link)
   if fetch_req then
      asyncshell.request(fetch_req)
   end
end

-- Checks if track_name is actually a link to Radio101.fm stream. If true returns the
-- file with channel cover for the stream.
function Radio101.try_get_cover(track_name)
   if track_name then
      return Radio101.get_channel_cover(link)
   end
end

-- Same as try_get_cover, but calls get_channel_cover_async inside.
function Radio101.try_get_cover_async(track_name)
   if track_name then
      return Radio101.get_channel_cover_async(link)
   end
end

-- Returns a playable stream URL for the given channel link.
function Radio101.form_stream_url(channel_link)
   return format(channel_link, Radio101.api_key)
end

return Radio101
