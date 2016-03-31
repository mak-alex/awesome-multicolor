--- Radio 101.ru
---- @author  Alexandr Mikhailenko a.k.a. Alex M.A.K. <alex-m.a.k@yandex.kz>
---- @release $Id: $
---- vim: ts=2 tabstop=2 shiftwidth=2 expandtab
---- vim: retab 
-- TODO
-- - add generator playlist from based url 101.ru
--
--
local util = require('awful.util')
local format = string.format
--local playlist = require('101-playlist')
local playlist = {
  ["channel_links"] = {
    'http://ic2.101.ru:8000/c17_3','http://ic3.101.ru:8000/c17_3','http://ic4.101.ru:8000/c17_3','http://ic2.101.ru:8000/c16_28','http://ic3.101.ru:8000/c16_28','http://ic4.101.ru:8000/c16_28','http://ic2.101.ru:8000/c99_1','http://ic3.101.ru:8000/c99_1','http://ic4.101.ru:8000/c99_1','http://ic2.101.ru:8000/c4_5','http://ic3.101.ru:8000/c4_5','http://ic4.101.ru:8000/c4_5','http://ic2.101.ru:8000/c16_13','http://ic3.101.ru:8000/c16_13','http://ic4.101.ru:8000/c16_13','http://ic2.101.ru:8000/c15_3','http://ic3.101.ru:8000/c15_3','http://ic4.101.ru:8000/c15_3','http://ic2.101.ru:8000/c7_0','http://ic3.101.ru:8000/c7_0','http://ic4.101.ru:8000/c7_0','http://ic2.101.ru:8000/c4_6','http://ic3.101.ru:8000/c4_6','http://ic4.101.ru:8000/c4_6','http://ic2.101.ru:8000/c13_3','http://ic3.101.ru:8000/c13_3','http://ic4.101.ru:8000/c13_3','http://ic2.101.ru:8000/c18_2','http://ic3.101.ru:8000/c18_2','http://ic4.101.ru:8000/c18_2','http://ic2.101.ru:8000/c3_2','http://ic3.101.ru:8000/c3_2','http://ic4.101.ru:8000/c3_2','http://ic2.101.ru:8000/c7_8','http://ic3.101.ru:8000/c7_8','http://ic4.101.ru:8000/c7_8','http://ic2.101.ru:8000/c9_2','http://ic3.101.ru:8000/c9_2','http://ic4.101.ru:8000/c9_2','http://ic2.101.ru:8000/c7_17','http://ic3.101.ru:8000/c7_17','http://ic4.101.ru:8000/c7_17','http://ic2.101.ru:8000/c1_2','http://ic3.101.ru:8000/c1_2','http://ic4.101.ru:8000/c1_2','http://ic2.101.ru:8000/c2_1','http://ic3.101.ru:8000/c2_1','http://ic4.101.ru:8000/c2_1','http://ic2.101.ru:8000/c7_21','http://ic3.101.ru:8000/c7_21','http://ic4.101.ru:8000/c7_21','http://ic2.101.ru:8000/c7_14','http://ic3.101.ru:8000/c7_14','http://ic4.101.ru:8000/c7_14','http://ic2.101.ru:8000/c14_13','http://ic3.101.ru:8000/c14_13','http://ic4.101.ru:8000/c14_13','http://ic2.101.ru:8000/c4_4','http://ic3.101.ru:8000/c4_4','http://ic4.101.ru:8000/c4_4','http://ic2.101.ru:8000/c4_2','http://ic3.101.ru:8000/c4_2','http://ic4.101.ru:8000/c4_2','http://ic2.101.ru:8000/c11_4','http://ic3.101.ru:8000/c11_4','http://ic4.101.ru:8000/c11_4','http://ic2.101.ru:8000/c2_3','http://ic3.101.ru:8000/c2_3','http://ic4.101.ru:8000/c2_3','http://ic2.101.ru:8000/c6_5','http://ic3.101.ru:8000/c6_5','http://ic4.101.ru:8000/c6_5','http://ic2.101.ru:8000/c7_24','http://ic3.101.ru:8000/c7_24','http://ic4.101.ru:8000/c7_24','http://ic2.101.ru:8000/c3_5','http://ic3.101.ru:8000/c3_5','http://ic4.101.ru:8000/c3_5','http://ic2.101.ru:8000/c7_29','http://ic3.101.ru:8000/c7_29','http://ic4.101.ru:8000/c7_29','http://ic2.101.ru:8000/c18_9','http://ic3.101.ru:8000/c18_9','http://ic4.101.ru:8000/c18_9','http://ic2.101.ru:8000/c9_1','http://ic3.101.ru:8000/c9_1','http://ic4.101.ru:8000/c9_1','http://ic2.101.ru:8000/c6_1','http://ic3.101.ru:8000/c6_1','http://ic4.101.ru:8000/c6_1','http://ic2.101.ru:8000/c5_2','http://ic3.101.ru:8000/c5_2','http://ic4.101.ru:8000/c5_2','http://ic2.101.ru:8000/c1_4','http://ic3.101.ru:8000/c1_4','http://ic4.101.ru:8000/c1_4',
  },
  ["channels"] = {
    ['http://ic2.101.ru:8000/c17_3'] = { link='http://ic2.101.ru:8000/c17_3', name='Techno (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c17_3'] = { link='http://ic3.101.ru:8000/c17_3', name='Techno (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c17_3'] = { link='http://ic4.101.ru:8000/c17_3', name='Techno (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c16_28'] = { link='http://ic2.101.ru:8000/c16_28', name='Popsa 101 (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c16_28'] = { link='http://ic3.101.ru:8000/c16_28', name='Popsa 101 (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c16_28'] = { link='http://ic4.101.ru:8000/c16_28', name='Popsa 101 (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c99_1'] = { link='http://ic2.101.ru:8000/c99_1', name='Radio First (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c99_1'] = { link='http://ic3.101.ru:8000/c99_1', name='Radio First (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c99_1'] = { link='http://ic4.101.ru:8000/c99_1', name='Radio First (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c4_5'] = { link='http://ic2.101.ru:8000/c4_5', name='Rossiya Top 50 (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c4_5'] = { link='http://ic3.101.ru:8000/c4_5', name='Rossiya Top 50 (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c4_5'] = { link='http://ic4.101.ru:8000/c4_5', name='Rossiya Top 50 (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c16_13'] = { link='http://ic2.101.ru:8000/c16_13', name='Euro Hits (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c16_13'] = { link='http://ic3.101.ru:8000/c16_13', name='Euro Hits (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c16_13'] = { link='http://ic4.101.ru:8000/c16_13', name='Euro Hits (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c15_3'] = { link='http://ic2.101.ru:8000/c15_3', name='Chillout (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c15_3'] = { link='http://ic3.101.ru:8000/c15_3', name='Chillout (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c15_3'] = { link='http://ic4.101.ru:8000/c15_3', name='Chillout (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c7_0'] = { link='http://ic2.101.ru:8000/c7_0', name='Diskoteka 80-h (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c7_0'] = { link='http://ic3.101.ru:8000/c7_0', name='Diskoteka 80-h (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c7_0'] = { link='http://ic4.101.ru:8000/c7_0', name='Diskoteka 80-h (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c4_6'] = { link='http://ic2.101.ru:8000/c4_6', name='Russian Dance (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c4_6'] = { link='http://ic3.101.ru:8000/c4_6', name='Russian Dance (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c4_6'] = { link='http://ic4.101.ru:8000/c4_6', name='Russian Dance (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c13_3'] = { link='http://ic2.101.ru:8000/c13_3', name='Trance (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c13_3'] = { link='http://ic3.101.ru:8000/c13_3', name='Trance (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c13_3'] = { link='http://ic4.101.ru:8000/c13_3', name='Trance (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c18_2'] = { link='http://ic2.101.ru:8000/c18_2', name='Deep House (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c18_2'] = { link='http://ic3.101.ru:8000/c18_2', name='Deep House (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c18_2'] = { link='http://ic4.101.ru:8000/c18_2', name='Deep House (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c3_2'] = { link='http://ic2.101.ru:8000/c3_2', name='Muzyika Avtoradio (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c3_2'] = { link='http://ic3.101.ru:8000/c3_2', name='Muzyika Avtoradio (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c3_2'] = { link='http://ic4.101.ru:8000/c3_2', name='Muzyika Avtoradio (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c7_8'] = { link='http://ic2.101.ru:8000/c7_8', name='Diskoteka 90-h (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c7_8'] = { link='http://ic3.101.ru:8000/c7_8', name='Diskoteka 90-h (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c7_8'] = { link='http://ic4.101.ru:8000/c7_8', name='Diskoteka 90-h (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c9_2'] = { link='http://ic2.101.ru:8000/c9_2', name='SHanson (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c9_2'] = { link='http://ic3.101.ru:8000/c9_2', name='SHanson (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c9_2'] = { link='http://ic4.101.ru:8000/c9_2', name='SHanson (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c7_17'] = { link='http://ic2.101.ru:8000/c7_17', name='Diskoteka SSSR (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c7_17'] = { link='http://ic3.101.ru:8000/c7_17', name='Diskoteka SSSR (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c7_17'] = { link='http://ic4.101.ru:8000/c7_17', name='Diskoteka SSSR (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c1_2'] = { link='http://ic2.101.ru:8000/c1_2', name='Russkiy Rok (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c1_2'] = { link='http://ic3.101.ru:8000/c1_2', name='Russkiy Rok (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c1_2'] = { link='http://ic4.101.ru:8000/c1_2', name='Russkiy Rok (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c2_1'] = { link='http://ic2.101.ru:8000/c2_1', name='Office Lounge (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c2_1'] = { link='http://ic3.101.ru:8000/c2_1', name='Office Lounge (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c2_1'] = { link='http://ic4.101.ru:8000/c2_1', name='Office Lounge (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c7_21'] = { link='http://ic2.101.ru:8000/c7_21', name='Rock Hits (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c7_21'] = { link='http://ic3.101.ru:8000/c7_21', name='Rock Hits (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c7_21'] = { link='http://ic4.101.ru:8000/c7_21', name='Rock Hits (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c7_14'] = { link='http://ic2.101.ru:8000/c7_14', name='New Age (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c7_14'] = { link='http://ic3.101.ru:8000/c7_14', name='New Age (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c7_14'] = { link='http://ic4.101.ru:8000/c7_14', name='New Age (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c14_13'] = { link='http://ic2.101.ru:8000/c14_13', name='Sex (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c14_13'] = { link='http://ic3.101.ru:8000/c14_13', name='Sex (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c14_13'] = { link='http://ic4.101.ru:8000/c14_13', name='Sex (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c4_4'] = { link='http://ic2.101.ru:8000/c4_4', name='Hot Traxx (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c4_4'] = { link='http://ic3.101.ru:8000/c4_4', name='Hot Traxx (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c4_4'] = { link='http://ic4.101.ru:8000/c4_4', name='Hot Traxx (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c4_2'] = { link='http://ic2.101.ru:8000/c4_2', name='Club Dance (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c4_2'] = { link='http://ic3.101.ru:8000/c4_2', name='Club Dance (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c4_2'] = { link='http://ic4.101.ru:8000/c4_2', name='Club Dance (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c11_4'] = { link='http://ic2.101.ru:8000/c11_4', name='Instrumental (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c11_4'] = { link='http://ic3.101.ru:8000/c11_4', name='Instrumental (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c11_4'] = { link='http://ic4.101.ru:8000/c11_4', name='Instrumental (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c2_3'] = { link='http://ic2.101.ru:8000/c2_3', name='Smooth Jazz (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c2_3'] = { link='http://ic3.101.ru:8000/c2_3', name='Smooth Jazz (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c2_3'] = { link='http://ic4.101.ru:8000/c2_3', name='Smooth Jazz (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c6_5'] = { link='http://ic2.101.ru:8000/c6_5', name='House (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c6_5'] = { link='http://ic3.101.ru:8000/c6_5', name='House (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c6_5'] = { link='http://ic4.101.ru:8000/c6_5', name='House (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c7_24'] = { link='http://ic2.101.ru:8000/c7_24', name='Enigma (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c7_24'] = { link='http://ic3.101.ru:8000/c7_24', name='Enigma (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c7_24'] = { link='http://ic4.101.ru:8000/c7_24', name='Enigma (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c3_5'] = { link='http://ic2.101.ru:8000/c3_5', name='Anekdotyi (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c3_5'] = { link='http://ic3.101.ru:8000/c3_5', name='Anekdotyi (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c3_5'] = { link='http://ic4.101.ru:8000/c3_5', name='Anekdotyi (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c7_29'] = { link='http://ic2.101.ru:8000/c7_29', name='Prikosnovenie (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c7_29'] = { link='http://ic3.101.ru:8000/c7_29', name='Prikosnovenie (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c7_29'] = { link='http://ic4.101.ru:8000/c7_29', name='Prikosnovenie (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c18_9'] = { link='http://ic2.101.ru:8000/c18_9', name='Alternative (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c18_9'] = { link='http://ic3.101.ru:8000/c18_9', name='Alternative (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c18_9'] = { link='http://ic4.101.ru:8000/c18_9', name='Alternative (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c9_1'] = { link='http://ic2.101.ru:8000/c9_1', name='Love Songs (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c9_1'] = { link='http://ic3.101.ru:8000/c9_1', name='Love Songs (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c9_1'] = { link='http://ic4.101.ru:8000/c9_1', name='Love Songs (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c6_1'] = { link='http://ic2.101.ru:8000/c6_1', name='Rossiya 90-h (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c6_1'] = { link='http://ic3.101.ru:8000/c6_1', name='Rossiya 90-h (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c6_1'] = { link='http://ic4.101.ru:8000/c6_1', name='Rossiya 90-h (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c5_2'] = { link='http://ic2.101.ru:8000/c5_2', name='Blues (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c5_2'] = { link='http://ic3.101.ru:8000/c5_2', name='Blues (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c5_2'] = { link='http://ic4.101.ru:8000/c5_2', name='Blues (Gamburg, Germaniya (205)) - 101.ru'},['http://ic2.101.ru:8000/c1_4'] = { link='http://ic2.101.ru:8000/c1_4', name='Rock (Moskva, Rossiya (124)) - 101.ru'},['http://ic3.101.ru:8000/c1_4'] = { link='http://ic3.101.ru:8000/c1_4', name='Rock (Rossiya, Moskva (42)) - 101.ru'},['http://ic4.101.ru:8000/c1_4'] = { link='http://ic4.101.ru:8000/c1_4', name='Rock (Gamburg, Germaniya (205)) - 101.ru'},  
  },
}
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
      if string.find(chan.name, "205")
      then
        table.insert(menu, { chan.name, function() selection_callback(chan) end })
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
