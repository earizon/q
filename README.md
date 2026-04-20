# q(uick)

This is by far the custom script I used more in my daily work.

It's just an opinionated  wrapper around standard Linux tools ( find and grep) to quickly search for text (regex) inside files.

The script can be used "as is" or as a reference for more elaborate results.


```
# Simple quick ussage:


$ q "TODO" 
# └───┬──┘
# - search recursively (current directory 
# and children) for text TODO in any file
# in current directory and up-to-4-levels
# in depth in subderectories (good enough for
# many scenarios.)
# - Non interesing directories (node_modules,
#   .venv, ...) are skipt/ignored.
# Add next flags to customize be

# "Advanced" ussage

$ q "TODO" \
  -n "*py"         <·· search only inside files matching *py name
  -l 7             <·· search up to 7 levels in depth in sub.directories.
  -I               <·· search case sensitive. (insensitive by default)

  WARN: Any flag comes after the (regex) search pattern. This allows
  to make the script simple.
```

## Environment Variables

```
$ export Q_FILE_NAME="*py"  # <·· set default file name pattern.               (overloaded if set in command line)
$ export Q_LEVEL=7          # <·· set default subdirectory search depth level. (overloaded is set in command line)
```


- ag "the silver searcher" - [link](https://github.com/ggreer/the_silver_searcher)-  is way faster but it 
  does not come pre-installed and, sometimes, it fails to find results. Also, it can be way slower when 
  there is a "deep" directory layout but we are sure, before start searching, that the interesting 
  results are no more than a few sub-directories "away".
