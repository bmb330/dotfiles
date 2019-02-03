-- original content
--std = "max+love"

-- Create symbolic link of this file into this directory: %LOCALAPPDATA%\Luacheck\.luacheckrc

-- Include 'love' into the global pool (read/write)
std = {
  globals = {"love"}
}

-- Include all source sub-dirs or file paths relative to the root dir:
include_files = {
                  "./lib/",
                  "./src/",
                  "main.lua"
                } 

-- Message codes to filter out:
-- https://luacheck.readthedocs.io/en/stable/warnings.html
-- 611 A line consists of nothing but white space
-- 612 A line contains trailing white space
-- 614 Trailing white space in a comment
-- 631 line is too long
-- 311 value assigned to variable x is unused
-- 113 accessing undefined variable x 
-- 111 setting non-standard global variable x
-- 411 variable x was previously defined on line
-- 542 empty if branch
-- 422 shadowing definition of argument
-- 421 shadowing definition of variable
--ignore = {"611", "612", "614", "631", "311", "113", "111", "411", "542", "422", "421"}
